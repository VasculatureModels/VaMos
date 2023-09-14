#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Copyright - <--->
contributor(s) : <--->, <---> (February 2023)

<---@----.-->
<---@----.-->

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

import pandas as pd
import numpy as np
import sys, os
import SimpleITK as sitk
import argparse

###   Local imports :   ###
from MyFunctions.GetGraph import *
from MyFunctions.misc_fun import *
from MyFunctions.bif_geom_model import *




# construct the argument parser and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-i", "--image", type=str, default='/Users/----/Nextcloud/NeuroVascu/TOFs/Manual_Segm/nrrd_tof/training_BET/55.nrrd', #required=True,
    help="path input 3D image (stack) (.dcm or .nii or .mha or .nrrd) ")
ap.add_argument("-cs", "--CropSize", type=int, default=64,
    help="Desired size for the cropped stacks")
args = vars(ap.parse_args())



tof_name= args["image"]
#print('inputpath: ', inputpath)
Csize= args["CropSize"]
#print('CropSize: ', Csize)


''' Collect file names : '''
FileDir = os.path.dirname(os.path.abspath(tof_name)) + '/'
FileName = os.path.splitext(os.path.basename(tof_name))[0]
FileExt = os.path.splitext(os.path.basename(tof_name))[1]
FileDirSegm = FileDir.replace('nrrd_tof', 'nrrd_mask')
features_name = FileDirSegm + FileName + '_features.xlsx'
seg_name = FileDirSegm + FileName + FileExt

print(tof_name)
print(seg_name)
print(features_name)


''' Read images  : '''
sitkimg1 = sitk.ReadImage(tof_name)
tof = sitk.GetArrayFromImage(sitkimg1)
zt,yt,xt = tof.shape

sitkimg2 = sitk.ReadImage(seg_name)
seg = sitk.GetArrayFromImage(sitkimg2)


''' Read XLS feature file : '''
df = pd.read_excel(features_name, sheet_name='Fiducials')

## Zero Padded TOF :
zp_tof = np.zeros((zt+Csize,yt+Csize,xt+Csize))
zp_seg = np.zeros((zt+Csize,yt+Csize,xt+Csize))
zz,yz,xz = zp_tof.shape
HCsize = int(Csize/2)
zp_tof[HCsize:zz-HCsize, HCsize:yz-HCsize, HCsize:xz-HCsize] = tof
zp_seg[HCsize:zz-HCsize, HCsize:yz-HCsize, HCsize:xz-HCsize] = seg


''' Loop on the 15 fiducials : '''
for i in range(1,16):
	''' Collect the fiducial coordinates : '''
	xyz_str = df.loc[df.index[1], i]
	xyz_str = xyz_str.replace('[','')
	xyz_str = xyz_str.replace(']','')
	xyz_str = xyz_str.replace('   ',' ')
	xyz_str = xyz_str.replace('  ',' ')
	xyz_str = xyz_str.replace(',','')
	xyz_fiducial = [x.strip() for x in xyz_str.split(' ')]
	xf = int(xyz_fiducial[0])
	yf = int(xyz_fiducial[1])
	zf = int(xyz_fiducial[2])

	''' Collect the actual bifurcation coordinates : '''
	xyz_str = df.loc[df.index[4], i]
	xyz_str = xyz_str.replace('[','')
	xyz_str = xyz_str.replace(']','')
	xyz_str = xyz_str.replace(' ','')
	xyz_bif = [x.strip() for x in xyz_str.split(',')]
	xb = int(xyz_bif[0])
	yb = int(xyz_bif[1])
	zb = int(xyz_bif[2])

	''' bif coords within the crop : '''
	xbc = HCsize + (xb - xf)
	ybc = HCsize + (yb - yf)
	zbc = HCsize + (zb - zf)
	xyz_bc = np.asarray([zbc, ybc, xbc])

	nb_fid = df.loc[df.index[0], i] + 1
	is_node = df.loc[df.index[4], i]

	''' If node was found... '''
	if 'Node' in is_node:
		print('Warning : No node linked to fid #%d !' %(nb_fid))
	else:
		nb_node = df.loc[df.index[3], i]

		crop_tof = zp_tof[zf:zf+Csize, yf:yf+Csize,xf:xf+Csize]
		crop_seg = zp_seg[zf:zf+Csize, yf:yf+Csize,xf:xf+Csize]

		if os.path.exists('seg/') == False:
			os.makedirs('seg/')
		if os.path.exists('tof/') == False:
			os.makedirs('tof/')

		savename = 'tof/' + FileName + '_crop_tof_bif_' + str(nb_fid) + '.nrrd'
		sitk.WriteImage(sitk.GetImageFromArray(np.int16(crop_tof)), savename)

		savename = 'seg/' + FileName + '_crop_seg_bif_' + str(nb_fid) + '.nrrd'
		sitk.WriteImage(sitk.GetImageFromArray(np.int16(crop_seg)), savename)

		''' Launch MaxEntropy Segmentation on the cropped volume : '''
		'''
		ent_seg = np.copy(crop_tof)
		for j in range(Csize):
			entropy_seg = np.uint8(crop_tof[j,:,:])
			hist = np.histogram(entropy_seg, bins=256, range=(0, 256))[0]
			th = max_entropy(hist)
			ent_seg[j,:,:][ent_seg[j,:,:] >= th]=255
			ent_seg[j,:,:][ent_seg[j,:,:] < th]=0
		ent_seg[ent_seg>0]=1

		savename = 'seg/' + FileName + '_crop_seg_MaxEnt_bif_' + str(nb_fid) + '.nrrd'
		sitk.WriteImage(sitk.GetImageFromArray(np.int16(ent_seg)), savename)
		'''

		''' Get 3D graph from the binary crop : '''
		graph = GetGraph(crop_seg.astype(np.uint8))
		#res = get_diameters(crop_seg.astype(np.uint8), 1)
		for j in range(graph.size()):
			node_coords = graph.nodes[j]['o'].astype(int)
			#print(node_coords)
			if np.array_equal(node_coords, xyz_bc) :
				BifNum = j

		print('Bifurcation of interest : ' + str(BifNum))

		SplineStr = 30
		ShowPlot = 1

		Branch, NBranch, coordsBif = spline_model(crop_seg, BifNum, SplineStr, ShowPlot)
