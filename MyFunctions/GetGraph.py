#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Copyright - Florent Autrusseau
contributor(s) : Florent Autrusseau, Rafic Nader (February 2023)

Florent.Autrusseau@univ-nantes.fr
Rafic.Nader@univ-nantes.fr

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

#import mayavi.mlab as mlab
#from mayavi.mlab import points3d
#from mayavi.mlab import plot3d
#from affiche_point import affiche_point

# Local imports:
import sknw
#import time
#import cv2
#import math
#import argparse
#import numpy as np
#import pandas as pd
#import skimage.util
#from math import sqrt
#from math import acos
#import SimpleITK as sitk
#from scipy import ndimage
#from pathlib import Path
#from decimal import Decimal
#from pandas import ExcelWriter
#import sys, os, glob, platform
#from scipy.stats import entropy
#import matplotlib.pyplot as plt
#import skimage.io #algos de traitement d'images
#import scipy.ndimage as ndi #pour la distance transform
from skimage.morphology import skeletonize_3d

from MyFunctions.cross_section_diameter2021 import *

#########################################################################################################

def GetGraph(stack):

	ske = skeletonize_3d(np.uint8(stack)).astype(np.uint8)
	graph = sknw.build_sknw(ske)

	stack[stack>0]=255

	#print('----- Preprocessing de la stack')
	#-------------------------------------------------------------------------------------------
	#pré-processing pour supprimer les petits voxels associés au bruit + supprimer du squelette les petites artères dont length<10 + réduire dans le squellete les artères dont length>=25
	for i in graph.nodes():

		if len(list(graph.neighbors(i)))==0: #supression des petits voxels associés au bruit
			pts=graph.nodes[i]['pts']
			for k in range(len(pts)):
				ske[int(pts[k][0]),int(pts[k][1]),int(pts[k][2]) ]=0

		elif len(list(graph.neighbors(i)))==1	  :	#supression des suites de voxels associés au bruit
			if len(  list(graph.neighbors( list(graph.neighbors(i))[0] ) ) )==1:
				neighbor=list(graph.neighbors(i) ) [0]
				pts=graph[i][neighbor]['pts'].copy()
				coords_center_bif=graph.nodes[i]['o']
				if(np.linalg.norm(pts[0]- coords_center_bif)> np.linalg.norm(pts[len(pts )-1]- coords_center_bif)):
					pts=list(reversed(pts ) )
				pts=np.vstack( [ graph.nodes[i ][ 'o'] , pts  ] )
				pts=np.vstack( [ pts ,graph.nodes[neighbor ][ 'o'] ] )

				for k in range(len(pts)):
					ske[int(pts[k][0]),int(pts[k][1]),int(pts[k][2]) ]=0

				pts=graph.nodes[i]['pts']
				for k in range(len(pts)):
					ske[int(pts[k][0]),int(pts[k][1]),int(pts[k][2]) ]=0

				pts=graph.nodes[neighbor]['pts']
				for k in range(len(pts)):
					ske[int(pts[k][0]),int(pts[k][1]),int(pts[k][2]) ]=0
		else:
			neighbors=list(graph.neighbors(i))
			for j in range(len(neighbors)):

				#if (len(graph[i][neighbors[j]]['pts']) <=5 ): #suppresion dans le skelette des petites artères
				if (len(graph[i][neighbors[j]]['pts']) <= 2):  # suppresion dans le skelette des petites artères
					if ( len(  list(graph.neighbors(neighbors[j]))  )==1) :
						neighbor=neighbors[j]
						pts=graph[i][neighbor]['pts'].copy()
						coords_center_bif=graph.nodes[i]['o']
						if(np.linalg.norm(pts[0]- coords_center_bif)> np.linalg.norm(pts[len(pts )-1]- coords_center_bif)):
							pts=list(reversed(pts ) )
						pts=np.vstack( [ pts ,graph.nodes[neighbors[j] ][ 'o'] ] )

						for k in range(len(pts)):
							ske[int(pts[k][0]),int(pts[k][1]),int(pts[k][2]) ]=0

						pts=graph.nodes[neighbor]['pts']
						for k in range(len(pts)):
							ske[int(pts[k][0]),int(pts[k][1]),int(pts[k][2]) ]=0

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

	#print('nb of analyzed bif : %d\n' %(len(ListBifurcBox)))
	#print('\n')

	#extraction du polygone et supression du crane par projection sur l'axe des x (on prend en compte l'intensité suivant tous les x peu import y et z)
	graph = sknw.build_sknw(ske)


	return(graph)

#########################################################################################################
def GetGraph2(stack):

	ske = skeletonize_3d(np.uint8(stack)).astype(np.uint8)
	graph = sknw.build_sknw(ske)

	"""
	ske = np.zeros(stack.shape)
	for i in range(len(graph)):
		Neighb = list(graph.neighbors(i))
		for j in range(len(Neighb)):
			branch = graph[i][Neighb[j]]['pts']
			for k in range(len(branch)):
				z = branch[k][0]
				y = branch[k][1]
				x = branch[k][2]
				ske[z, y, x] = 1

	#graph = sknw.build_sknw(ske)
	"""

	"""
	for i in graph.nodes():
    	node_centers.append(graph.nodes[i]['o'])
	"""

	return(graph)

#########################################################################################################

def get_diameters(stack, bif_id): #bif_id must be in List_noeud_graph_bifurc

	z,y,x = stack.shape
	print('image size : (x,y,z) = (%d,%d,%d)' %(x,y,z))
	ske = skeletonize_3d(stack).astype(np.uint16)
	graph = sknw.build_sknw(ske)
	stack[stack>0]=255

	#-------------------------------------------------------------------------------------------
	#detection des centres de bifurcations
	z,y,x = stack.shape
	ListBifurcBox=[]
	List_noeud_graph_bifurc=[]
	for j in range(len(graph)):
		if len( list(graph.neighbors(j) ) )>2   :
			neighbors=list(graph.neighbors(j))
			#print(neighbors)
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

	print('nbr bif : ',len(List_noeud_graph_bifurc))

	if bif_id not in List_noeud_graph_bifurc:
		print("Error : bifurcation hasn't been detected")
		return -1


	diamMinCrossSection_tab_neighbors=np.zeros((1,4))
	diamMinCrossSection_tab_neighbors[:]=-1

	diamMaxCrossSection_tab_neighbors=np.zeros((1,4))
	diamMaxCrossSection_tab_neighbors[:]=-1


	print("Bifurcation n° " + str(bif_id) + " with %d branches is being analyzed" %(len(neighbors)))

	center=bif_id#List_noeud_graph_bifurc[M]
	coords_center=graph.nodes[center]['o']
	neighbors=list(graph.neighbors(center))

	if len(neighbors)<3:
		print("Error : Bifurcation corrupted")
		return  -1


	area_cross_section=[]
	somme_area_section=0
	somme_diamMin=0
	somme_diamMax=0
	area_section=0
	moy_area_section=0
	moy_diam_min=moy_diam_max=0
	M=0

	for N in range(len(neighbors)):
		#print('N: ',N)

		noeud1=bif_id#List_noeud_graph_bifurc[M]
		noeud2=neighbors[N] #voisin
		#print('noeud1 ', noeud1, '	noeud2 ', noeud2 )

		pts=graph[noeud1][noeud2]['pts'].copy()
		if len(pts) <5:#avant 4
			area_cross_section.append(-1)
			continue


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

			noeud1=bif_id#List_noeud_graph_bifurc[M]
			noeud2=neighbors[N] #voisin
			#print('noeud1 ', noeud1, '	noeud2 ', noeud2 )

			pts=graph[noeud1][noeud2]['pts'].copy()


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
			moy_diam_min= (diamMin1 + diamMin2+ diamMin3)/3.
			moy_diam_max= (diamMax1+diamMax2+diamMax3)/3.

			diamMinCrossSection_tab_neighbors[M,N]=moy_diam_min
			diamMaxCrossSection_tab_neighbors[M,N]=moy_diam_max

			#areaCrossSection_tab_neighbors[M,N]=  (moy_diam_min/2.)*(moy_diam_min/2.)*np.pi#PIxR^2 au lieu de somme_area_section/2.

	res={}
	res['graph']=graph
	res['diamMin branch 0']=diamMinCrossSection_tab_neighbors[M,0]
	res['diamMax branch 0']=diamMaxCrossSection_tab_neighbors[M,0]
	res['diamMin branch 1']=diamMinCrossSection_tab_neighbors[M,1]
	res['diamMax branch 1']=diamMaxCrossSection_tab_neighbors[M,1]
	res['diamMin branch 2']=diamMinCrossSection_tab_neighbors[M,2]
	res['diamMax branch 2']=diamMaxCrossSection_tab_neighbors[M,2]
	res['id neighbor 0']=neighbors[0]
	res['id neighbor 1']=neighbors[1]
	res['id neighbor 2']=neighbors[2]


	if len(neighbors)==4:
		res['diamMin branch 3']=diamMinCrossSection_tab_neighbors[M,3]
		res['diamMax branch 3']=diamMaxCrossSection_tab_neighbors[M,3]
		res['id neighbor 3']=neighbors[3]

	print("\n-->result: ", res)
	return res
