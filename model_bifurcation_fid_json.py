#!/usr/bin/env python
# -*- coding: utf-8 -*-


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
#from MyFunctions.GetGraph import *
#from MyFunctions.misc_fun import *
from MyFunctions.Noise_Model import *
from MyFunctions.Geometric_Model import *
from MyFunctions.GetBifurcDiameters import *


def truncate(num, n):
	integer = int(num * (10**n))/(10**n)
	return float(integer)

ZoomIn = 1
RandPoint = 0
#CropExt = 20
#FidsOfInterest = ['F-5', 'F-6', 'F-14', 'F-15']
FidsOfInterest = ['F-14', 'F-15']

#########################################################################################################

#
# construct the argument parser and parse the arguments
ap = argparse.ArgumentParser()
#ap.add_argument("-i", "--image", type=str, default='/Users/---/Nextcloud/NeuroVascu/TOFs/Manual_Segm/nrrd_mask/training_BET/17.nrrd',
ap.add_argument("-i", "--image", type=str, default='/Users/---/Nextcloud/NeuroVascu/TOFs/Manual_Segm/nrrd_TOF/training_BET/55.nrrd',
	help="Input 3D image (stack) (.nrrd, .nii or .mha)")
ap.add_argument("-seg", "--seg", type=str, default='/Users/---/Nextcloud/NeuroVascu/TOFs/Manual_Segm/nrrd_mask/training_BET/55.nrrd',
	help="Segmented input 3D image (stack)")
ap.add_argument("-bn", "--BifNum", type=str, default='79',
	help="Position of the bifurcation in the list of bifurcs from the 3D graph")
ap.add_argument("-str", "--SplineStr", type=str, default='8',
	help="Strength of the spline modification (10 to 30)")
ap.add_argument("-f", "--Fid", type=int, default='0',
	help="Specify a Fiducial number (0 for all fiducials)")
ap.add_argument("-j", "--json", type=str, required=True,
	help="path for json file which contains the ground truth  the bif positions")
ap.add_argument("-sigst", "--SigmStart", type=str, default='0.0',
	help="Starting value of the Noise Sigma (prior filtering) (if = 0: random value in [0.5, 2.5])")
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
SigmStart = float(args["SigmStart"])
print('SigmStart=%1.2f' %(SigmStart))
CropSize = int(args["CropSize"])
print('CropSize=%d' %(CropSize))
ShowPlot = int(args["ShowPlot"])
print('ShowPlot=%d' %(ShowPlot))
d3D = int(args["Disp3D"])
print('d3D=%d\n' %(d3D))

if SigmStart == 0.0:
	SigmStart = round(np.random.uniform(0.5, 2.5) , 2)

if SplineStr == 0:
	SplineStr = int(np.random.uniform(2, 10))

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

	#stackSegm2 = maxEntropyTh(stackGray)
	#sitk.WriteImage(sitk.GetImageFromArray(stackSegm2),"/Users/---/Desktop/segmEntropy.nrrd")

	#stackGray = np.copy(stack)
	#if stack.min() < 0:
	#	stack = stack + np.abs(stack.min())
	#stack = np.uint8(stack*255.0/stack.max())
else:		   # Probably a DICOM folder...
	print('Give a 3D stack as an input (.nrrd, .nii or .mha)\n')
	sys.exit(0)
'''
	reader = sitk.ImageSeriesReader()

	dicom_names = reader.GetGDCMSeriesFileNames(inputimage)
	reader.SetFileNames(dicom_names)

	sitkimg = reader.Execute()
	sitkimg = resample_image2(sitkimg, is_label=False)
	spacing=sitkimg.GetSpacing()
	stack = sitk.GetArrayFromImage(sitkimg)
	#if stack.min() < 0:
	#	stack = stack + np.abs(stack.min())
	#stack = np.uint8(stack*255.0/stack.max())
'''

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

node_id = Get_Json_Bifs5(stackSegm, coords_gt_bif)

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



'''
	Loop on all the Fiducials :
'''
if Fid != 0:
	fid_label = ['F-' +str(Fid)]

#for i in range(len(fid_label)):
#	XYZbif = coords_gt_bif[i].astype('int')
#	FidLabel = fid_label[i]
#	BifNum = node_id[i]
#	FidNb = int(FidLabel[FidLabel.find('-')+1:len(FidLabel)])

#for FidLabel in FidsOfInterest:    ## Run only on a predefined set of Fiducials.
for FidLabel in fid_label:    ## Run through all the collected Fiducials.

	FidNb = int(FidLabel[FidLabel.find('-')+1:len(FidLabel)])
	XYZbif = coords_gt_bif[FidNb-1].astype('int')
	BifNum = node_id[FidNb-1]
	FidNb = str(FidNb)

	if (XYZbif[0]+XYZbif[1]+XYZbif[2] != 0):
		print('-----------------------\n')
		print('Processing Fid Nb : ' + FidNb)
		print('-----------------------\n')

		"""
			Building the Binary shape of the bifurcations / branches :
		"""
		CropCoords, CropOrig, CroppedSegm, SplineModelTOF = geometric_model(stackGray, stackSegm, BifNum, SplineStr, CropSize, ShowPlot, RandPoint)

		#sitk.WriteImage(sitk.GetImageFromArray(SplineModelTOF), "/Users/---/desktop/SplineModelTOF.nrrd")

		"""
			Generating the adapted background noise :
		"""
		MaskSplineModelTOF, noisy_model_GM, ArteryAmpl, mu, sigma = noise_model(SplineModelTOF, CropOrig, SigmStart, ZoomIn)

		"""
			A final filtering to smooth little the 3D model... 
		"""
		#noisy_model_GM = gaussian_filter(noisy_model_GM, sigma=1.0)


		''' 
			Saving the 3D stacks :
		'''
		if os.path.exists(FileDir + "/_Fid_" + FidNb + '/') == False:
			os.makedirs(FileDir + "/_Fid_" + FidNb + '/')


		outname_orig = FileDir + "/_Fid_" + FidNb + '/' + FileName + '_Bif=' +str(BifNum) + '_Fid=' + str(FidNb) + '_Orig_.nrrd'

		#outname_spl = FileDir + FileName + '_' + '_ArtAmpl=' + str(ArteryAmpl) + '_mu=' + str(mu) + '_Sigma=' + str(sigma) + '_Bif=' +str(BifNum) + '_Spl=' + str(SplineStr) + '_Fid=' + str(FidNb) + '_BinTrueSpline_.nrrd'
		#outname_spl = uniquify(outname_spl)

		outname_binmod = FileDir + "/_Fid_" + FidNb + '/' + FileName + '_' + '_ArtAmpl=' + str(truncate(ArteryAmpl,2)) + '_mu=' + str(truncate(mu,2)) + '_Sigma=' + str(truncate(sigma,2)) + '_SigSt=' + str(SigmStart) + '_Bif=' +str(BifNum) + '_Spl=' + str(SplineStr) + '_Fid=' + str(FidNb) + '_ED_BinModel_.nrrd'
		outname_binmod = uniquify(outname_binmod)

		outname_binGT = FileDir + "/_Fid_" + FidNb + '/' + FileName + '_Bif=' +str(BifNum) + '_Fid=' + str(FidNb) + '_GT_.nrrd'
		#outname_binGT = uniquify(outname_binGT)

		print("\nSaving original crop as : "); print(outname_orig)
		print("\nSaving Ground Truth segm as : "); print(outname_binGT)
		#print("\nSaving orig spline model as : "); #print(outname_spl)
		print("\nSaving binary model as : "); print(outname_binmod)

		sitk.WriteImage(sitk.GetImageFromArray(np.uint16(CropOrig)), outname_orig)
		#draw3d_mayavi(CropOrig, outname_orig[:-4] + 'x3d')
		sitk.WriteImage(sitk.GetImageFromArray(np.uint8(CroppedSegm)*255), outname_binGT)
		#draw3d_mayavi(CroppedSegm, outname_binGT[:-4] + 'x3d')
		#sitk.WriteImage(sitk.GetImageFromArray(np.uint8(SplineFitTOF)), outname_spl)
		#draw3d_mayavi(SplineFitTOF, outname_spl[:-4] + 'x3d')
		sitk.WriteImage(sitk.GetImageFromArray(np.uint8(MaskSplineModelTOF)), outname_binmod)
		#draw3d_mayavi(SplineModelTOF, outname_binmod[:-4] + 'x3d')


		print("\nSaving noisy model as : ")
		savename2 = FileDir + "/_Fid_" + FidNb + '/' + FileName + '_' + '_ArtAmpl=' + str(truncate(ArteryAmpl,2)) + '_mu=' + str(truncate(mu,2)) + '_Sigma=' + str(truncate(sigma,2)) + '_SigSt=' + str(SigmStart) + '_Bif=' +str(BifNum) + '_Spl=' + str(SplineStr) + '_Fid=' + str(FidNb) + '_ED_NoiseMod_.nrrd'
		savename2 = uniquify(savename2)
		print(savename2)
		print(' ')
		noisy_model_GM[noisy_model_GM < 0] = 0
		sitk.WriteImage(sitk.GetImageFromArray(np.uint16(noisy_model_GM)), savename2)

		#print("std(orig patch) : " +str(CropOrig.std()))
		#print("std(model patch) : " +str(noisy_model_GM.std()))

		print("\nVisualization with ImageJ : \n-----------------------------\nIJ_Display_gt_model "+savename2 + "\n")

		if d3D == 1:

			maxi = max(noisy_model_GM.max(), CropOrig.max())
			mini = max(noisy_model_GM.min(), CropOrig.min())

			buffer = np.zeros((CropOrig.shape[0],3,CropOrig.shape[2]), dtype=np.uint16)
			buffer[:,0,:] = 0
			buffer[:,1,:] = 0
			buffer[:,2,:] = 0

			tmp = np.hstack((CropOrig, buffer))
			Stack = np.hstack((tmp, noisy_model_GM))
			z,y,x = Stack.shape

			rot_stack = np.zeros([z, x, y], dtype=np.float32)
			zr,yr,xr = rot_stack.shape

			for i in range(z):
				rot_stack[:,i,:] = Stack[:,:,i]

			if rot_stack.max() > 255:
				rot_stack = np.float32(rot_stack / rot_stack.max())
				rot_stack = np.uint8(rot_stack*255.)

			viewer = napari.view_image(rot_stack)


			#Display_3D(SplineModelTOF)
			#Display_3D(CroppedSegm)

			Display_dual_3D_grouped(SplineModelTOF, CroppedSegm, savename2)

		print("\n")
