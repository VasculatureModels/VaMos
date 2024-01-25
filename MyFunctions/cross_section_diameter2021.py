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

import numpy as np
import math
from scipy.ndimage import map_coordinates
import skimage.util
import cv2

import MyFunctions.transformation_code_externe
from MyFunctions.transformation_code_externe import rotation_matrix
from MyFunctions.PyRotateImgProjectFor_diamMax_diamMin_function import *

def cross_section_diameter2021(vol, point_cible,point_voisin):
	mat=0
	#new_vol_colZ=0
	#new_vol_perpX=0
	coupe_x=coupe_y=coupe_plan_xy=0
	dim=vol.shape[0]
	if point_voisin[0]==point_cible[0] and point_voisin[1]==point_cible[1]:
		coupe_plan_xy=1
		#print("here1")
	else:
		vec_dir= np.array([point_voisin[0],point_voisin[1],0 ]) - np.array([point_cible[0],point_cible[1],0 ])
		vec_dir_norm= vec_dir/np.linalg.norm(vec_dir)
		axe_x=[1,0,0]
		axe_y=[0,1,0]
		axe_z=[0,0,1]
		alpha=1
		angle_x=math.atan2(np.linalg.norm(np.cross(vec_dir_norm,axe_x)), vec_dir_norm.dot(axe_x))
		if angle_x*180/np.pi>90 and (vec_dir[0]>=0 and vec_dir[1]>=0 and vec_dir[2]>=0):
			angle_x=angle_x-np.pi/2
		elif angle_x*180/np.pi>90 and (vec_dir[0]<0 and vec_dir[1]>=0 and vec_dir[2]>=0):#VER
			angle_x = np.pi - angle_x
		elif angle_x*180/np.pi>90 and (vec_dir[0]<0 and vec_dir[1]<0 and vec_dir[2]>=0): #Ver
			angle_x = -(np.pi - angle_x)
		elif angle_x*180/np.pi>90 and (vec_dir[0]<0 and vec_dir[1]>=0 and vec_dir[2]>=0): #Ver
			 angle_x=-angle_x
		elif angle_x*180/np.pi<90 and angle_x*180/np.pi>0 and vec_dir[0]>=0 and vec_dir[1]>=0 and vec_dir[2]>=0: #Ver
			angle_x=-angle_x
			alpha=-1
		elif angle_x*180/np.pi<90 and angle_x*180/np.pi>0  and  vec_dir[0]<0 and vec_dir[1]<0 and vec_dir[2]>=0: #verified
			angle_x=angle_x
			alpha=-1
		#elif angle_x*180/np.pi>90 and (vec_dir[0]<0 and vec_dir[1]<0 and vec_dir[2]>=0):
			#angle_x= angle_x - np.pi/2
			#alpha=-1
		elif angle_x*180/np.pi<90 and angle_x*180/np.pi>0  and (vec_dir[0]<0 and vec_dir[1]>=0 and vec_dir[2]>=0): #verified
			angle_x=np.pi-angle_x
		elif angle_x*180/np.pi<90 and angle_x*180/np.pi>0  and (vec_dir[0]>=0 and vec_dir[1]<0 and vec_dir[2]>=0): #verified
			angle_x=angle_x
			alpha=-1
		else:
			angle_x=angle_x
		flag=0
		#print("here2")
		if angle_x*180/np.pi!=90 and angle_x*180/np.pi!=0:
			##print("---> first ")
			flag=1
			#--------------------------first rotation around Z to make the vec_dir col to axisX----------
			mat=rotation_matrix(angle_x,(0,0,1))
			dim=vol.shape[0]
			ax=np.arange(dim)
			coords=np.meshgrid(ax,ax,ax)

			# stack the meshgrid to position vectors,
			xyz=np.vstack([coords[0].reshape(-1) ,
				coords[1].reshape(-1) ,
				coords[2].reshape(-1) ,
			np.ones((dim,dim,dim)).reshape(-1)]) # 1 for homogeneous coordinates


			#ramener les coordonnées de toute la stack dans le repère associé au point cible

			xyz[0]=xyz[0]-float(point_cible[1]) #pour l'affichage mayavi et meshgrid, x et y et z se situent   en [1],[0] et [2] car x,yz dans le code = y,x,z dans mayavi
			xyz[1]=xyz[1]-float(point_cible[0])
			xyz[2]=xyz[2]-float(point_cible[2])

			transformed_xyz=np.dot(mat, xyz)

			# extract coordinates, don't use transformed_xyz[3,:] that's the homogeneous coordinate, always 1

			x=transformed_xyz[0,:] + float(point_cible[1])
			y=transformed_xyz[1,:] +float(point_cible[0])
			z=transformed_xyz[2,:] +float(point_cible[2])


			x=x.reshape((dim,dim,dim))
			y=y.reshape((dim,dim,dim))
			z=z.reshape((dim,dim,dim))


			new_xyz=[y,x,z]

			# sample
			new_vol_perpX= map_coordinates(vol,new_xyz, order=0)
			#print("here3")

		elif angle_x*180/np.pi==0 or angle_x*180/np.pi==180: #to make it perp to axe_y
			##print("---> second ")
			alpha=	alpha*math.acos( (point_voisin[2]-point_cible[2])/(np.sqrt( (point_voisin[0]-point_cible[0])*(point_voisin[0]-point_cible[0]) + (point_voisin[1]-point_cible[1])*(point_voisin[1]-point_cible[1]) + (point_voisin[2]-point_cible[2])*(point_voisin[2]-point_cible[2])  )) )
			if alpha*180/np.pi==90.0:
				coupe_y=1
				#print("here4")
			else:
				if vec_dir[0]>=0 and vec_dir[1]>=0 and vec_dir[2]>=0:
					mat=rotation_matrix(-alpha,(1,0,0))

				else:
					mat=rotation_matrix(alpha,(1,0,0))
				dim=vol.shape[0]
				ax=np.arange(dim)
				coords=np.meshgrid(ax,ax,ax)

				# stack the meshgrid to position vectors,
				xyz=np.vstack([coords[0].reshape(-1) ,
					coords[1].reshape(-1) ,
					coords[2].reshape(-1) ,
				np.ones((dim,dim,dim)).reshape(-1)]) # 1 for homogeneous coordinates


				#ramener les coordonnées de toute la stack dans le repère associé au point cible

				xyz[0]=xyz[0]-float(point_cible[1]) #pour l'affichage mayavi et meshgrid, x et y et z se situent   en [1],[0] et [2] car x,yz dans le code = y,x,z dans mayavi
				xyz[1]=xyz[1]-float(point_cible[0])
				xyz[2]=xyz[2]-float(point_cible[2])

				transformed_xyz=np.dot(mat, xyz)

				# extract coordinates, don't use transformed_xyz[3,:] that's the homogeneous coordinate, always 1

				x=transformed_xyz[0,:] + float(point_cible[1])
				y=transformed_xyz[1,:] +float(point_cible[0])
				z=transformed_xyz[2,:] +float(point_cible[2])


				x=x.reshape((dim,dim,dim))
				y=y.reshape((dim,dim,dim))
				z=z.reshape((dim,dim,dim))


				new_xyz=[y,x,z]

				# sample
				new_vol_colZ= map_coordinates(vol,new_xyz, order=0)
				#print("here5")


		elif angle_x*180/np.pi==90.0:
			#angle_z=math.atan2(np.linalg.norm(np.cross(vec_dir_norm,axe_z)), vec_dir_norm.dot(axe_z))
			##print("bis")
			alpha=	alpha*math.acos( (point_voisin[2]-point_cible[2])/(np.sqrt( (point_voisin[0]-point_cible[0])*(point_voisin[0]-point_cible[0]) + (point_voisin[1]-point_cible[1])*(point_voisin[1]-point_cible[1]) + (point_voisin[2]-point_cible[2])*(point_voisin[2]-point_cible[2])  )) )

			if alpha*180/np.pi==90:
				coupe_x=1
				#print("here6")
			else:

				if vec_dir[0]>=0 and vec_dir[1]<0 and vec_dir[2]>=0:
					alpha=np.pi-alpha
				mat=rotation_matrix(alpha,(0,1,0))
				dim=vol.shape[0]
				ax=np.arange(dim)
				coords=np.meshgrid(ax,ax,ax)

				# stack the meshgrid to position vectors,
				xyz=np.vstack([coords[0].reshape(-1) ,
					coords[1].reshape(-1) ,
					coords[2].reshape(-1) ,
				np.ones((dim,dim,dim)).reshape(-1)]) # 1 for homogeneous coordinates


				#ramener les coordonnées de toute la stack dans le repère associé au point cible

				xyz[0]=xyz[0]-float(point_cible[1]) #pour l'affichage mayavi et meshgrid, x et y et z se situent   en [1],[0] et [2] car x,yz dans le code = y,x,z dans mayavi
				xyz[1]=xyz[1]-float(point_cible[0])
				xyz[2]=xyz[2]-float(point_cible[2])

				transformed_xyz=np.dot(mat, xyz)

				# extract coordinates, don't use transformed_xyz[3,:] that's the homogeneous coordinate, always 1

				x=transformed_xyz[0,:] + float(point_cible[1])
				y=transformed_xyz[1,:] +float(point_cible[0])
				z=transformed_xyz[2,:] +float(point_cible[2])


				x=x.reshape((dim,dim,dim))
				y=y.reshape((dim,dim,dim))
				z=z.reshape((dim,dim,dim))


				new_xyz=[y,x,z]

				# sample
				new_vol_colZ= map_coordinates(vol,new_xyz, order=0)
				#print("here7")



		else: #si vec_dir perp sur axe_x
			##print("---> third ")
			dim=vol.shape[0]
			ax=np.arange(dim)
			coords=np.meshgrid(ax,ax,ax)
			mat=rotation_matrix(np.pi/2,(0,1,0))
				# stack the meshgrid to position vectors,
			xyz=np.vstack([coords[0].reshape(-1) ,
				coords[1].reshape(-1) ,
				coords[2].reshape(-1) ,
				np.ones((dim,dim,dim)).reshape(-1)]) # 1 for homogeneous coordinates


			#ramener les coordonnées de toute la stack dans le repère associé au point cible

			xyz[0]=xyz[0]-float(point_cible[1]) #pour l'affichage mayavi et meshgrid, x et y et z se situent   en [1],[0] et [2] car x,yz dans le code = y,x,z dans mayavi
			xyz[1]=xyz[1]-float(point_cible[0])
			xyz[2]=xyz[2]-float(point_cible[2])

			transformed_xyz=np.dot(mat, xyz)

			# extract coordinates, don't use transformed_xyz[3,:] that's the homogeneous coordinate, always 1

			x=transformed_xyz[0,:] + float(point_cible[1])
			y=transformed_xyz[1,:] +float(point_cible[0])
			z=transformed_xyz[2,:] +float(point_cible[2])


			x=x.reshape((dim,dim,dim))
			y=y.reshape((dim,dim,dim))
			z=z.reshape((dim,dim,dim))


			new_xyz=[y,x,z]

			# sample
			new_vol_colZ= map_coordinates(vol,new_xyz, order=0)
			#print("here8")
			#return new_vol_colZ


		#---------------------------------------rotation around y to make colinear to z
		if flag==1:
			new_vol=new_vol_perpX


			##print("==============> dans flag1")
			#point_cible=np.where(new_vol==400)
			#point_voisin=np.where(new_vol==355)
			if np.where(new_vol==400)[0].size!=0:
				point_cible=np.array([ np.where(new_vol==400)[0][0], np.where(new_vol==400)[1][0], np.where(new_vol==400)[2][0]    ])
			if np.where(new_vol==355)[0].size!=0:
				point_voisin=np.array([ np.where(new_vol==355)[0][0], np.where(new_vol==355)[1][0], np.where(new_vol==355)[2][0]    ])

			if point_cible[0].size==0 or point_cible[1].size==0 or point_cible[2].size==0:
				point_cible_orig=np.where(vol==400)
				dist=[]
				res_new_vol=np.where(new_vol>0)
				for i in range(len(res_new_vol[0])):
					tmp=np.array([res_new_vol[0][i],res_new_vol[1][i],res_new_vol[2][
						i]])
					dist.append(np.linalg.norm(tmp - point_cible_orig))

				ind=dist.index(min(dist))

				point_cible=np.array([res_new_vol[0][ind], res_new_vol[1][ind], res_new_vol[2][ind] ])

			if point_voisin[0].size==0 or point_voisin[1].size==0 or point_voisin[2].size==0:
				point_voisin_orig=np.where(vol==355)
				dist=[]
				res_new_vol=np.where(new_vol>0)
				for i in range(len(res_new_vol[0])):
					tmp=np.array([res_new_vol[0][i],res_new_vol[1][i],res_new_vol[2][
								i]])
					dist.append(np.linalg.norm(tmp - point_voisin_orig))

				ind=dist.index(min(dist))

				point_voisin=np.array([res_new_vol[0][ind], res_new_vol[1][ind], res_new_vol[2][ind] ])

			alpha=alpha*math.acos( (point_voisin[2]-point_cible[2])/(np.sqrt( (point_voisin[0]-point_cible[0])*(point_voisin[0]-point_cible[0]) + (point_voisin[1]-point_cible[1])*(point_voisin[1]-point_cible[1]) + (point_voisin[2]-point_cible[2])*(point_voisin[2]-point_cible[2])  )) )



			mat=rotation_matrix(alpha,(1,0,0))

			dim=new_vol.shape[0]
			ax=np.arange(dim)
			coords=np.meshgrid(ax,ax,ax)

			# stack the meshgrid to position vectors,
			xyz=np.vstack([coords[0].reshape(-1) ,
				coords[1].reshape(-1) ,
				coords[2].reshape(-1) ,
			np.ones((dim,dim,dim)).reshape(-1)]) # 1 for homogeneous coordinates


			#ramener les coordonnées de toute la stack dans le repère associé au point cible

			xyz[0]=xyz[0]-float(point_cible[1]) #pour l'affichage mayavi et meshgrid, x et y et z se situent   en [1],[0] et [2] car x,yz dans le code = y,x,z dans mayavi
			xyz[1]=xyz[1]-float(point_cible[0])
			xyz[2]=xyz[2]-float(point_cible[2])

			transformed_xyz=np.dot(mat, xyz)

			# extract coordinates, don't use transformed_xyz[3,:] that's the homogeneous coordinate, always 1

			x=transformed_xyz[0,:] + float(point_cible[1])
			y=transformed_xyz[1,:] +float(point_cible[0])
			z=transformed_xyz[2,:] +float(point_cible[2])


			x=x.reshape((dim,dim,dim))
			y=y.reshape((dim,dim,dim))
			z=z.reshape((dim,dim,dim))


			new_xyz=[y,x,z]

			# sample
			new_vol_colZ= map_coordinates(new_vol,new_xyz, order=0)
			#print("here9")
			#return new_vol_colZ

	if coupe_x==1:
		res_slice=vol[:,point_cible[1],:]
		#new_vol_colZ=vol
		#print("here10")
	elif coupe_y==1:
		res_slice=vol[point_cible[0],:,:]
		#new_vol_colZ=vol
		#print("here11")
	elif coupe_plan_xy==1:
		res_slice=vol[:,:,point_cible[2]]
		#new_vol_colZ=vol
		#print("here12")
	else:

		res_cible=np.where(new_vol_colZ==400)
		point_cible=np.array([res_cible[0][0], res_cible[1][0], res_cible[2][0]])

		if point_cible[0].size==0 or point_cible[1].size==0 or point_cible[2].size==0:
			point_cible_orig=np.where(vol==400)
			dist=[]
			res_new_vol=np.where(new_vol_colZ>0)
			for i in range(len(res_new_vol[0])):
				tmp=np.array([res_new_vol[0][i],res_new_vol[1][i],res_new_vol[2][
					i]])
				dist.append(np.linalg.norm(tmp - point_cible_orig))

			ind=dist.index(min(dist))

			point_cible=np.array([res_new_vol[0][ind], res_new_vol[1][ind], res_new_vol[2][ind] ])
			#print("here13")


		#res_voisin=np.where(new_vol_colZ==355)
		#point_voisin=np.array([res_voisin[0][0], res_voisin[1][0], res_voisin[2][0]])

		#res_slice=new_vol_colZ[:,:,point_voisin[2]]
		res_slice=new_vol_colZ[:,:,point_cible[2]]
		#print("here14")

	res_slice[res_slice>0]=1
	res_slice_norm = skimage.util.img_as_ubyte(res_slice)

	#----------------------------affichage slice3d


	slice3d=np.zeros((dim,dim,dim))

	ind=np.where(res_slice_norm>0)
	if coupe_x ==1 or coupe_y==1 or coupe_plan_xy==1:
		slice3d[ind[0][:],ind[1][:],point_voisin[2]]=vol[ind[0][:],ind[1][:],point_voisin[2]]
	else:
		slice3d[ind[0][:],ind[1][:],point_voisin[2]]=new_vol_colZ[ind[0][:],ind[1][:],point_voisin[2]]

	#affiche_ske(slice3d)
	#---------------------------------------------------
	if cv2.__version__[0] == '4':
		contours, hierarchy = cv2.findContours(res_slice_norm, cv2.RETR_TREE,cv2.CHAIN_APPROX_SIMPLE)
		im2 = res_slice_norm
	else:
		im2, contours, hierarchy = cv2.findContours(res_slice_norm, cv2.RETR_TREE,cv2.CHAIN_APPROX_SIMPLE)


	flag1=0
	index_contour=-1
	cross_section_area=-1
	for x in range(len(contours)):
		cv2.drawContours(im2, contours, x, 127, -1)
		if point_cible[0]<im2.shape[0] and point_cible[1]<im2.shape[1] :

			if im2[point_cible[0],point_cible[1]]==127:
				index_contour=x
				cross_section_area=len(contours[x])
				flag1=1
				break

		if flag1==1:
			break
		else:
			cv2.drawContours(im2, contours, x, 0, -1)


	im2[im2!=0]=0
	cv2.drawContours(im2, contours, index_contour, 255, -1)
	res=np.where(im2>0)
	area_section=len(res[0])


	if area_section==1:
		diamMin=diamMax=1
	else:
		(diamMin,diamMax)= diamMinMax(im2)

	return area_section, diamMin, diamMax, slice3d
	#return new_vol_colZ, area_section, diamMin, diamMax
