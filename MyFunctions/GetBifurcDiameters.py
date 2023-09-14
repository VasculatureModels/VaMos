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



#import sknw
#import skimage.io
#import numpy as np
#import skimage.util
#import SimpleITK as sitk
#from scipy import signal
#import scipy.ndimage as ndi
#from scipy import interpolate
#from skimage import morphology
#from skimage.morphology import skeletonize_3d
from scipy import ndimage

from MyFunctions.cross_section_diameter2021 import *

#########################################################################################################

def GetChunkDiam(Coords_Branch, stackSegm):

	#stackSegmPad = np.zeros((stackSegm.shape[0]+32, stackSegm.shape[1]+32, stackSegm.shape[2]+32))
	stackSegm[stackSegm > 1] = 1

	''' Extract skeleton of Branch #i : '''
	BranchSkel = np.zeros(stackSegm.shape, dtype=np.uint8)
	for j in range(len(Coords_Branch)):
		zb = Coords_Branch[j,0]# + 32
		yb = Coords_Branch[j,1]# + 32
		xb = Coords_Branch[j,2]# + 32
		BranchSkel[zb,yb,xb] = 1

	#minX = min(Coords_Branch[:,2] + 32)-20; maxX = max(Coords_Branch[:,2] + 32)+20
	#minY = min(Coords_Branch[:,1] + 32)-20; maxY = max(Coords_Branch[:,1] + 32)+20
	#minZ = min(Coords_Branch[:,0] + 32)-20; maxZ = max(Coords_Branch[:,0] + 32)+20
	'''
	minX = min(Coords_Branch[:,2])-20; maxX = max(Coords_Branch[:,2])+20
	minY = min(Coords_Branch[:,1])-20; maxY = max(Coords_Branch[:,1])+20
	minZ = min(Coords_Branch[:,0])-20; maxZ = max(Coords_Branch[:,0])+20

	CroppedBranch = BranchSkel[minZ:maxZ, minY:maxY, minX:maxX]
	CroppedStackSegm = stackSegm[minZ:maxZ, minY:maxY, minX:maxX]
	'''

	''' Get the outside enveloppe of the vasculature : '''
	dilatedStack = ndimage.binary_dilation(stackSegm).astype(stackSegm.dtype)

	#kern = np.zeros((3,3,3)).astype(bool)
	#ndimage.binary_dilation(CroppedStackSegm, structure=kern).astype(CroppedStackSegm.dtype)

	stackEnv = np.subtract(dilatedStack, stackSegm)
	#sitk.WriteImage(sitk.GetImageFromArray(np.uint8(stackEnv*100)), '~/Desktop/stackEnv.nrrd')

	if stackEnv.max() > 1:
		stackEnv[stackEnv > 1] = 1

	stackEnvSkel = np.add(stackEnv, BranchSkel)
	#sitk.WriteImage(sitk.GetImageFromArray(np.uint8(stackEnvSkel*100)), '~/Desktop/stackEnvSkel_' + str(idx) + '.nrrd')

	sumStack = np.zeros(BranchSkel.shape)
	radius = 1
	dilatedSkel = np.copy(BranchSkel)
	while sumStack.max() < 2:
		#b = morphology.ball(radius=radius)
		#dilatedSkel = signal.fftconvolve(dilatedSkel, b, mode='same') > 0
		dilatedSkel = ndimage.binary_dilation(dilatedSkel).astype(dilatedSkel.dtype)
		sumStack = np.add(stackEnv, dilatedSkel)
		radius += 1
		#sitk.WriteImage(sitk.GetImageFromArray(np.uint8(sumStack*100)), '~/Desktop/sumStack_' + str(radius) + '.nrrd')

	''' We want the dilated skeleton to reach the outer artery enveloppe on half (OR a third) the enveloppe's voxels '''
	#Th = (np.pi * radius * len(Coords_Branch)) / 2
	Th = (np.pi * radius * len(Coords_Branch)) / 3

	while len(np.where(sumStack == 2)[0]) < Th:
		#b = morphology.ball(radius=radius)
		#dilatedSkel = signal.fftconvolve(dilatedSkel, b, mode='same') > 0
		dilatedSkel = ndimage.binary_dilation(dilatedSkel).astype(dilatedSkel.dtype)
		sumStack = np.add(stackEnv, dilatedSkel)
		radius += 1
		#sitk.WriteImage(sitk.GetImageFromArray(np.uint8(sumStack*100)), '~/Desktop/sumStack_' + str(radius) + '.nrrd')

	if radius >= 4 :
		radius -= 1
	diameter = radius * 2
	#diameter = int(radius * sqrt(2))

	#sitk.WriteImage(sitk.GetImageFromArray(np.uint8(sumStack*100)), '~/Desktop/sumStack1_' + str(idx) + '.nrrd')
	"""
	''' Nb of overlapping voxels : '''
	zov, yov, xov = np.where(sumStack==2)
	NbVoxOverlap = len(zov)

	''' Estimation of the number of voxels of the branch's enveloppe : '''
	NbVoxEnv = int(np.pi * (diameter+1) * len(Coords_Branch))

	print('Branch #%d, \tdiameter : %d, \tlength : %d' %(NN[idx], diameter, len(Coords_Branch)))

	''' Launch the loop again but now with a condition on the number of overlapping voxels : '''
	sumStack = np.zeros(CroppedBranch.shape)
	radius = 0
	dilatedSkel = np.copy(CroppedBranch)
	while NbVoxOverlap < int(NbVoxEnv/R) :
		dilatedSkel = ndimage.binary_dilation(dilatedSkel).astype(dilatedSkel.dtype)
		sumStack = np.add(stackEnv, dilatedSkel)
		zov, yov, xov = np.where(sumStack==2)
		NbVoxOverlap = len(zov)
		radius += 1

	diameter = radius * 2
	"""

	#print('  Branch #%d, \tdiameter : %d, \tlength : %d' %(NN[idx], diameter, len(Coords_Branch)))

	#sitk.WriteImage(sitk.GetImageFromArray(np.uint8(sumStack*100)), '~/Desktop/sumStack_B' + str(BifNum) + '_N' + str(NN[idx]) + '.nrrd')

	return(diameter, sumStack)


#########################################################################################################

def GetChunkDiam_v2(Coords_Branch, stackSegm, stackGray):

	#stackSegmPad = np.zeros((stackSegm.shape[0]+32, stackSegm.shape[1]+32, stackSegm.shape[2]+32))
	stackSegm[stackSegm > 1] = 1

	''' Extract skeleton of Branch #i : '''
	BranchSkel = np.zeros(stackSegm.shape, dtype=np.uint8)
	for j in range(len(Coords_Branch)):
		zb = int(Coords_Branch[j,0])# + 32
		yb = int(Coords_Branch[j,1])# + 32
		xb = int(Coords_Branch[j,2])# + 32
		BranchSkel[zb,yb,xb] = 1

	#minX = min(Coords_Branch[:,2] + 32)-20; maxX = max(Coords_Branch[:,2] + 32)+20
	#minY = min(Coords_Branch[:,1] + 32)-20; maxY = max(Coords_Branch[:,1] + 32)+20
	#minZ = min(Coords_Branch[:,0] + 32)-20; maxZ = max(Coords_Branch[:,0] + 32)+20
	'''
	minX = min(Coords_Branch[:,2])-20; maxX = max(Coords_Branch[:,2])+20
	minY = min(Coords_Branch[:,1])-20; maxY = max(Coords_Branch[:,1])+20
	minZ = min(Coords_Branch[:,0])-20; maxZ = max(Coords_Branch[:,0])+20

	CroppedBranch = BranchSkel[minZ:maxZ, minY:maxY, minX:maxX]
	CroppedStackSegm = stackSegm[minZ:maxZ, minY:maxY, minX:maxX]
	'''

	''' Get the outside enveloppe of the vasculature : '''
	#dilatedStack = ndimage.binary_dilation(stackSegm).astype(stackSegm.dtype)
	#stackEnv = np.subtract(dilatedStack, stackSegm)

	erodedStack = ndimage.binary_erosion(stackSegm).astype(stackSegm.dtype)
	stackEnv = np.subtract(stackSegm, erodedStack)
	#sitk.WriteImage(sitk.GetImageFromArray(np.uint8(stackEnv*100)), '~/Desktop/stackEnv.nrrd')

	#if stackEnv.max() > 1:
	#	stackEnv[stackEnv > 1] = 1
	stackEnv[stackEnv > 1] = 1

	#stackEnvSkel = np.add(stackEnv, BranchSkel)
	#sitk.WriteImage(sitk.GetImageFromArray(np.uint8(stackEnvSkel*100)), '~/Desktop/stackEnvSkel_' + str(idx) + '.nrrd')

	sumStack = np.zeros(BranchSkel.shape)
	radius = 1
	dilatedSkel = np.copy(BranchSkel)
	while sumStack.max() < 2:
		#b = morphology.ball(radius=radius)
		#dilatedSkel = signal.fftconvolve(dilatedSkel, b, mode='same') > 0
		dilatedSkel = ndimage.binary_dilation(dilatedSkel).astype(dilatedSkel.dtype)
		sumStack = np.add(stackEnv, dilatedSkel)
		radius += 1
		#sitk.WriteImage(sitk.GetImageFromArray(np.uint8(sumStack*100)), '~/Desktop/sumStack_' + str(radius) + '.nrrd')

	#radius -= 1
	if radius >= 6 :
		radius -= 2

	''' We want the dilated skeleton to reach the outer artery enveloppe on half (OR a third) the enveloppe's voxels '''
	"""
	#Th = (np.pi * radius * len(Coords_Branch)) / 2
	Th = (np.pi * radius * len(Coords_Branch)) / 3
	#radius = 1
	while len(np.where(sumStack == 2)[0]) < Th:
		#b = morphology.ball(radius=radius)
		#dilatedSkel = signal.fftconvolve(dilatedSkel, b, mode='same') > 0
		dilatedSkel = ndimage.binary_dilation(dilatedSkel).astype(dilatedSkel.dtype)
		sumStack = np.add(stackEnv, dilatedSkel)
		radius += 1
		#sitk.WriteImage(sitk.GetImageFromArray(np.uint8(sumStack*100)), '~/Desktop/sumStack_' + str(radius) + '.nrrd')

	#radius -= 1
	if radius >= 3 :
		radius -= 1
	"""

	diameter = radius * 2

	GrayBranch  = dilatedSkel * stackGray
	MaxBranch = GrayBranch.max()
	#MeanBranch = GrayBranch.mean()
	MeanBranch = GrayBranch[np.nonzero(GrayBranch)].mean()
	Pctile75 = (MeanBranch + MaxBranch) / 2.

	#sitk.WriteImage(sitk.GetImageFromArray(np.uint8(sumStack*100)), '~/Desktop/sumStack1_' + str(idx) + '.nrrd')
	"""
	''' Nb of overlapping voxels : '''
	zov, yov, xov = np.where(sumStack==2)
	NbVoxOverlap = len(zov)

	''' Estimation of the number of voxels of the branch's enveloppe : '''
	NbVoxEnv = int(np.pi * (diameter+1) * len(Coords_Branch))

	print('Branch #%d, \tdiameter : %d, \tlength : %d' %(NN[idx], diameter, len(Coords_Branch)))

	''' Launch the loop again but now with a condition on the number of overlapping voxels : '''
	sumStack = np.zeros(CroppedBranch.shape)
	radius = 0
	dilatedSkel = np.copy(CroppedBranch)
	while NbVoxOverlap < int(NbVoxEnv/R) :
		dilatedSkel = ndimage.binary_dilation(dilatedSkel).astype(dilatedSkel.dtype)
		sumStack = np.add(stackEnv, dilatedSkel)
		zov, yov, xov = np.where(sumStack==2)
		NbVoxOverlap = len(zov)
		radius += 1

	diameter = radius * 2
	"""

	#print('  Branch #%d, \tdiameter : %d, \tlength : %d' %(NN[idx], diameter, len(Coords_Branch)))

	#sitk.WriteImage(sitk.GetImageFromArray(np.uint8(sumStack*100)), '~/Desktop/sumStack_B' + str(BifNum) + '_N' + str(NN[idx]) + '.nrrd')

	return(diameter, sumStack, MaxBranch, Pctile75)

#########################################################################################################



def get_area_diam(Coords_Branch, stack ):
		area_cross_section=[]
		somme_area_section=0
		somme_diamMin=0
		somme_diamMax=0
		area_section=0
		moy_area_section=0
		moy_diam_min=moy_diam_max=0

		pts=Coords_Branch.copy()
		if len(Coords_Branch) <5:#avant 4
			area_cross_section.append(-1)
			return -1, -1

		else:

			point_voisin_orig=point_voisin=pts[int(len(pts)/2)]
			pts_sub=pts[0:int(len(pts)/2)]
			if len(pts_sub)<20:
				point_cible=point_cible_orig=pts_sub[int(len(pts_sub)/2)]
			else:
				point_cible=point_cible_orig=pts[int(len(pts)/2)+8]

			#point_cible_orig=point_cible=pts[int(len(pts)/2) +3]

			zb,yb,xb=point_cible=point_cible_orig

			#extraction de la bif
			a=zb-30
			b=zb+30
			c=yb-30
			d=yb+30
			e= xb-30
			f= xb+30

			if a<0:
					a=0
			if b<0:
					b=0
			if c<0:
					c=0
			if d<0:
					d=0
			if e<0:
					e=0
			if f<0:
					f=0

			stack_polygone_x_upd=np.uint16(stack)
			stack_polygone_x_upd[point_voisin[0], point_voisin[1],point_voisin[2] ]=355
			stack_polygone_x_upd[point_cible[0], point_cible[1],point_cible[2] ]=400
			vol=stack_polygone_x_upd[a:b, c:d,e:f]
			if vol.shape[0]!=60:
				vol2=np.zeros((60,60,60))
				res=np.where(vol>0)
				vol2[res[0],res[1],res[2]]= vol[res[0],res[1],res[2]]
				vol=vol2

			#vol_orig=vol.copy()
			coords_point_voisin=np.where(vol[:,:,:]==355)
			point_voisin[0]=coords_point_voisin[0][0]
			point_voisin[1]=coords_point_voisin[1][0]
			point_voisin[2]=coords_point_voisin[2][0]
			coords_point_cible=np.where(vol[:,:,:]==400)
			point_cible[0]=coords_point_cible[0][0]
			point_cible[1]=coords_point_cible[1][0]
			point_cible[2]=coords_point_cible[2][0]
			#point_cible_orig=point_cible.copy()
			#point_voisin_orig=point_voisin.copy()
			#pts_orig=pts.copy()

			if point_cible[0].size==0 or point_cible[1].size==0 or point_cible[2].size==0:
				#point_cible_orig=np.where(vol==400)
				dist=[]
				res_new_vol=np.where(vol>0)
				for i in range(len(res_new_vol[0])):
					tmp=np.array([res_new_vol[0][i],res_new_vol[1][i],res_new_vol[2][
						i]])
					dist.append(np.linalg.norm(tmp - point_cible_orig))

				ind=dist.index(min(dist))

				point_cible=np.array([res_new_vol[0][ind], res_new_vol[1][ind], res_new_vol[2][ind] ])

			if point_voisin[0].size==0 or point_voisin[1].size==0 or point_voisin[2].size==0:
				#point_voisin_orig=np.where(vol==355)
				dist=[]
				res_new_vol=np.where(vol>0)
				for i in range(len(res_new_vol[0])):
					tmp=np.array([res_new_vol[0][i],res_new_vol[1][i],res_new_vol[2][
								i]])
					dist.append(np.linalg.norm(tmp - point_voisin_orig))

				ind=dist.index(min(dist))

				point_voisin=np.array([res_new_vol[0][ind], res_new_vol[1][ind], res_new_vol[2][ind] ])


			area_section1, diamMin1, diamMax1, slice3d1=cross_section_diameter2021(vol, point_cible,point_voisin)
			vol[point_cible[0],point_cible[1],point_cible[2]]=355
			vol[point_voisin[0],point_voisin[1],point_voisin[2]]=400


			area_section2, diamMin2, diamMax2, slice3d2=cross_section_diameter2021(vol, point_voisin,point_cible)




			#------


			#noeud1=List_noeud_graph_bifurc[M]
			#noeud2=neighbors[N] #voisin
			#print('noeud1 ', noeud1, '    noeud2 ', noeud2 )

			pts=Coords_Branch#graph[noeud1][noeud2]['pts'].copy()
			#uen troisieme valeur de area_cross + diamMin + diamMax
			#point_voisin_orig=point_voisin=pts[int(len(pts)/2)]
			#pts_sub=pts[0:int(len(pts)/2)]
			#point_voisin=pts[int(len(pts_sub)/2)]

			point_voisin_orig=point_voisin=pts[int(len(pts)/2)]
			pts_sub=pts[int(len(pts)/2) :len(pts)]
			if len(pts_sub)<20:
				point_cible=point_cible_orig=pts_sub[int(len(pts_sub)/2)]
			else:
				point_cible=point_cible_orig=pts[int(len(pts)/2)-8]

			zb,yb,xb=point_cible=point_cible_orig

			#extraction de la bif
			a=zb-30
			b=zb+30
			c=yb-30
			d=yb+30
			e= xb-30
			f= xb+30

			if a<0:
					a=0
			if b<0:
					b=0
			if c<0:
					c=0
			if d<0:
					d=0
			if e<0:
					e=0
			if f<0:
					f=0

			stack_polygone_x_upd=np.uint16(stack)
			stack_polygone_x_upd[point_voisin[0], point_voisin[1],point_voisin[2] ]=355
			stack_polygone_x_upd[point_cible[0], point_cible[1],point_cible[2] ]=400
			vol=stack_polygone_x_upd[a:b, c:d,e:f]
			if vol.shape[0]!=60:
				vol2=np.zeros((60,60,60))
				res=np.where(vol>0)
				vol2[res[0],res[1],res[2]]= vol[res[0],res[1],res[2]]
				vol=vol2

			#vol_orig=vol.copy()
			coords_point_voisin=np.where(vol[:,:,:]==355)
			point_voisin[0]=coords_point_voisin[0][0]
			point_voisin[1]=coords_point_voisin[1][0]
			point_voisin[2]=coords_point_voisin[2][0]
			coords_point_cible=np.where(vol[:,:,:]==400)
			point_cible[0]=coords_point_cible[0][0]
			point_cible[1]=coords_point_cible[1][0]
			point_cible[2]=coords_point_cible[2][0]
			#point_cible_orig=point_cible.copy()
			#point_voisin_orig=point_voisin.copy()
			#pts_orig=pts.copy()

			if point_cible[0].size==0 or point_cible[1].size==0 or point_cible[2].size==0:
				#point_cible_orig=np.where(vol==400)
				dist=[]
				res_new_vol=np.where(vol>0)
				for i in range(len(res_new_vol[0])):
					tmp=np.array([res_new_vol[0][i],res_new_vol[1][i],res_new_vol[2][
						i]])
					dist.append(np.linalg.norm(tmp - point_cible_orig))

				ind=dist.index(min(dist))

				point_cible=np.array([res_new_vol[0][ind], res_new_vol[1][ind], res_new_vol[2][ind] ])

			if point_voisin[0].size==0 or point_voisin[1].size==0 or point_voisin[2].size==0:
				#point_voisin_orig=np.where(vol==355)
				dist=[]
				res_new_vol=np.where(vol>0)
				for i in range(len(res_new_vol[0])):
					tmp=np.array([res_new_vol[0][i],res_new_vol[1][i],res_new_vol[2][
								i]])
					dist.append(np.linalg.norm(tmp - point_voisin_orig))

				ind=dist.index(min(dist))

				point_voisin=np.array([res_new_vol[0][ind], res_new_vol[1][ind], res_new_vol[2][ind] ])


			area_section3, diamMin3, diamMax3, slice3d3=cross_section_diameter2021(vol, point_cible,point_voisin)


			moy_diam_min=moy_diam_max=0
			#areaCrossSection_tab_neighbors_id[M,N]= neighbors[N]
			moy_diam_min= (diamMin1 + diamMin2+ diamMin3)/3.
			moy_diam_max= (diamMax1+diamMax2+diamMax3)/3.

		return moy_diam_min, moy_diam_max
