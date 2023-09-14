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


import sknw
from scipy import interpolate
from mpl_toolkits.mplot3d import Axes3D
#from copy import deepcopy
from decimal import Decimal
import sys, os, glob, platform
import numpy as np
import cv2
import scipy.ndimage as ndi
import matplotlib.pyplot as plt
from scipy.ndimage import gaussian_filter
from skimage.morphology import skeletonize_3d
import skimage.io
import skimage.util
import SimpleITK as sitk
import argparse
#from mayavi import mlab

'''
def draw3d_mayavi(array, path):
	mlab.contour3d(array.astype(np.int32)) # a window would pop up
	mlab.savefig(path)
	mlab.clf() # clear the scene to generate a new one
'''

###   Local imports :   ###
from MyFunctions.GetGraph import *
from MyFunctions.misc_fun import *
from MyFunctions.bif_geom_model import *



#########################################################################################################

#
# construct the argument parser and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-i", "--image", type=str, default='/Users/----/Nextcloud/NeuroVascu/TOFs/Manual_Segm/nrrd_TOF/training_BET/3.nrrd',
	help="Input 3D image (stack) (.nrrd, .nii or .mha)")
ap.add_argument("-seg", "--seg", type=str, default='/Users/----/Nextcloud/NeuroVascu/TOFs/Manual_Segm/nrrd_mask/training_BET/3.nrrd',
	help="Segmented input 3D image (stack)")
ap.add_argument("-bn", "--BifNum", type=str, default='28',
	help="Position of the bifurcation in the list of bifurcs from the 3D graph")
ap.add_argument("-w", "--width", type=int, default=64,
    help="Size (width) of the extracted 3D crop")
#ap.add_argument("-l", "--label", type=str, default='A',
#    help="Label of the bifurcations (A to O)")

args = vars(ap.parse_args())


inputpath= args["image"]
print('inputpath: ', inputpath)
seg= args["seg"]
print('seg: ', seg)
BifNum = int(args["BifNum"])
print('BifNum: ',BifNum)
width = int(args["width"])
print('width: ',width)
#label = args["label"]
#print('label: ',label)



FileDir = os.path.dirname(os.path.abspath(inputpath)) + '/'
FileNameStack = (os.path.basename(inputpath))
FileName = os.path.splitext(os.path.basename(FileNameStack))[0]

spacing=1

fileext = os.path.splitext(inputpath)[1]
if fileext == '.nii' or fileext == '.mha' or fileext == '.nrrd':
	sitkimg = sitk.ReadImage(inputpath)
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

z,y,x = stackSegm.shape
zG,yG,xG = stackGray.shape

if x != xG or y != yG or z != zG :
	print('\nWARNING : Size Mismatch !\n')


graph = GetGraph(stackSegm.astype(np.uint8))

"""
res = get_diameters(stackSegm.astype(np.uint8), BifNum)

graph = res['graph']
diamMin1 = res['diamMin branch 0']
diamMax1 = res['diamMax branch 0']
diamMin2 = res['diamMin branch 1']
diamMax2 = res['diamMax branch 1']
diamMin3 = res['diamMin branch 2']
diamMax3 = res['diamMax branch 2']
"""

def graph_node(node): #renvoie les coordonnés d'un noeud du graph dans un np.array
	return graph.nodes[node]['o']


#-------------------------------------------------------------------------------------------
#detection des centres de bifurcations
z,y,x = stackSegm.shape
ListBifurcBox=[]
List_noeud_graph_bifurc=[]
for j in range(len(graph)):
	if len( list(graph.neighbors(j) ) )>2   :
		neighbors=list(graph.neighbors(j))
		if j  in neighbors:
			neighbors.remove(j )
			if len(neighbors)<3:
				continue
		if len(neighbors)<2 or len(graph[j][neighbors[0]]['pts'] ) <4 or len(graph[j][neighbors[1]]['pts'] ) <4 or len(graph[j][neighbors[2]]['pts'] ) <4: #<=10 before
			#print("continue");
			continue
		else:
			coords_noeud_central=graph.nodes[j]['o']
			z=coords_noeud_central[0]
			y=coords_noeud_central[1]
			x=coords_noeud_central[2]
			center=j
			posBifurc=[x,y]
			posBifurc.append(z)
			posBifurc=[posBifurc]
			ListBifurcBox.append(posBifurc) #contient les coordonénes 3D des centres des bifs
			List_noeud_graph_bifurc.append(j) #contient l'indice des des noeuds du graph constituant les centres des bifs

	else:
		continue

print('nbr bif : ' + str(len(ListBifurcBox)) + '\n')


#enregistrement des coordonnées des noeuds du graph
coords_x=[]
coords_y=[]
coords_z=[]
for i in graph.nodes():
	#coords_x.append(int(graph_node(i)[2])+indice_debut_polygone)	## FA: Modif 11/10/2018 on rajoute la coordonnée X du crop dans le XLS !
	coords_x.append(int(graph_node(i)[2]))
	coords_y.append(int(graph_node(i)[1]))
	coords_z.append(int(graph_node(i)[0]))


#NodeID = List_noeud_graph_bifurc[BifNum]
NodeID = BifNum

BifCoords = np.asarray((coords_x[NodeID], coords_y[NodeID], coords_z[NodeID]))
print(BifCoords)

width = 64
hwidth = int(width/2)
Xcrop = int(BifCoords[0])
Ycrop = int(BifCoords[1])
Zcrop = int(BifCoords[2])

CropGL = stackGray[Zcrop - hwidth : Zcrop + hwidth, Ycrop - hwidth : Ycrop + hwidth, Xcrop - hwidth : Xcrop + hwidth]
CropBin = stackSegm[Zcrop - hwidth : Zcrop + hwidth, Ycrop - hwidth : Ycrop + hwidth, Xcrop - hwidth : Xcrop + hwidth]


''' '''
outputname_G = FileDir + FileName + '_G.nrrd'
sitk.WriteImage(sitk.GetImageFromArray(np.uint8(CropGL)), outputname_G)
outputname_B = FileDir + FileName + '_B.nrrd'
sitk.WriteImage(sitk.GetImageFromArray(np.uint8(CropBin)), outputname_B)
''' '''
