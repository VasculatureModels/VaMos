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

sys.path.insert(1, '../')

###   Local imports :   ###
from Misc_code.GetGraph import *
from Misc_code.misc_fun import *
from Misc_code.bif_geom_model_crop_xyz import *
from Misc_code.bif_geom_model_crop_extendCrop_v3 import noise_generator
from Misc_code.GetBifurcDiameters import *


def truncate(num, n):
    integer = int(num * (10**n))/(10**n)
    return float(integer)


#########################################################################################################

#
# construct the argument parser and parse the arguments
ap = argparse.ArgumentParser()
#ap.add_argument("-i", "--image", type=str, default='/Users/---/Nextcloud/NeuroVascu/TOFs/Manual_Segm/nrrd_mask/training_BET/17.nrrd',
ap.add_argument("-i", "--image", type=str, default='/Users/---/Nextcloud/NeuroVascu/TOFs/Manual_Segm/nrrd_TOF/training_BET/55.nrrd',
	help="Input 3D image (stack) (.nrrd, .nii or .mha)")
ap.add_argument("-seg", "--seg", type=str, default='/Users/---/Nextcloud/NeuroVascu/TOFs/Manual_Segm/nrrd_mask/training_BET/55.nrrd',
	help="Segmented input 3D image (stack)")
ap.add_argument("-x", "--X", type=str, default='175',
	help="X coordinate to crop")
ap.add_argument("-y", "--Y", type=str, default='275',
	help="Y coordinate to crop")
ap.add_argument("-z", "--Z", type=str, default='105',
	help="Z coordinate to crop")
#ap.add_argument("-bn", "--BifNum", type=str, default='79',
#	help="Position of the bifurcation in the list of bifurcs from the 3D graph")
ap.add_argument("-str", "--SplineStr", type=str, default='15',
	help="Strength of the spline modification (10 to 30)")
ap.add_argument("-sp", "--ShowPlot", type=str, default='0',
	help="Show the 3D plot of the 3 spline functions (1 or 0)")
ap.add_argument("-cs", "--CropSize", type=int, default=32,
	help="Size of the 3D crops to grab around the point of interest")
ap.add_argument("-fid", "--FiducialNb", type=str, default='5',
	help="Fiducial Number, i.e. anatomical label of the bifurcation (in [1,15])")
ap.add_argument("-d3D", "--Disp3D", type=int, default=0,
	help="Display the output 3D model (1 or 0)")

args = vars(ap.parse_args())




inputpath= args["image"]
print('\ninputpath=\'%s\'' %(inputpath))
seg= args["seg"]
print('seg=\'%s\'' %(seg))
#BifNum = int(args["BifNum"])
#print('BifNum=%d' %(BifNum))
SplineStr = int(args["SplineStr"])
print('SplineStr=%d' %(SplineStr))
Xcoord = np.uint16(args["X"])
print('Xcoord=%d' %(Xcoord))
Ycoord = np.uint16(args["Y"])
print('Ycoord=%d' %(Ycoord))
Zcoord = np.uint16(args["Z"])
print('Zcoord=%d' %(Zcoord))
CropSize = int(args["CropSize"])
print('CropSize=%d' %(CropSize))
ShowPlot = int(args["ShowPlot"])
print('ShowPlot=%d' %(ShowPlot))
FidNb = args["FiducialNb"]
print('FidNb=\'%s\'' %(FidNb))
d3D = int(args["Disp3D"])
print('d3D=%d\n' %(d3D))

if FidNb not in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15']:
	print('This is a Bifurcation of Non-Interest (BoNI)\n')
	#sys.exit()


FileDir = os.path.dirname(os.path.abspath(inputpath)) + '/'
FileNameStack = (os.path.basename(inputpath))
FileName = os.path.splitext(os.path.basename(FileNameStack))[0]

spacing=1

fileext = os.path.splitext(inputpath)[1]
if fileext == '.nii' or fileext == '.mha' or fileext == '.nrrd':
	sitkimg = sitk.ReadImage(inputpath, sitk.sitkUInt16)
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
'''
	reader = sitk.ImageSeriesReader()

	dicom_names = reader.GetGDCMSeriesFileNames(inputpath)
	reader.SetFileNames(dicom_names)

	sitkimg = reader.Execute()
	sitkimg = resample_image2(sitkimg, is_label=False)
	spacing=sitkimg.GetSpacing()
	stack = sitk.GetArrayFromImage(sitkimg)
	#if stack.min() < 0:
	#	stack = stack + np.abs(stack.min())
	#stack = np.uint8(stack*255.0/stack.max())
'''

""" 
	###  IF WE NEED TO CONVERT A 16 BITS PER VOXEL VOLUME INTO 8 BITS PER VOXEL : ###
if stackGray.min() > 20000:
	stackGrayN = np.zeros(stackGray.shape, dtype=np.uint8)
	tmp = (stackGray - stackGray.min()) / (stackGray.max()-stackGray.min())
	stackGrayN = np.uint8(tmp*255)
	sitk.WriteImage(sitk.GetImageFromArray(np.uint8(stackGrayN)), "/Users/florent/Desktop/stackGrayN.nrrd")
	stackGray = np.copy(stackGrayN)
elif stackGray.max() < 0:
	stackp = stack + np.abs(stack.min())
	stackGrayN = np.zeros(stackGray.shape, dtype=np.uint8)
	tmp = (stackp - stackp.min()) / (stackp.max()-stackp.min())
	stackN = np.uint8(tmp*255)
	sitk.WriteImage(sitk.GetImageFromArray(np.uint8(stackN)), imname + '_8b.nrrd')
	stackGray = np.copy(stackGrayN)
"""

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
CropSize = CropSize + 20


"""
	Building the Binary shape of the bifurcations / branches :
"""
CropOrig, CroppedSegm, SplineModelTOF = spline_model_crop_xyz(stackGray, stackSegm, Xcoord, Ycoord, Zcoord, SplineStr, CropSize, ShowPlot)



"""
	Generating the adapted background noise :
"""
MaskSplineModelTOF, noisy_model_GM, ArteryAmpl, mu, sigma = noise_generator(SplineModelTOF, CropOrig, CroppedSegm)



''' 
	Saving the 3D stacks :
'''
if os.path.exists(FileDir + "/_Fid_" + FidNb + '/') == False:
	os.makedirs(FileDir + "/_Fid_" + FidNb + '/')


outname_orig = FileDir + "/_Fid_" + FidNb + '/' + FileName + '_x=' +str(Xcoord) + '_y' +str(Ycoord) + '_z=' +str(Zcoord) + '_Fid=' + str(FidNb) + '_Orig_.nrrd'

#outname_spl = FileDir + FileName + '_' + '_ArtAmpl=' + str(ArteryAmpl) + '_mu=' + str(mu) + '_Sigma=' + str(sigma) + '_Bif=' +str(BifNum) + '_Spl=' + str(SplineStr) + '_Fid=' + str(FidNb) + '_BinTrueSpline_.nrrd'
#outname_spl = uniquify(outname_spl)

outname_binmod = FileDir + "/_Fid_" + FidNb + '/' + FileName + '_' + '_ArtAmpl=' + str(truncate(ArteryAmpl,2)) + '_mu=' + str(truncate(mu,2)) + '_Sigma=' + str(truncate(sigma,2)) + '_x=' +str(Xcoord) + '_y' +str(Ycoord) + '_z=' +str(Zcoord) + '_Spl=' + str(SplineStr) + '_Fid=' + str(FidNb) + '_BinModel_.nrrd'
outname_binmod = uniquify(outname_binmod)

outname_binGT = FileDir + "/_Fid_" + FidNb + '/' + FileName + '_x=' +str(Xcoord) + '_y' +str(Ycoord) + '_z=' +str(Zcoord) + '_Fid=' + str(FidNb) + '_GT_.nrrd'
#outname_binGT = uniquify(outname_binGT)

print("\nSaving original crop as : "); print(outname_orig)
print("\nSaving Ground Truth segm as : "); print(outname_binGT)
#print("\nSaving orig spline model as : "); #print(outname_spl)
print("\nSaving binary model as : "); print(outname_binmod)

sitk.WriteImage(sitk.GetImageFromArray(np.uint16(CropOrig)), outname_orig)
#draw3d_mayavi(CropOrig, outname_orig[:-4] + 'x3d')
sitk.WriteImage(sitk.GetImageFromArray(np.uint16(CroppedSegm)), outname_binGT)
#draw3d_mayavi(CroppedSegm, outname_binGT[:-4] + 'x3d')
#sitk.WriteImage(sitk.GetImageFromArray(np.uint8(SplineFitTOF)), outname_spl)
#draw3d_mayavi(SplineFitTOF, outname_spl[:-4] + 'x3d')
sitk.WriteImage(sitk.GetImageFromArray(np.uint8(SplineModelTOF)), outname_binmod)
#draw3d_mayavi(SplineModelTOF, outname_binmod[:-4] + 'x3d')


print("\nSaving noisy model as : ")
savename2 = FileDir + "/_Fid_" + FidNb + '/' + FileName + '_' + '_ArtAmpl=' + str(truncate(ArteryAmpl,2)) + '_mu=' + str(truncate(mu,2)) + '_Sigma=' + str(truncate(sigma,2)) + '_x=' +str(Xcoord) + '_y' +str(Ycoord) + '_z=' +str(Zcoord) + '_Spl=' + str(SplineStr) + '_Fid=' + str(FidNb) + '_NoiseMod_.nrrd'
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

	buffer = np.zeros((CropOrig.shape[0], 3, CropOrig.shape[2]), dtype=np.uint16)
	buffer[:, 0, :] = 0
	buffer[:, 1, :] = 0
	buffer[:, 2, :] = 0

	tmp = np.hstack((CropOrig, buffer))
	Stack = np.hstack((tmp, noisy_model_GM))
	z, y, x = Stack.shape

	rot_stack = np.zeros([z, x, y], dtype=np.float32)
	zr, yr, xr = rot_stack.shape

	for i in range(z):
		rot_stack[:, i, :] = Stack[:, :, i]

	if rot_stack.max() > 255:
		rot_stack = np.float32(rot_stack / rot_stack.max())
		rot_stack = np.uint8(rot_stack * 255.)

	viewer = napari.view_image(rot_stack)

	# Display_3D(SplineModelTOF)
	# Display_3D(CroppedSegm)

	Display_dual_3D_grouped(SplineModelTOF, CroppedSegm, savename2)


