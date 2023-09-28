
import os
import sys
import json
import sknw
import random
import argparse
import numpy as np
import SimpleITK as sitk
from skimage.morphology import skeletonize_3d

ver = sys.version_info


if ver[0] == 3 and ver[1] == 9 or ver[1] == 10:
	print("Using Python version {}.{} ... OK !".format(ver[0], ver[1]))
else :
	print('\n\t----------------')
	print('\t   WARNING ! ')
	print('\t----------------')
	print('\t --> Tested only with python versions 3.9 and 3.10...\n\n')
	#sys.exit(0)


from MyFunctions.misc_fun import *
#from MyFunctions.Geometric_Model import *


################################################################################################################################################
################################################################################################################################################
# construct the argument parser and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-i", "--image", type=str, default='/Users/florent//Nextcloud/NeuroVascu/TOFs/CNN_Dataset/Quelques_TOFs_pour_tests/3.nrrd',
	help="Input 3D image (stack) (.nrrd, .nii or .mha)")
ap.add_argument("-seg", "--seg", type=str, default='/Users/florent/Nextcloud/NeuroVascu/TOFs/CNN_Dataset/Quelques_TOFs_pour_tests/3.seg.nrrd',
	help="Segmented input 3D image (stack)")
ap.add_argument("-j", "--json", type=str, default='/Users/florent/Nextcloud/NeuroVascu/TOFs/CNN_Dataset/Quelques_TOFs_pour_tests/3.seg_F.mrk.json', 
	help="path for json file which contains the ground truth  the bif positions")
ap.add_argument("-cs", "--CropSize", type=int, default=64,
	help="Size of the 3D crops to grab around the point of interest")


args = vars(ap.parse_args())

inputimage = args["image"]
print('\ninputimage=\'%s\'' %(inputimage))
seg= args["seg"]
print('seg=\'%s\'' %(seg))
Json = args["json"]
print('Json=\'%s\'' %(Json))
CropSize = int(args["CropSize"])
print('CropSize=%d' %(CropSize))

hcs = int(CropSize/2)

FileDir = os.path.dirname(os.path.abspath(inputimage)) + '/'
FileNameStack = (os.path.basename(inputimage))
FileName = os.path.splitext(os.path.basename(FileNameStack))[0]
FileExt = os.path.splitext(os.path.basename(FileNameStack))[1]


'''
	Read the input images :
'''
fileext = os.path.splitext(inputimage)[1]
if fileext == '.nii' or fileext == '.mha' or fileext == '.nrrd':
	sitkimg = sitk.ReadImage(inputimage, sitk.sitkUInt16)
	#resampling
	sitkimg = resample_image2(sitkimg, is_label=False)
	stackGray = sitk.GetArrayFromImage(sitkimg)


	sitkimgSegm = sitk.ReadImage(seg)
	#resampling
	sitkimgSegm = resample_image2(sitkimgSegm, is_label=False)
	stackSegm = sitk.GetArrayFromImage(sitkimgSegm)
else:		   # Probably a DICOM folder...
	print('Give a 3D stack as an input (.nrrd, .nii or .mha)\n')
	sys.exit(0)

z,y,x = stackSegm.shape
zG,yG,xG = stackGray.shape

if x != xG or y != yG or z != zG :
	print('\nWARNING : Size Mismatch !\n')

'''
	Read the Json File :
'''
f = open(Json)
data = json.load(f)

coords_gt_bif = []
fid_label = []
for i in range(len(data['markups'][0]['controlPoints'])):
	coords_gt_bif.append(np.abs(data['markups'][0]['controlPoints'][i]['position']))
	fid_label.append(data['markups'][0]['controlPoints'][i]['label'])

[coords_gt_bif, node_id] = Get_Json_Bifs3(stackSegm, coords_gt_bif)


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



'''
	Get the 3D skeleton & 3D graph :
'''
ske = skeletonize_3d(np.uint8(stackSegm)).astype(np.uint8)
graph = sknw.build_sknw(ske)


'''
	Find all the 3D patches that are far away (> 1/2 CropSize, i.e. 32 voxels) from the set of BoI :
'''
candidate_node = []
for i in range(len(graph)):
	coords_center_bif = graph.nodes[i]['o']
	coords_center_bif = coords_center_bif[::-1]
	dist = []
	for j in range(len(coords_gt_bif)):
		dist.append(np.linalg.norm(np.array(coords_gt_bif[j]) - np.array(coords_center_bif)))
	if min(dist) > hcs:
		candidate_node.append(i)

'''
	Grab N (=40) random patches among the ones being more remote from the BoI :
'''
N = 40
if len(candidate_node) > 40:
	idx = random.sample(range(1, len(candidate_node)), N)
else:
	idx = np.arange(len(candidate_node))


for j in idx:
	bifcenter = graph.nodes[candidate_node[j]]['o']
	bifcenter = bifcenter[::-1].astype(int)
	print('bifurcation center (x,y,z) : ' + str(bifcenter))
	Xc = bifcenter[0]
	Yc = bifcenter[1]
	Zc = bifcenter[2]

	#CropSegm = stackSegm[Zc-hcs: Zc+hcs, Yc-hcs: Yc+hcs, Xc-hcs: Xc+hcs]

	if (Xc >= hcs and Xc <= x - hcs) and (Yc >= hcs and Yc <= y - hcs) and (Zc >= hcs and Zc <= z - hcs):
		CropSegm = stackSegm[Zc - hcs:Zc + hcs, Yc - hcs:Yc + hcs, Xc - hcs:Xc + hcs]
		CropGray = stackGray[Zc - hcs:Zc + hcs, Yc - hcs:Yc + hcs, Xc - hcs:Xc + hcs]

		savenameSeg = FileDir + FileName + '_BoNI_xyz=' + str(Xc) + '_' + str(Yc) + '_' + str(Zc) + '.seg' + FileExt
		sitk.WriteImage(sitk.GetImageFromArray(CropSegm),savenameSeg)
		savename = FileDir + FileName + '_BoNI_xyz=' + str(Xc) + '_' + str(Yc) + '_' + str(Zc) + FileExt
		sitk.WriteImage(sitk.GetImageFromArray(CropGray),savename)
		print(savename)
	else:
		print("\tWARNING : Bifurcation is too close from image border... can't crop !")
		"""
		if Xc < hcs:
			Xc = hcs
		if Yc < hcs:
			Yc = hcs
		if Zc < hcs:
			Zc = hcs
		if Xc > x-hcs:
			Xc = x-hcs
		if Yc > y-hcs:
			Yc = y-hcs
		if Zc > z-hcs:
			Zc = z-hcs
		CropSegm = stackSegm[Zc - hcs:Zc + hcs, Yc - hcs:Yc + hcs, Xc - hcs:Xc + hcs]
		CropGray = stackGray[Zc - hcs:Zc + hcs, Yc - hcs:Yc + hcs, Xc - hcs:Xc + hcs]
		"""


