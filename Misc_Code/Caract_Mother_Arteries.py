#!/usr/bin/env python
# -*- coding: utf-8 -*-


import json
import os, sys
import numpy as np
from scipy import ndimage
import raster_geometry as rg

ver = sys.version_info


if ver[0] == 3 and ver[1] == 9 or ver[1] == 10  or ver[1] == 11:
	print("Using Python version {}.{} ... OK !".format(ver[0], ver[1]))
else :
	print('\n\t----------------')
	print('\t   WARNING ! ')
	print('\t----------------')
	print('\t --> Tested only with python versions 3.9 to 3.11...\n\n')
	#sys.exit(0)

sys.path.append("../")

from MyFunctions.ICA_fun import *
from MyFunctions.misc_fun import *


################################################################################################################################################
################################################################################################################################################
# construct the argument parser and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-i", "--image", type=str, default='/home/florent/Images/MRA-Dataset/85.nii',
	help="Input 3D image (stack) (.nrrd, .nii or .mha)")
ap.add_argument("-lab", "--labels", type=str, default='/home/florent/Images/MRA-Dataset/85_labels.seg.nrrd',
	help="Labels 3D image (stack)")
ap.add_argument("-j", "--json", type=str, default='/home/florent/Images/MRA-Dataset/85.seg_F.mrk.json',
    help="json file containing the ground truth  the bif positions")
ap.add_argument("-jl", "--jsonLab", type=str, default='/home/florent/Images/MRA-Dataset/85.seg_F_MothArt.mrk.json',
    help="json file containing the mother arteries' positions")

args = vars(ap.parse_args())


inputimage = args["image"]
print('\ninputimage=\'%s\'' %(inputimage))
labels= args["labels"]
print('labels=\'%s\'' %(labels))
Json = args["json"]
print('Json=\'%s\'' %(Json))
JsonLab = args["jsonLab"]
print('JsonLabels=\'%s\'' %(JsonLab))


FileDir = os.path.dirname(os.path.abspath(inputimage)) + '/'
FileNameStack = (os.path.basename(inputimage))
FileName = os.path.splitext(os.path.basename(FileNameStack))[0]

"""
	Read input images (TOF + Segmentation)
	Resample each image to 0.4mm^3 voxels
"""

fileext = os.path.splitext(inputimage)[1]
if fileext == '.nii' or fileext == '.mha' or fileext == '.nrrd':
	sitkimg = sitk.ReadImage(inputimage, sitk.sitkUInt16)
	#resampling
	sitkimg = resample_image2(sitkimg, is_label=False)
	#spacing = sitkimg.GetSpacing()
	stackGray = sitk.GetArrayFromImage(sitkimg)

	sitkimgLab = sitk.ReadImage(labels)
	#resampling
	sitkimgLab = resample_image2(sitkimgLab, is_label=False)
	stackLab = sitk.GetArrayFromImage(sitkimgLab)

else:		   # Probably a DICOM folder...
	print('Give a 3D stack as an input (.nrrd, .nii or .mha)\n')
	sys.exit(0)

z,y,x = stackLab.shape
zG,yG,xG = stackGray.shape

if x != xG or y != yG or z != zG :
	print('\nWARNING : Size Mismatch !\n')


"""
	Force the labels image in the range [100, 250]
"""
stackLab = (150 / (stackLab.max() - stackLab.min())) * stackLab + 250 - stackLab.max() * (150 / (stackLab.max() - stackLab.min()))
stackLab[stackLab==100.0] = 0
stackLab = np.uint8(stackLab)


"""
	Read Json File
	and correct the fiducials --> put them onto the 3D graph nodes.
"""
f = open(Json)
data = json.load(f)

coords_gt_bif = []
fid_label = []
for i in range(len(data['markups'][0]['controlPoints'])):
	coords_gt_bif.append(np.abs(data['markups'][0]['controlPoints'][i]['position']))
	fid_label.append(data['markups'][0]['controlPoints'][i]['label'])

[coords_gt_bif, node_id] = Get_Json_Bifs5(stackLab, coords_gt_bif)


"""
	Display the fiducials coordinates :
"""
print('----------------------------------------------------------------------\n')
k=0
for i in node_id:
	print('coords (x,y,z): ' +  str(int(coords_gt_bif[k][0])) + ', ' +
		str(int(coords_gt_bif[k][1])) + ', ' +
		str(int(coords_gt_bif[k][2])) + '\t' +
		'Fid:' + str(fid_label[k]) + ',\t' +
		'bif nb: ' + str(i))
	k+=1
print('----------------------------------------------------------------------\n')






"""
	Read Json File
	and correct the fiducials --> put them onto the 3D graph nodes.
"""
fL = open(JsonLab)
dataMothArt = json.load(fL)

coords_mothArt = []
fid_label_mothArt = []
for i in range(len(dataMothArt['markups'][0]['controlPoints'])):
	if dataMothArt['markups'][0]['controlPoints'][i]['position'] != '':
		coords_mothArt.append(np.abs(dataMothArt['markups'][0]['controlPoints'][i]['position']))
		fid_label_mothArt.append(dataMothArt['markups'][0]['controlPoints'][i]['label'])

[coords_mothArt, node_id_MothArt] = Get_Json_Bifs5(stackLab, coords_mothArt)


"""
	Display the fiducials coordinates :
"""
print('----------------------------------------------------------------------\n')
k=0
for i in node_id_MothArt:
	print('coords (x,y,z): ' +  str(int(coords_mothArt[k][0])) + ', ' +
		str(int(coords_mothArt[k][1])) + ', ' +
		str(int(coords_mothArt[k][2])) + '\t' +
		'Fid:' + str(fid_label_mothArt[k]) + ',\t' +
		'bif nb: ' + str(i))
	k+=1
print('----------------------------------------------------------------------\n')


MotherArteriesLabels = np.copy(stackLab)

for i in range(len(node_id_MothArt)):
	lab = int(fid_label_mothArt[i][fid_label_mothArt[i].find('-')+1 : len(fid_label_mothArt[i])])
	GL = stackLab[coords_gt_bif[i][2], coords_gt_bif[i][1], coords_gt_bif[i][0]]
	MotherArteriesLabels[stackLab == GL] = lab

print('Writing : ' + labels[:-9] + '_2.seg.nrrd\n')
sitk.WriteImage(sitk.GetImageFromArray(MotherArteriesLabels), labels[:-9] + '_2.seg.nrrd')


'''
for i in range(len(node_id)):
	lab1 = int(fid_label[i][fid_label[i].find('-')+1 : len(fid_label[i])])
	xyz = (coords_gt_bif[i][2], coords_gt_bif[i][1], coords_gt_bif[i][0])
	if sum(xyz) > 0:
		for j in range(len(node_id_MothArt)):
			lab2 = int(fid_label_mothArt[j][fid_label_mothArt[j].find('-')+1 : len(fid_label_mothArt[j])])
			if lab2 == lab1:
				...
'''
