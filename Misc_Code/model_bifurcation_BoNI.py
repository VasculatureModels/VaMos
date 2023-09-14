#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Copyright - <---->
contributor(s) : <---->, <----> (February 2023)

<----@----.-->
<----@----.-->

This software is a computer program whose purpose is to detect cerebral
vascular tree bifurcations within MRA-TOF acquisitions.

This software is governed by the CeCILL  license under French law and
abiding by the rules of distribution of free software.  You can  use,
modify and/ or redistribute the software under the terms of the CeCILL
license as circulated by CEA, CNRS and INRIA at the following URL
"http://www.cecill.info".

As a counterpart to the access to the source code and  rights to copy,
modify and redistribute granted by the license, users are provided only
with a limited warranty  and the software's author,  the holder of the
economic rights,  and the successive licensors  have only  limited liability.

In this respect, the user's attention is drawn to the risks associated
with loading,  using,  modifying and/or developing or reproducing the
software by the user in light of its specific status of free software,
that may mean  that it is complicated to manipulate,  and  that  also
therefore means  that it is reserved for developers  and  experienced
professionals having in-depth computer knowledge. Users are therefore
encouraged to load and test the software's suitability as regards their
requirements in conditions enabling the security of their systems and/or
data to be ensured and,  more generally, to use and operate it in the
same conditions as regards security.

The fact that you are presently reading this means that you have had
knowledge of the CeCILL license and that you accept its terms.
"""

## https://stackoverflow.com/questions/46721462/getting-a-good-interpolation-fit-for-1d-curve-in-3d-space-python

''' 
########################################################################
# Full Process :
# --------------
#
# - Read a 3D MRA-TOF
# - Segmentation (optional) + Skeletonization + 3D graph
# - Grab one bifurcation from the 3D graph (number = 'bn')
# - Consider all three arteries (of that given bifurcation)
# - Extract the (x,y,z) coordinates along each artery
# - Collect the spline parameters that would best fit a given artery
# - Modify the spline parameters (between the knots) to disturb the curve (add some noise)
#   (but keep the extremities in place)
# - Convolve the so-obtained skewed skeleton with a 3D sphere (a given thickness)
# 
########################################################################
'''


import napari
import sys
import json

''' 
def draw3d_mayavi(array, path):
	mlab.contour3d(array.astype(np.int32)) # a window would pop up
	mlab.savefig(path)
	mlab.clf() # clear the scene to generate a new one
''' 

###   Local imports :   ###
sys.path.insert(1, '../')
from MyFunctions.Noise_Model import *
from MyFunctions.Geometric_Model import *
from MyFunctions.GetBifurcDiameters import *


def truncate(num, n):
	integer = int(num * (10**n))/(10**n)
	return float(integer)

ZoomIn = 1
RandPoint = 2
#CropExt = 20
#FidsOfInterest = ['F-5', 'F-6', 'F-14', 'F-15']

#########################################################################################################

#
# construct the argument parser and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-i", "--image", type=str, default='/Users/----/Nextcloud/NeuroVascu/TOFs/Manual_Segm/nrrd_TOF/training_BET/55.nrrd',
	help="Input 3D image (stack) (.nrrd, .nii or .mha)")
ap.add_argument("-seg", "--seg", type=str, default='/Users/----/Nextcloud/NeuroVascu/TOFs/Manual_Segm/nrrd_mask/training_BET/55.nrrd',
	help="Segmented input 3D image (stack)")
ap.add_argument("-bn", "--BifNum", type=str, default='79',
	help="Position of the bifurcation in the list of bifurcs from the 3D graph")
ap.add_argument("-str", "--SplineStr", type=str, default='8',
	help="Strength of the spline modification (10 to 30)")
ap.add_argument("-f", "--Fid", type=int, default='0',
	help="Specify a Fiducial number (0 for all fiducials)")
ap.add_argument("-j", "--json", type=str, required=True,
	help="path for json file which contains the ground truth  the bif positions")
ap.add_argument("-sigst", "--SigmStart", type=str, default='6',
	help="Starting value of the Noise Sigma (prior filtering) (in [2, 6] preferably)")
ap.add_argument("-sp", "--ShowPlot", type=str, default='0',
	help="Show the 3D plot of the 3 spline functions (1 or 0)")
ap.add_argument("-cs", "--CropSize", type=int, default=32,
	help="Size of the 3D crops to grab around the point of interest")
ap.add_argument("-fid", "--FiducialNb", type=str, default='5',
	help="Fiducial Number, i.e. anatomical label of the bifurcation (in [1,15])")
ap.add_argument("-d3D", "--Disp3D", type=int, default=0,
	help="Display the output 3D model (1 or 0)")

args = vars(ap.parse_args())




inputimage= args["image"]
print('\ninputimage=\'%s\'' %(inputimage))
seg= args["seg"]
print('seg=\'%s\'' %(seg))
Json = args["json"]
print('Json=\'%s\'' %(Json))
BifNum = int(args["BifNum"])
print('BifNum=%d' %(BifNum))
SplineStr = int(args["SplineStr"])
print('SplineStr=%d' %(SplineStr))
Fid = int(args["Fid"])
print('Fid=%d' %(Fid))
SigmStart = int(args["SigmStart"])
print('SigmStart=%d' %(SigmStart))
CropSize = int(args["CropSize"])
print('CropSize=%d' %(CropSize))
ShowPlot = int(args["ShowPlot"])
print('ShowPlot=%d' %(ShowPlot))
d3D = int(args["Disp3D"])
print('d3D=%d\n' %(d3D))


FileDir = os.path.dirname(os.path.abspath(inputimage)) + '/'
FileNameStack = (os.path.basename(inputimage))
FileName = os.path.splitext(os.path.basename(FileNameStack))[0]

spacing=1

fileext = os.path.splitext(inputimage)[1]
if fileext == '.nii' or fileext == '.mha' or fileext == '.nrrd':
	sitkimg = sitk.ReadImage(inputimage, sitk.sitkUInt16)
	#resampling
	sitkimg = resample_image2(sitkimg, is_label=False)
	#spacing = sitkimg.GetSpacing()
	stackGray = sitk.GetArrayFromImage(sitkimg)

	sitkimgSegm = sitk.ReadImage(seg)
	#resampling
	sitkimgSegm = resample_image2(sitkimgSegm, is_label=True)   ## <-- if segmented image : then is_label = True !
	stackSegm = sitk.GetArrayFromImage(sitkimgSegm)

else:		   # Probably a DICOM folder...
	print('Give a 3D stack as an input (.nrrd, .nii or .mha)\n')
	sys.exit(0)

z,y,x = stackSegm.shape
zG,yG,xG = stackGray.shape

if x != xG or y != yG or z != zG :
	print('\nWARNING : Size Mismatch !\n')


'''
	Read Json File:
'''
f = open(Json)
data = json.load(f)

coords_gt_bif = []
fid_label = []
for i in range(len(data['markups'][0]['controlPoints'])):
	coords_gt_bif.append(np.abs(data['markups'][0]['controlPoints'][i]['position']))
	fid_label.append(data['markups'][0]['controlPoints'][i]['label'])

#[coords_gt_bif, node_id] = Get_Json_Bifs2(stackSegm, coords_gt_bif)

node_id = Get_Json_Bifs4(stackSegm, coords_gt_bif)

""" """
print('------------------------------------------------------------------------------------\n')
k=0
for i in node_id:
	print('coords (x,y,z): ' +  str(int(coords_gt_bif[k][0])) + ', ' +
		str(int(coords_gt_bif[k][1])) + ', ' +
		str(int(coords_gt_bif[k][2])) + '\t' +
		'Fid:' + str(fid_label[k]) + ',\t' +
		'bif nb: ' + str(i))
	k+=1
print('------------------------------------------------------------------------------------\n')
""" """


'''
	Loop on all the Fiducials :
'''
if Fid != 0:
	fid_label = ['F-' +str(Fid)]


for FidLabel in fid_label:    ## Run through all the collected Fiducials.

	FidNb = int(FidLabel[FidLabel.find('-')+1:len(FidLabel)])
	XYZbif = coords_gt_bif[FidNb-1].astype('int')
	BifNum = node_id[FidNb-1]
	FidNb = str(FidNb)

	"""
		remove the neighborhood of each bifurcation of interest :
	"""
	for cb in range(len(coords_gt_bif)):
		xb = int(coords_gt_bif[cb][0])
		yb = int(coords_gt_bif[cb][1])
		zb = int(coords_gt_bif[cb][2])
		stackSegm[zb-16:zb+16, yb-16:yb+16, xb-16:xb+16] = 0

CropExt = 30
### Expanding CropSize to have cleaner arteries diameters at the cube borders... ###
CropSize = CropSize + CropExt

z, y, x = stackGray.shape

graph = GetGraph2(stackSegm.astype(np.uint8))

""" 
	(1) Randomly pick a bifurcation, 
	(2) Randomly pick a branch from that bifurcation, and
	(3) Randomly pick a voxel in the branch
"""
Xc = 0; Yc = 0; Zc = 0;
while Xc < int(CropSize / 2) or Yc < int(CropSize / 2) or Zc < int(CropSize / 2) or Xc > x - int(
		CropSize / 2) or Yc > y - int(CropSize / 2) or Zc > z - int(CropSize / 2):
	randBif = random.randint(0, len(graph))
	Nb = list(graph.neighbors(randBif))
	if len(Nb) > 1:
		randBranch = random.randint(0, len(Nb) - 1)
	else:
		randBranch = 0
	Coords_Branch = []
	Coords_Branch.append(graph[randBif][Nb[randBranch]]['pts'])
	lenBr = len(Coords_Branch[0])
	randPt = random.randint(0, lenBr - 1)
	XYZpoint = Coords_Branch[0][randPt]
	Xc = XYZpoint[2]
	Yc = XYZpoint[1]
	Zc = XYZpoint[0]


for i in range(10):
	for SplineStr in [3, 6, 9, 12]:

		"""
			Building the Binary shape of the bifurcations / branches :
		"""
		CropCoords, CropOrig, CroppedSegm, SplineModelTOF = geometric_model(stackGray, stackSegm, BifNum, SplineStr, CropSize, ShowPlot, RandPoint, XYZpoint[2], XYZpoint[1], XYZpoint[0] )

		"""
			Generating the adapted background noise :
		"""
		MaskSplineModelTOF, noisy_model_GM, ArteryAmpl, mu, sigma = noise_model(SplineModelTOF, CropOrig, SigmStart, ZoomIn)

		''' 
			Saving the 3D stacks :
		'''
		if os.path.exists(FileDir + "/_BoNI_Fid" + '/') == False:
			os.makedirs(FileDir + "/_BoNI_Fid" +  '/')

		outname_orig = FileDir + "/_BoNI_Fid" + '/' + FileName + '_Bif=' +str(BifNum) + '_BoNI_xyz=' + str(XYZpoint[2]) + '_' + str(XYZpoint[1]) + '_' + str(XYZpoint[0]) + '_Orig_.nrrd'

		outname_binmod = FileDir + "/_BoNI_Fid" + '/' + FileName + '_' + '_ArtAmpl=' + str(truncate(ArteryAmpl,2)) + '_mu=' + str(truncate(mu,2)) + '_Sigma=' + str(truncate(sigma,2)) + '_SigSt=' + str(SigmStart) + '_Bif=' +str(BifNum) + '_Spl=' + str(SplineStr) + '_BoNI_xyz=' + str(XYZpoint[2]) + '_' + str(XYZpoint[1]) + '_' + str(XYZpoint[0]) + '_ED_BinModel_.nrrd'
		outname_binmod = uniquify(outname_binmod)

		outname_binGT = FileDir + "/_BoNI_Fid" + '/' + FileName + '_Bif=' +str(BifNum) + '_BoNI_xyz=' + str(XYZpoint[2]) + '_' + str(XYZpoint[1]) + '_' + str(XYZpoint[0]) + '_GT_.nrrd'

		print("\nSaving original crop as : "); print(outname_orig)
		print("\nSaving Ground Truth segm as : "); print(outname_binGT)
		print("\nSaving binary model as : "); print(outname_binmod)

		sitk.WriteImage(sitk.GetImageFromArray(np.uint16(CropOrig)), outname_orig)
		sitk.WriteImage(sitk.GetImageFromArray(np.uint8(CroppedSegm)*255), outname_binGT)
		sitk.WriteImage(sitk.GetImageFromArray(np.uint8(MaskSplineModelTOF)), outname_binmod)

		print("\nSaving noisy model as : ")
		savename2 = FileDir + "/_BoNI_Fid" + '/' + FileName + '_' + '_ArtAmpl=' + str(truncate(ArteryAmpl,2)) + '_mu=' + str(truncate(mu,2)) + '_Sigma=' + str(truncate(sigma,2)) + '_SigSt=' + str(SigmStart) + '_Bif=' +str(BifNum) + '_Spl=' + str(SplineStr) + '_BoNI_xyz=' + str(XYZpoint[2]) + '_' + str(XYZpoint[1]) + '_' + str(XYZpoint[0]) + '_ED_NoiseMod_.nrrd'
		savename2 = uniquify(savename2)
		print(savename2)
		print(' ')
		noisy_model_GM[noisy_model_GM < 0] = 0
		sitk.WriteImage(sitk.GetImageFromArray(np.uint16(noisy_model_GM)), savename2)

print("\n")
