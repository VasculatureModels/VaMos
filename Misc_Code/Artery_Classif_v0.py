#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Copyright - Florent Autrusseau
contributor(s) : Florent Autrusseau, Rafic Nader (February 2023)

Florent.Autrusseau@univ-nantes.fr

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

#import napari
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
ap.add_argument("-i", "--image", type=str, default='/home/florent/Images/MRA-Dataset/129.nii',
	help="Input 3D image (stack) (.nrrd, .nii or .mha)")
ap.add_argument("-seg", "--seg", type=str, default='/home/florent/Images/MRA-Dataset/129.seg.nii',
	help="Segmented input 3D image (stack)")
ap.add_argument("-j", "--json", type=str, default='/home/florent/Images/MRA-Dataset/129.seg_F.mrk.json',
    help="path for json file which contains the ground truth  the bif positions")

args = vars(ap.parse_args())


inputimage = args["image"]
print('\ninputimage=\'%s\'' %(inputimage))
seg= args["seg"]
print('seg=\'%s\'' %(seg))
Json = args["json"]
print('Json=\'%s\'' %(Json))


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

[coords_gt_bif, node_id] = Get_Json_Bifs5(stackSegm, coords_gt_bif)


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
	Place 3D spheres at the fiducials locations
	in order to remove the bifurcations from the segmentation.
"""
'''
r = 6
for idx in range(len(coords_gt_bif)):
	x0 = int(coords_gt_bif[idx][0])
	y0 = int(coords_gt_bif[idx][1])
	z0 = int(coords_gt_bif[idx][2])
	Sph = Make_Sphere_NoED(x, y, z, x0, y0, z0, r)
	stackSegm[Sph>0] = 0
#sitk.WriteImage(sitk.GetImageFromArray(np.uint8(stackSegm)),"/home/florent/Bureau/tmp2.nrrd")
'''

graph = GetGraph2(stackSegm.astype(np.uint8))


"""
	Place crosshairs onto the BoI to split the arteries.
"""
w = 16
Blk = np.zeros((w,w,w))
hw = int(w/2)
Blk[hw,:,:] = 1
Blk[:,hw,:] = 1
Blk[:,:,hw] = 1
#sitk.WriteImage(sitk.GetImageFromArray(np.uint8(Blk*255)),"/home/florent/Bureau/tmp.nrrd")

FidImg = np.zeros(stackSegm.shape)

for coords in coords_gt_bif:
	FidImg[coords[2], coords[1], coords[0]] = 1

Eraser = ndimage.convolve(FidImg, Blk, mode='reflect', cval=0.0)
#sitk.WriteImage(sitk.GetImageFromArray(np.uint8(Eraser*255)),"/home/florent/Bureau/tmp.nrrd")

stackSegm[Eraser==1]= 0

#################################################################################################

"""
	Watershed : Get the distance maps, the seeds, etc.
"""
dist_img = sitk.SignedMaurerDistanceMap(sitk.GetImageFromArray(stackSegm) != 0, insideIsPositive=False, squaredDistance=False, useImageSpacing=False)
#sitk.WriteImage(dist_img, "/home/florent/Bureau/dist_img.nrrd")

radius = 0
# Seeds have a distance of "radius" or more to the object boundary, they are uniquely labelled.
seeds = sitk.ConnectedComponent(dist_img < radius)

Seeds = sitk.GetArrayFromImage(seeds)
#sitk.WriteImage(seeds, inputimage[:-4] + "_labels.nrrd")

"""
	Remove the smaller objects :
"""
for gl in range(Seeds.max()):
	(zp,yp,xp) = np.where(Seeds == gl)
	if len(zp) < 100 :
		Seeds[Seeds == gl] = 0

#sitk.WriteImage(sitk.GetImageFromArray(Seeds), inputimage[:-4] + "_labels.nrrd")

"""
	Dilate the labels image (which shrinked during the distance computation process)
	then, we filter the dilated branches with the actual segmentation.
"""
Branches = sitk.GetImageFromArray(Seeds)
np_arr_view = sitk.GetArrayViewFromImage(Branches)
unique_values = set(np_arr_view[np_arr_view!=0])

dilated_image = Branches
dilate_filter = sitk.BinaryDilateImageFilter()
dilate_filter.SetKernelRadius(3)
dilate_filter.SetKernelType(sitk.sitkBall)
for label in unique_values:
    dilate_filter.SetForegroundValue(int(label))
    dilated_image = dilate_filter.Execute(dilated_image)

FiltDilatedImg = stackSegm * sitk.GetArrayFromImage(dilated_image)
LabelBranches = sitk.GetImageFromArray(FiltDilatedImg)

#sitk.WriteImage(dilated_image,'dilated_seg_image.nrrd')
sitk.WriteImage(LabelBranches, inputimage[:-4] + "_labels.seg.nrrd")


"""
	Check the labels along the centerlines
"""
LabelBr = sitk.GetArrayFromImage(LabelBranches)
ArteryLayer = np.zeros(stackSegm.shape).astype(np.uint8)
Sph_3D = rg.sphere((16, 16, 16), 8).astype(np.uint8)
stackSegm[stackSegm > 0] = 1

for ig in range(len(graph)):
	BrSk = []
	NeighbO = list(graph.neighbors(ig))
	if NeighbO != []:
		branchO = graph[ig][NeighbO[0]]['pts']

		#ConvBranch = np.zeros(stackSegm.shape)

		for ib in range(len(branchO)):
			zi = branchO[ib][0]
			yi = branchO[ib][1]
			xi = branchO[ib][2]
			BrSk.append(LabelBr[zi][yi][xi])
			ArteryLayer[zi][yi][xi] = 1

			#conviter = Make_Sphere_NoED(x, y, z, xi, yi, zi, 8)
			#ConvBranch = ConvBranch + conviter

		ConvBranch = ndimage.convolve(ArteryLayer, Sph_3D, mode='reflect', cval=0.0)

		ConvBranch = np.uint32(ConvBranch)
		ConvBranch[ConvBranch>0] = max(BrSk)
		ConvBranch = np.multiply(stackSegm,ConvBranch)

		FiltDilatedImg[ConvBranch > 0] = ConvBranch[ConvBranch > 0]
		#ConvBranch = np.zeros(ConvBranch.shape)
		BrSk = []

		##BrSkArr = np.asarray(BrSk)
		#print("Branch: " + str(ig) + ", label: " +str(BrSkArr.max()))

sitk.WriteImage(sitk.GetImageFromArray(FiltDilatedImg), inputimage[:-4] + "_labels2.seg.nrrd")
