#!/usr/bin/env python
# -*- coding: utf-8 -*-


import napari
import sys
import json
import sknw
import numpy as np
from skimage.morphology import skeletonize_3d

ver = sys.version_info

def randParam():
	rvec = [2, 3, 4, 5]            	# ICA radius
	evec = [0.0, 2.0, 3.0, 4.0]     # elastic deform
	gvec = [0.7, 0.8, 0.9, 1.0]   	# ICA growth
	r = int(np.random.randint(4))
	e = int(np.random.randint(4))
	g = int(np.random.randint(4))
	radius = rvec[r]
	elasticStDev = evec[e]
	AGrowth = gvec[g]
	if radius == 2:
		AGrowth = 1.0
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
from MyFunctions.misc_fun import *
from MyFunctions.ICA_fun import *
from MyFunctions.Noise_Model import *
from MyFunctions.Geometric_Model import *
from MyFunctions.ICA_noise_generator import *
from MyFunctions.GetBifurcDiameters import *

ZoomIn = 0
RandPoint = 0
AddICA = 1
Show_MotherBranch = 1
r = 0 	  # <-- initialize ICA Radius
agr = 0   # <-- initialize Growth param
sed = 0   # <-- initialize ElasticDeform
#FidsOfInterest = ['F-5', 'F-6', 'F-7', 'F-8', 'F-11', 'F-12']

################################################################################################################################################
################################################################################################################################################
# construct the argument parser and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-i", "--image", type=str, default='/Users/---//Nextcloud/NeuroVascu/TOFs/CNN_Dataset/Quelques_TOFs_pour_tests/3.nrrd',
	help="Input 3D image (stack) (.nrrd, .nii or .mha)")
ap.add_argument("-seg", "--seg", type=str, default='/Users/---/Nextcloud/NeuroVascu/TOFs/CNN_Dataset/Quelques_TOFs_pour_tests/3.seg.nrrd',
	help="Segmented input 3D image (stack)")
ap.add_argument("-str", "--SplineStr", type=str, default='1',
	help="Strength of the spline modification (10 to 30)")
ap.add_argument("-f", "--Fid", type=int, default='0',
	help="Specify a Fiducial number (0 for all fiducials, 22 for random)")
ap.add_argument("-sigst", "--SigmStart", type=str, default='0.0',
	help="Starting value of the Noise Sigma (prior filtering) (if = 0: random value in [0.5, 2.5])")
ap.add_argument("-j", "--json", type=str, required=True,
    help="path for json file which contains the ground truth  the bif positions")
ap.add_argument("-sp", "--ShowPlot", type=str, default='0',
	help="Show the 3D plot of the 3 spline functions (1 or 0)")
ap.add_argument("-r", "--Radius", type=str, default=0,
	help="Aneurysm radius")
ap.add_argument("-AGr", "--AGrowth", type=float, default=0,
	help="Aneurysm growth factor (in [0.0, 1.0]")
ap.add_argument("-Sed", "--SigmaED", type=float, default=0,
	help="Standard deviation for the ICA elastic deformation")
ap.add_argument("-cs", "--CropSize", type=int, default=64,
	help="Size of the 3D crops to grab around the point of interest")
ap.add_argument("-d3D", "--Disp3D", type=int, default=0,
	help="Display the output 3D model (1 or 0)")

args = vars(ap.parse_args())


inputimage = args["image"]
print('\ninputimage=\'%s\'' %(inputimage))
seg= args["seg"]
print('seg=\'%s\'' %(seg))
Json = args["json"]
print('Json=\'%s\'' %(Json))
SplineStr = int(args["SplineStr"])
print('SplineStr=%d' %(SplineStr))
Fid = int(args["Fid"])
print('Fid=%d' %(Fid))
SigmStart = float(args["SigmStart"])
print('SigmStart=%1.2f' %(SigmStart))
ShowPlot = int(args["ShowPlot"])
print('ShowPlot=%d' %(ShowPlot))
CropSize = int(args["CropSize"])
print('CropSize=%d' %(CropSize))
d3D = int(args["Disp3D"])
print('d3D=%d' %(d3D))
r = int(args["Radius"])
agr = args["AGrowth"]
sed = args["SigmaED"]

if SigmStart == 0.0:
	SigmStart = round(np.random.uniform(0.5, 2.5) , 2)

if SplineStr == 0:
	SplineStr = int(np.random.uniform(2, 10))

[Radius, SigmaED, AGrowth] = randParam()

if r != 0:
	Radius = r

if agr != 0:
	AGrowth = agr

if sed != 0:
	SigmaED = sed

#Radius = 5
#AGrowth = 0.75

print('Radius=%d' %(Radius))
print('SigmaED=%1.2f' %(SigmaED))
print('AGrowth=%1.2f\n' %(AGrowth))

FileDir = os.path.dirname(os.path.abspath(inputimage)) + '/'
FileNameStack = (os.path.basename(inputimage))
FileName = os.path.splitext(os.path.basename(FileNameStack))[0]


'''
	Read input image:
'''
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
	Read Json File:
'''
f = open(Json)
data = json.load(f)

coords_gt_bif = []
fid_label = []
for i in range(len(data['markups'][0]['controlPoints'])):
	coords_gt_bif.append(np.abs(data['markups'][0]['controlPoints'][i]['position']))
	fid_label.append(data['markups'][0]['controlPoints'][i]['label'])

[coords_gt_bif, node_id] = Get_Json_Bifs5(stackSegm, coords_gt_bif)

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

if Fid == 22:
	numbers = list(range(0, len(coords_gt_bif)))
	for idxC in range(len(coords_gt_bif)):
		if coords_gt_bif[idxC].sum() == 0:
			numbers.remove(idxC)
	Fid = random.choice(numbers)


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
for FidLabel in fid_label:
	FidNb = int(FidLabel[FidLabel.find('-')+1:len(FidLabel)])
	XYZbif = coords_gt_bif[FidNb-1].astype('int')
	BifNum = node_id[FidNb-1]

	if (XYZbif[0]+XYZbif[1]+XYZbif[2] != 0):
		print('-----------------------\n')
		print('Processing Fid Nb : ' +str(FidNb))
		print('-----------------------\n')
		'''
			Building the Binary shape of the bifurcations / branches :
		'''
		CropCoords, CropOrig, BinCrop, SplineModelTOF, CleanVascu, ICA_Arr, MotherBranch, Thromb = geometric_model(stackGray, stackSegm, BifNum, SplineStr, CropSize, ShowPlot, RandPoint, AddICA, Radius, SigmaED, AGrowth)

		'''
			Generating the adapted background noise :
		'''
		if SplineModelTOF.max() != 0:
			MaskSplineModelTOF, noisy_model_GM, ArteryAmpl, mu, sigma = noise_model(SplineModelTOF, CropOrig, SigmStart, ZoomIn)

			noisy_model_GM = noisy_model_GM * Thromb
			BinModel = np.copy(SplineModelTOF)
			BinModel[BinModel > 0] = 1

			ICA_Arr = ndimage.binary_dilation(ICA_Arr).astype(ICA_Arr.dtype)

			VascuLabels = np.zeros(BinModel.shape)
			VascuLabels[BinModel > 0] = 255
			VascuLabels[ICA_Arr > 0] = 128

			""" Saving the Vascular tree and ICA as a labelled image : """
			#save_ICA_label = FileDir + "_ICA_Model/" + FileName + "_Bif=" + str(FidNb) + "_Spl=" + str(SplineStr) + "_R=" + str(Radius) + "_Sed=" + str(SigmaED) + "_AGr=" + str(AGrowth) + "_ICA_Label_Model.seg.nrrd"
			#print(save_ICA_label)
			#sitk.WriteImage(sitk.GetImageFromArray(np.uint8(VascuLabels)), save_ICA_label)

			#save_Model = FileDir + "_ICA_Model/" + FileName + "_Bif=" + str(FidNb) + "_Spl=" + str(SplineStr) + '_SigSt=' + str(SigmStart) + "_R=" +str(Radius) +"_Sed=" +str(SigmaED) + "_AGr=" + str(AGrowth) + "_Model.nrrd"
			#print(save_Model)
			#sitk.WriteImage(sitk.GetImageFromArray(noisy_model_GM), save_Model)

			''' Saving the ICA array only: '''
			#ICAOnly = VascuLabels - CleanVascu
			#ICAOnly[ICAOnly != 128] = 0
			#save_ICAOnly = FileDir + "_ICA_Model/" + FileName + "_Bif=" + str(FidNb) + "_Spl=" + str(SplineStr) + "_R=" +str(Radius) +"_Sed=" +str(SigmaED) + "_ICA.seg.nrrd"
			#print(save_ICAOnly)
			#sitk.WriteImage(sitk.GetImageFromArray(np.uint8(ICAOnly)), save_ICAOnly)
			#print('\n')

			if not (os.path.exists(FileDir + "_ICA_Model/")):
				os.makedirs(FileDir + "_ICA_Model/")

			'''    Save the output images :    '''
			#save_Clean_Vascu = FileDir + "_ICA_Model/" + FileName + "_Bif=" + str(FidNb) + "_Spl=" + str(
			#	SplineStr) + "_R=" + str(Radius) + "_Sed=" + str(SigmaED) + "_AGr=" + str(
			#	AGrowth) + "_CleanVascu.seg.nrrd"
			#print(save_Clean_Vascu)
			#sitk.WriteImage(sitk.GetImageFromArray(np.uint8(CleanVascu) * 255), save_Clean_Vascu)

			#save_whole_Vascu = FileDir + "_ICA_Model/" + FileName + "_Bif=" + str(FidNb) + "_Spl=" + str(
			#	SplineStr) + "_R=" + str(Radius) + "_Sed=" + str(SigmaED) + "_AGr=" + str(AGrowth) + "_BinOrig.seg.nrrd"
			#print(save_whole_Vascu)
			#sitk.WriteImage(sitk.GetImageFromArray(np.uint8(BinCrop) * 255), save_whole_Vascu)

			#save_OrigCrop = FileDir + "_ICA_Model/" + FileName + "_Bif=" + str(FidNb) + "_Spl=" + str(
			#	SplineStr) + "_R=" + str(Radius) + "_Sed=" + str(SigmaED) + "_Orig.nrrd"
			#print(save_OrigCrop)
			#sitk.WriteImage(sitk.GetImageFromArray(CropOrig), save_OrigCrop)


			"""
				Adding the modeled aneurysm onto the Full TOF stack.
				i.e. only the ICA is synthetic within an actual MRA-TOF.
			"""
			(cz, cy, cx) = VascuLabels.shape
			hc = int(cz/2)

			ICA_Crop = np.zeros(VascuLabels.shape)
			ICA_Crop[VascuLabels==128] = 1
			ICA_Full_Mask = np.zeros(stackGray.shape)
			ICA_Full = np.zeros(stackGray.shape)

			ICA_Full_Mask[coords_gt_bif[Fid-1][2]-hc:coords_gt_bif[Fid-1][2]+hc,
						coords_gt_bif[Fid-1][1]-hc:coords_gt_bif[Fid-1][1]+hc,
						coords_gt_bif[Fid-1][0]-hc:coords_gt_bif[Fid-1][0]+hc] = ICA_Crop


			save_ICA_Full_Mask = FileDir + "_ICA_Model/" + FileName + "_Bif=" + str(FidNb) + "_R=" + str(Radius) + "_Sed=" + str(SigmaED) + "_AGr=" + str(
				AGrowth) + "_ICA_Full_Mask.nrrd"
			print(save_ICA_Full_Mask)
			sitk.WriteImage(sitk.GetImageFromArray(np.uint8(ICA_Full_Mask)),save_ICA_Full_Mask)


			""" Dilate the ICA mask:
			ICA_Full_Mask_Dil = ndimage.binary_dilation(ICA_Full_Mask).astype(ICA_Full_Mask.dtype)
			ICA_Full_Mask_Dil = ndimage.binary_dilation(ICA_Full_Mask_Dil).astype(ICA_Full_Mask.dtype)
			ICA_Full_Mask_Dil = ndimage.binary_dilation(ICA_Full_Mask_Dil).astype(ICA_Full_Mask.dtype)
			"""

			""" """
			struct2 = ndimage.generate_binary_structure(3, 3)
			ICA_Full_Mask_Dil = ndimage.binary_dilation(ICA_Full_Mask, structure=struct2, iterations=2).astype(ICA_Full_Mask.dtype)
			ICA_Full_Mask_Dil2 = ndimage.binary_dilation(ICA_Full_Mask, structure=struct2, iterations=3).astype(ICA_Full_Mask.dtype)
			""" """

			TOF_ICA = np.zeros(stackGray.shape)

			noisy_model_GM_Masked = np.copy(noisy_model_GM)
			noisy_model_GM_Masked[ICA_Crop != 1] = 0

			ICA_Full[coords_gt_bif[Fid-1][2]-hc:coords_gt_bif[Fid-1][2]+hc,
					coords_gt_bif[Fid-1][1]-hc:coords_gt_bif[Fid-1][1]+hc,
					coords_gt_bif[Fid-1][0]-hc:coords_gt_bif[Fid-1][0]+hc] = noisy_model_GM_Masked

			TOF_ICA = np.maximum(stackGray, ICA_Full)

			TOF_ICA_Blur = ndimage.gaussian_filter(TOF_ICA, sigma=0.8)

			TOF_ICA[ICA_Full_Mask_Dil2 > 0] = TOF_ICA_Blur[ICA_Full_Mask_Dil2 > 0]

			save_ICA_Full_TOF = FileDir + "_ICA_Model/" + FileName + "_Bif=" + str(FidNb) + "_R=" + str(Radius) + "_Sed=" + str(SigmaED) + "_AGr=" + str(
				AGrowth) + "_ICA_Full_TOF.nrrd"
			print(save_ICA_Full_TOF)
			sitk.WriteImage(sitk.GetImageFromArray(np.uint8(TOF_ICA)),save_ICA_Full_TOF)

		else:
			print("\nCannot save the output images. \nEncountered a problem with the ICA positioning.\n")
			noisy_model_GM = np.zeros(SplineModelTOF.shape)




		#SplineModelTOF[SplineModelTOF > 0] = 1

		#noisy_model_GM[Weighted_ICA_arr > 0] = Weighted_ICA_arr[Weighted_ICA_arr > 0]

		print("\n")

		if d3D == 1:

			buffer = np.zeros((CropOrig.shape[0],3,CropOrig.shape[2]), dtype=np.uint16)
			buffer[:,0,:] = 0;  buffer[:,1,:] = 0;  buffer[:,2,:] = 0

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
			#napari.run()

			SplineModelTOF[SplineModelTOF>0] = 255
			if Show_MotherBranch == 1:
				#Disp3D_3(CleanVascu, ICA_Arr, MotherBranch)
				#Disp3D_3(SplineModelTOF, ICA_Arr, MotherBranch)
				SplineModelTOF[ICA_Arr>0] = 0
				Display_dual_3D_grouped2(SplineModelTOF, BinCrop, ICA_Arr, MotherBranch)
			else:
				#Disp3D_2(CleancVascu, ICA_Arr)
				Disp3D_2(SplineModelTOF, ICA_Arr)

		print("\n")
