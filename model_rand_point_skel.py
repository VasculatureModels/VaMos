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

BifNum = 0
ZoomIn = 0
RandPoint_Or_xyz = 1  # if == 1 : Random Point Along centerlines / if == 2 : provide coordinates (x,y,z)

#########################################################################################################

#
# construct the argument parser and parse the arguments
ap = argparse.ArgumentParser()
#ap.add_argument("-i", "--image", type=str, default='/Users/---/Nextcloud/NeuroVascu/TOFs/Manual_Segm/nrrd_mask/training_BET/17.nrrd',
ap.add_argument("-i", "--image", type=str, default='/Users/---/Nextcloud/NeuroVascu/TOFs/Manual_Segm/nrrd_TOF/training_BET/55.nrrd',
	help="Input 3D image (stack) (.nrrd, .nii or .mha)")
ap.add_argument("-seg", "--seg", type=str, default='/Users/---/Nextcloud/NeuroVascu/TOFs/Manual_Segm/nrrd_mask/training_BET/55.nrrd',
	help="Segmented input 3D image (stack)")
ap.add_argument("-str", "--SplineStr", type=str, default='8',
	help="Strength of the spline modification (10 to 30)")
ap.add_argument("-sigst", "--SigmStart", type=str, default='0.0',
	help="Starting value of the Noise Sigma (prior filtering) (if = 0: random value in [0.5, 2.5])")
ap.add_argument("-Xc", "--Xcoord", type=int, default=100,
	help="Pick the crop from this X coordinate")
ap.add_argument("-Yc", "--Ycoord", type=int, default=100,
	help="Pick the crop from this Y coordinate")
ap.add_argument("-Zc", "--Zcoord", type=int, default=100,
	help="Pick the crop from this Z coordinate")
ap.add_argument("-sp", "--ShowPlot", type=str, default='0',
	help="Show the 3D plot of the 3 spline functions (1 or 0)")
ap.add_argument("-cs", "--CropSize", type=int, default=64,
	help="Size of the 3D crops to grab around the point of interest")
ap.add_argument("-d3D", "--Disp3D", type=int, default=0,
	help="Display the output 3D model (1 or 0)")

args = vars(ap.parse_args())


inputpath= args["image"]
print('\ninputpath=\'%s\'' %(inputpath))
seg= args["seg"]
print('seg=\'%s\'' %(seg))
SplineStr = int(args["SplineStr"])
print('SplineStr=%d' %(SplineStr))
SigmStart = float(args["SigmStart"])
print('SigmStart=%1.2f' %(SigmStart))
if RandPoint_Or_xyz == 2:
	Xc = int(args["Xcoord"])
	print('Xc=%d' % (Xc))
	Yc = int(args["Ycoord"])
	print('Yc=%d' %(Yc))
	Zc = int(args["Zcoord"])
	print('Zc=%d' %(Zc))
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

#if FidNb not in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15']:
#	print('Not considering this bifurcation\n')
#	sys.exit()


FileDir = os.path.dirname(os.path.abspath(inputpath)) + '/'
FileNameStack = (os.path.basename(inputpath))
FileName = os.path.splitext(os.path.basename(FileNameStack))[0]

fileext = os.path.splitext(inputpath)[1]
if fileext == '.nii' or fileext == '.mha' or fileext == '.nrrd':
	sitkimgOr = sitk.ReadImage(inputpath, sitk.sitkUInt16)
	#resampling
	sitkimg = resample_image2(sitkimgOr, is_label=False)
	#spacing = sitkimg.GetSpacing()
	stackGray = sitk.GetArrayFromImage(sitkimg)

	sitkimgSegm = sitk.ReadImage(seg)
	#resampling
	sitkimgSegm = resample_image2(sitkimgSegm, is_label=False)
	stackSegm = sitk.GetArrayFromImage(sitkimgSegm)

	""" 
	sitkimgOr = sitk.ReadImage(inputpath, sitk.sitkUInt16)
	sitkimgSegm = sitk.ReadImage(seg)
	spacingOr = sitkimgOr.GetSpacing()
	if spacingOr[0] != spacingOr[2]:
		#resampling
		sitkimg = resample_image2(sitkimgOr, is_label=False)
		sitkimgSegm = resample_image2(sitkimgSegm, is_label=False)
	else:
		sitkimg = sitkimgOr
	stackGray = sitk.GetArrayFromImage(sitkimg)
	stackSegm = sitk.GetArrayFromImage(sitkimgSegm)
	""" 

	"""
	import nrrd
	NrrdImg = nrrd.read(inputpath)
	stackGray = NrrdImg[0]
	NrrdImgSeg = nrrd.read(seg)
	stackSegm = NrrdImgSeg[0]
	"""
elif fileext == '.tif' or fileext == '.tiff':
	stack = skimage.io.imread(inputpath, plugin='tifffile')
	if stack.min() < 0:
		stack = stack + np.abs(stack.min())
	stackGray = np.uint8(stack*255.0/stack.max())

	stackSegm = skimage.io.imread(seg, plugin='tifffile')
	if stackSegm.min() < 0:
		stackSegm = stackSegm + np.abs(stackSegm.min())
	stackSegm = np.uint8(stack * 255.0 / stackSegm.max())

else:		   # Probably a DICOM folder...
	reader1 = sitk.ImageSeriesReader()
	dicom_names = reader1.GetGDCMSeriesFileNames(inputpath)
	reader1.SetFileNames(dicom_names)

	sitkimg = reader1.Execute()
	stack_before_resampling = sitk.GetArrayFromImage(sitkimg)
	sitkimgR = resample_image2(sitkimg, is_label=False)
	stackGray = sitk.GetArrayFromImage(sitkimgR)


	#reader2 = sitk.ImageSeriesReader()
	#dicom_names2 = reader2.GetGDCMSeriesFileNames(seg)
	#reader2.SetFileNames(dicom_names2)

	#sitkimgSegm = reader2.Execute()
	#stack_before_resamplingSegm = sitk.GetArrayFromImage(sitkimgSegm)
	#sitkimgSegm = resample_image2(sitkimgSegm, is_label=False)
	#stackSegm = sitk.GetArrayFromImage(sitkimgSegm)

	sitkimgSegm = sitk.ReadImage(seg)
	#resampling
	sitkimgSegm = resample_image2(sitkimgSegm, is_label=False)
	stackSegm = sitk.GetArrayFromImage(sitkimgSegm)


	#print('Give a 3D stack as an input (.nrrd, .nii or .mha)\n')
	#sys.exit(0)


z,y,x = stackSegm.shape
zG,yG,xG = stackGray.shape

if x != xG or y != yG or z != zG :
	print('\nWARNING : Size Mismatch !\n')


''' 
	Launching the spline model :
	 - Get the 3D graph
	 - Randomly grab a location onto the 3D graph
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
if RandPoint_Or_xyz == 1:
	CropCoords, CropOrig, CroppedSegm, SplineModelTOF = geometric_model(stackGray, stackSegm, BifNum, SplineStr, CropSize, ShowPlot, RandPoint_Or_xyz)
elif RandPoint_Or_xyz == 2:
	CropCoords, CropOrig, CroppedSegm, SplineModelTOF = geometric_model(stackGray, stackSegm, BifNum, SplineStr, CropSize, ShowPlot, RandPoint_Or_xyz, Xc, Yc, Zc)


"""
	Generating the adapted background noise :
"""
MaskSplineModelTOF, noisy_model_GM, ArteryAmpl, mu, sigma = noise_model(SplineModelTOF, CropOrig, SigmStart, ZoomIn)



''' 
	Saving the 3D stacks :
'''
if os.path.exists(FileDir + '/_Segm/') == False:
	os.makedirs(FileDir + '/_Segm/')

Xc = CropCoords[0]
Yc = CropCoords[1]
Zc = CropCoords[2]

outname_orig = FileDir + '_Segm/' + FileName + '_XYZ=' + str(Xc) + '_' + str(Yc) + '_' + str(Zc) + '_Orig_.nrrd'

#outname_spl = FileDir + FileName + '_' + '_mu=' + str(mu) + '_Sigma=' + str(sigma) + '_Spl=' + str(SplineStr) + '_Fid=' + str(FidNb) + '_BinTrueSpline_.nrrd'
#outname_spl = uniquify(outname_spl)

outname_binmod = FileDir + '_Segm/' + FileName + '_XYZ=' + str(Xc) + '_' + str(Yc) + '_' + str(Zc) + '_mu=' + str(truncate(mu,2)) + '_Sigma=' + str(truncate(sigma,2)) + '_SigSt=' + str(SigmStart) + '_Spl=' + str(SplineStr) + '_ED_BinModel_.nrrd'
outname_binmod = uniquify(outname_binmod)

outname_binGT = FileDir + '_Segm/' + FileName + '_XYZ=' + str(Xc) + '_' + str(Yc) + '_' + str(Zc) + '_GT_.nrrd'
#outname_binGT = uniquify(outname_binGT)

print("\nSaving original crop as : "); print(outname_orig)
print("\nSaving Ground Truth segm as : "); print(outname_binGT)
#print("\nSaving orig spline model as : "); print(outname_spl)
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
savename2 = FileDir + '_Segm/' + FileName + '_XYZ=' + str(Xc) + '_' + str(Yc) + '_' + str(Zc) + '_mu=' + str(truncate(mu,2)) + '_Sigma=' + str(truncate(sigma,2)) + '_SigSt=' + str(SigmStart) + '_Spl=' + str(SplineStr) + '_ED_NoiseMod_.nrrd'
savename2 = uniquify(savename2)
print(savename2)
print(' ')
noisy_model_GM[noisy_model_GM < 0] = 0
sitk.WriteImage(sitk.GetImageFromArray(np.uint16(noisy_model_GM)), savename2)

#print("std(orig patch) : " +str(CropOrig.std()))
#print("std(model patch) : " +str(noisy_model_GM.std()))


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

