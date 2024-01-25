#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Copyright - Florent Autrusseau
contributor(s) : Florent Autrusseau, Rafic Nader (February 2023)

Florent.Autrusseau@univ-nantes.fr
Rafic.Nader@univ-nantes.fr

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

import napari
import sys
import numpy as np

ver = sys.version_info

def randParam():
	rvec = [2, 3, 4, 5]             # ICA radius
	evec = [1.0, 2.0, 3.0, 4.0]     # elastic deform
	gvec = [0.25, 0.5, 0.75, 1.0]   # ICA growth
	r = int(np.random.randint(4))
	e = int(np.random.randint(4))
	g = int(np.random.randint(4))
	radius = rvec[r]
	elasticStDev = evec[e]
	AGrowth = gvec[g]
	return(radius, elasticStDev, AGrowth)

#[rad, elastd, agr] = randParam()



if ver[0] == 3 and ver[1] == 9 or ver[1] == 10  or ver[1] == 11:
	print("Using Python version {}.{} ... OK !".format(ver[0], ver[1]))
else :
	print('\n\t----------------')
	print('\t   WARNING ! ')
	print('\t----------------')
	print('\t --> Tested only with python versions 3.9 and 3.10...\n\n')
	#sys.exit(0)


#from Misc_code.GetGraph import *
#from Misc_code.misc_fun import *
from MyFunctions.ICA_fun import *
from MyFunctions.Noise_Model import *
from MyFunctions.Geometric_Model import *
from MyFunctions.ICA_noise_generator import *
from MyFunctions.GetBifurcDiameters import *

ZoomIn = 0
RandPoint = 0
AddICA = 1
Show_MotherBranch = 1

################################################################################################################################################
################################################################################################################################################
# construct the argument parser and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-i", "--image", type=str, default='/Users/florent//Nextcloud/NeuroVascu/TOFs/CNN_Dataset/Quelques_TOFs_pour_tests/3.nrrd',
	help="Input 3D image (stack) (.nrrd, .nii or .mha)")
ap.add_argument("-seg", "--seg", type=str, default='/Users/florent/Nextcloud/NeuroVascu/TOFs/CNN_Dataset/Quelques_TOFs_pour_tests/3.seg.nrrd',
	help="Segmented input 3D image (stack)")
ap.add_argument("-bn", "--BifNum", type=str, default='111',
	help="Position of the bifurcation in the list of bifurcs from the 3D graph")
ap.add_argument("-str", "--SplineStr", type=str, default='2',
	help="Strength of the spline modification (10 to 30)")
ap.add_argument("-sigst", "--SigmStart", type=str, default='0.0',
	help="Starting value of the Noise Sigma (prior filtering) (if = 0: random value in [0.5, 2.5])")
ap.add_argument("-sp", "--ShowPlot", type=str, default='0',
	help="Show the 3D plot of the 3 spline functions (1 or 0)")
ap.add_argument("-cs", "--CropSize", type=int, default=64,
	help="Size of the 3D crops to grab around the point of interest")
ap.add_argument("-fid", "--FiducialNb", type=str, default='5',
	help="Fiducial Number, i.e. anatomical label of the bifurcation (in [1,15])")
ap.add_argument("-d3D", "--Disp3D", type=int, default=0,
	help="Display the output 3D model (1 or 0)")

args = vars(ap.parse_args())

#inputimage = "/Volumes/LaCie/CNN_Bif_DataSet_ManualSegm/_Fid_8/12__ArtAmpl=76.25_mu=33.17_Sigma=5.45_Bif=215_Spl=8_Fid=8_BinModel_.nrrd"

inputimage = args["image"]
print('\ninputimage=\'%s\'' %(inputimage))
seg= args["seg"]
print('seg=\'%s\'' %(seg))
BifNum = int(args["BifNum"])
print('BifNum=%d' %(BifNum))
SplineStr = int(args["SplineStr"])
print('SplineStr=%d' %(SplineStr))
SigmStart = float(args["SigmStart"])
print('SigmStart=%1.2f' %(SigmStart))
ShowPlot = int(args["ShowPlot"])
print('ShowPlot=%d' %(ShowPlot))
CropSize = int(args["CropSize"])
print('CropSize=%d' %(CropSize))
FidNb = args["FiducialNb"]
print('FidNb=\'%s\'' %(FidNb))
d3D = int(args["Disp3D"])
print('d3D=%d' %(d3D))

if SigmStart == 0.0:
	SigmStart = round(np.random.uniform(0.5, 2.5) , 2)

if SplineStr == 0:
	SplineStr = int(np.random.uniform(2, 10))

[Radius, SigmaED, AGrowth] = randParam()

print('Radius=%d' %(Radius))
print('SigmaED=%1.2f' %(SigmaED))
print('AGrowth=%1.2f\n' %(AGrowth))


if FidNb not in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15']:
	print('Not considering this bifurcation\n')
	sys.exit()


FileDir = os.path.dirname(os.path.abspath(inputimage)) + '/'
FileNameStack = (os.path.basename(inputimage))
FileName = os.path.splitext(os.path.basename(FileNameStack))[0]


fileext = os.path.splitext(inputimage)[1]
if fileext == '.nii' or fileext == '.mha' or fileext == '.nrrd':
	sitkimg = sitk.ReadImage(inputimage, sitk.sitkUInt16)
	#resampling
	sitkimg = resample_image2(sitkimg, is_label=False)
	#spacing = sitkimg.GetSpacing()
	stackGray = sitk.GetArrayFromImage(sitkimg)


	sitkimgSegm = sitk.ReadImage(seg)
	#resampling
	sitkimgSegm = resample_image2(sitkimgSegm, is_label=False)
	stackSegm = sitk.GetArrayFromImage(sitkimgSegm)

	#stackGray = np.copy(stack)
	#if stack.min() < 0:
	#	stack = stack + np.abs(stack.min())
	#stack = np.uint8(stack*255.0/stack.max())
else:		   # Probably a DICOM folder...
	print('Give a 3D stack as an input (.nrrd, .nii or .mha)\n')
	sys.exit(0)

z,y,x = stackSegm.shape
zG,yG,xG = stackGray.shape

if x != xG or y != yG or z != zG :
	print('\nWARNING : Size Mismatch !\n')



''' 
	Launching the spline model :
	 - Get the 3D graph
	 - Grab one bifurcation from the 3D graph (number = 'bn / BifNum')
	 - Consider all three arteries (of that given bifurcation)
	 - Extract the (x,y,z) coordinates along each artery
	 - Collect the spline parameters that would best fit a given artery
	 - Modify the spline parameters (between the knots) to disturb the curve (add some noise)
	   (but keep the extremities in place)
	 - Convolve the so-obtained skewed skeleton with a 3D sphere (a given thickness)
'''


### Expanding CropSize to have cleaner arteries diameters at the cube borders... ###
#CropSize = CropSize + 20


"""
	Building the Binary shape of the bifurcations / branches :
"""
if AddICA == 1:
	CropCoords, CropOrig, BinCrop, SplineModelTOF, Vascu_Arr, ICA_Arr, MotherBranch, Thromb = geometric_model(stackGray, stackSegm, BifNum, SplineStr, CropSize, ShowPlot, RandPoint, AddICA, Radius, SigmaED, AGrowth)
	#CropCoords, CropOrig, BinCrop, SplineModelTOF, Vascu_Arr, ICA_Arr = geometric_model(stackGray, stackSegm, BifNum, SplineStr, CropSize, ShowPlot, RandPoint, AddICA, Radius, SigmaED)
else:
	CropCoords, CropOrig, BinCrop, SplineModelTOF = geometric_model(stackGray, stackSegm, BifNum, SplineStr, CropSize, ShowPlot, RandPoint, AddICA)


'''
	Generating the adapted background noise :
'''
MaskSplineModelTOF, noisy_model_GM, ArteryAmpl, mu, sigma = noise_model(SplineModelTOF, CropOrig, SigmStart, ZoomIn)

#noisy_model_GM[Weighted_ICA_arr > 0] = Weighted_ICA_arr[Weighted_ICA_arr > 0]


if not (os.path.exists(FileDir+"_ICA_Model/")):
	os.makedirs(FileDir+"_ICA_Model/")

'''    Save the output images :    '''
print("\n")
if AddICA == 1:

	noisy_model_GM = noisy_model_GM * Thromb

	save_Vascu_Arr = FileDir + "_ICA_Model/" + FileName + "_Bif=" + str(FidNb) + "_Spl=" + str(SplineStr) + "_R=" +str(Radius) +"_Sed=" +str(SigmaED) + "_AGr=" + str(AGrowth) + "_Vascu_Arr.nrrd"
	print(save_Vascu_Arr)
	sitk.WriteImage(sitk.GetImageFromArray(np.uint8(Vascu_Arr)*255), save_Vascu_Arr)

	save_ICA_Arr = FileDir + "_ICA_Model/" + FileName + "_Bif=" + str(FidNb) + "_Spl=" + str(SplineStr) + "_R=" +str(Radius) +"_Sed=" +str(SigmaED) + "_AGr=" + str(AGrowth) + "_ICA_Arr.nrrd"
	print(save_ICA_Arr)
	sitk.WriteImage(sitk.GetImageFromArray(np.uint8(ICA_Arr)*255), save_ICA_Arr)

	save_Clean_Vascu = FileDir + "_ICA_Model/" + FileName + "_Bif=" + str(FidNb) + "_Spl=" + str(SplineStr) + "_R=" +str(Radius) +"_Sed=" +str(SigmaED) + "_AGr=" + str(AGrowth) + "_Clean_Vascu.nrrd"
	print(save_Clean_Vascu)
	sitk.WriteImage(sitk.GetImageFromArray(np.uint8(BinCrop)*255), save_Clean_Vascu)

	""" Saving the Vascular tree and ICA as a labelled image : """
	ICA = (np.uint8(Vascu_Arr)*255) - (np.uint8(BinCrop)*255)
	VascuLabels = np.copy((np.uint8(Vascu_Arr)*255))
	VascuLabels[ICA >0] = 128

	save_ICA_label = FileDir + "_ICA_Model/" + FileName + "_Bif=" + str(FidNb) + "_Spl=" + str(SplineStr) + "_R=" + str(Radius) + "_Sed=" + str(SigmaED) + "_AGr=" + str(AGrowth) + "_ICA_Label.nrrd"
	print(save_ICA_label)
	sitk.WriteImage(sitk.GetImageFromArray(np.uint8(VascuLabels)), save_ICA_label)
	""" """

	""" Adding up the ICA onto the original bifurcation image : """
	ICATrueBif = np.uint16(np.copy(CropOrig))
	ICAOnly = np.zeros(ICA_Arr.shape)
	ICA_Arr[ICA_Arr > 0] = 1
	ICAOnly[ICA_Arr > 0] = noisy_model_GM[ICA_Arr > 0]
	## ICAOnly = gaussian_filter(ICAOnly, sigma=0.8)
	ICAspotInOrig = np.uint16(np.copy(CropOrig))
	ICAspotInOrig[ICA_Arr < 1] = 0
	avgICASpot = ICAspotInOrig[np.nonzero(ICAspotInOrig)].mean()
	minICAOnly = ICAOnly[np.nonzero(ICAOnly)].min()
	Delta = avgICASpot - minICAOnly
	ICAOnly[np.nonzero(ICAOnly)] = ICAOnly[np.nonzero(ICAOnly)] + Delta
	ICATrueBif2 = np.maximum(ICATrueBif, ICAOnly)

	[Grad3Dx, Grad3Dy, Grad3Dz] = np.gradient(ICATrueBif2, -1, -1, -1)
	#sitk.WriteImage(sitk.GetImageFromArray(np.float32(Grad3Dx)), "/Users/florent/Desktop/gx.nrrd")

	ring = ndimage.binary_erosion(ICA_Arr).astype(ICA_Arr.dtype)
	ring = ICA_Arr - ring
	ICATrueBif2 = ICATrueBif2 - (ring * Grad3Dx + ring * Grad3Dy + ring * Grad3Dz)
	ICATrueBif2 = gaussian_filter(ICATrueBif2, sigma=0.6)
	'''
	ringD = ndimage.binary_dilation(ICA_Arr).astype(ICA_Arr.dtype)
	ringD = ndimage.binary_dilation(ringD).astype(ringD.dtype)

	ringE = ndimage.binary_erosion(ICA_Arr).astype(ICA_Arr.dtype)
	ringE = ndimage.binary_erosion(ringE).astype(ringE.dtype)

	ring = ringD - ringE
	ringB = gaussian_filter(ring, sigma=1.0)
	sitk.WriteImage(sitk.GetImageFromArray(ringB),"/Users/florent/Desktop/ringB.nrrd")
	ringB = (ringB * 0.1 / ringB.max()) + 1
	ICATrueBif2 = ICATrueBif2 * ringB
	#img = sitk.GetArrayFromImage(sitk.ReadImage("img.nrrd"))
	#ICATrueBif2 = ndimage.convolve(ICATrueBif2, ringB, mode='reflect', cval=0.0)
	'''

	#ICATrueBif2[ICA_Arr < 1] = CropOrig[ICA_Arr < 1]
	save_ICATrueBif = FileDir + "_ICA_Model/" + FileName + "_Bif=" + str(FidNb) + "_Spl=" + str(SplineStr) + "_R=" + str(Radius) + "_Sed=" + str(SigmaED) + "_AGr=" + str(AGrowth) + "_ICA_TrueBif.nrrd"
	print(save_ICATrueBif)
	sitk.WriteImage(sitk.GetImageFromArray(np.uint16(ICATrueBif2)), save_ICATrueBif)
	""" """


save_OrigCrop = FileDir + "_ICA_Model/" + FileName + "_Bif=" + str(FidNb) + "_Spl=" + str(SplineStr) + "_R=" +str(Radius) +"_Sed=" +str(SigmaED) + "_Orig.nrrd"
print(save_OrigCrop)
sitk.WriteImage(sitk.GetImageFromArray(CropOrig), save_OrigCrop)

save_Model = FileDir + "_ICA_Model/" + FileName + "_Bif=" + str(FidNb) + "_Spl=" + str(SplineStr) + '_SigSt=' + str(SigmStart) + "_R=" +str(Radius) +"_Sed=" +str(SigmaED) + "_AGr=" + str(AGrowth) + "_Model.nrrd"
print(save_Model)
sitk.WriteImage(sitk.GetImageFromArray(noisy_model_GM), save_Model)
print("\n")


if d3D == 1:

	maxi = max(noisy_model_GM.max(), CropOrig.max())
	mini = max(noisy_model_GM.min(), CropOrig.min())

	buffer = np.zeros((CropOrig.shape[0],3,CropOrig.shape[2]), dtype=np.uint16)
	buffer[:,0,:] = 0
	buffer[:,1,:] = 0
	buffer[:,2,:] = 0

	tmp = np.hstack((CropOrig, buffer))
	Stack = np.hstack((tmp, noisy_model_GM))
	#Stack = np.hstack((tmp, ICATrueBif2))
	z,y,x = Stack.shape

	rot_stack = np.zeros([z, x, y], dtype=np.float32)
	zr,yr,xr = rot_stack.shape

	for i in range(z):
		rot_stack[:,i,:] = Stack[:,:,i]

	if rot_stack.max() > 255:
		rot_stack = np.float32(rot_stack / rot_stack.max())
		rot_stack = np.uint8(rot_stack*255.)

	viewer = napari.view_image(rot_stack)

	if AddICA == 1:
		if Show_MotherBranch == 1:
			Disp3D_3(Vascu_Arr, ICA_Arr, MotherBranch)
		else:
			Disp3D_2(Vascu_Arr, ICA_Arr)
	else:
		Disp3D(MaskSplineModelTOF)

print("\n")
