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

import os
import sys
import json
import sknw
import numpy as np
import SimpleITK as sitk
from skimage.morphology import skeletonize_3d


###################################################################################################@

def GetGraph(stack):

	ske = skeletonize_3d(np.uint8(stack)).astype(np.uint8)
	graph = sknw.build_sknw(ske)

	stack[stack>0]=255

	#-------------------------------------------------------------------------------------------
	for i in graph.nodes():

		if len(list(graph.neighbors(i)))==0: #supression des petits voxels associes au bruit
			pts=graph.nodes[i]['pts']
			for k in range(len(pts)):
				ske[int(pts[k][0]),int(pts[k][1]),int(pts[k][2]) ]=0

		elif len(list(graph.neighbors(i)))==1	  :	#supression des suites de voxels associes au bruit
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

				if (len(graph[i][neighbors[j]]['pts']) <=5 ): #suppresion dans le skelette des petites arteres
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

	graph = sknw.build_sknw(ske)


	return(graph)

###################################################################################################@

def resample_image2(itk_image, is_label=False):
	original_spacing = itk_image.GetSpacing()
	out_spacing=[original_spacing[0], original_spacing[0], original_spacing[0]]
	original_size	= itk_image.GetSize()
	out_size = [
		int(np.round(original_size[0] * (original_spacing[0] / out_spacing[0]))),
		int(np.round(original_size[1] * (original_spacing[1] / out_spacing[1]))),
		int(np.round(original_size[2] * (original_spacing[2] / out_spacing[2])))
	]
	resample = sitk.ResampleImageFilter()
	resample.SetOutputSpacing(out_spacing)
	resample.SetSize(out_size)
	resample.SetOutputDirection(itk_image.GetDirection())
	resample.SetOutputOrigin(itk_image.GetOrigin())
	resample.SetTransform(sitk.Transform())
	resample.SetDefaultPixelValue(itk_image.GetPixelIDValue())
	if is_label:
		resample.SetInterpolator(sitk.sitkNearestNeighbor)
	else:
		resample.SetInterpolator(sitk.sitkLinear)
	return resample.Execute(itk_image)


###################################################################################################@
inputimg = sys.argv[1]
if len(sys.argv) == 2:
	FileDir = os.path.dirname(os.path.abspath(inputimg)) + '/'
	inputFid = FileDir + "F.mrk.json"
elif len(sys.argv) == 3:
	inputFid = sys.argv[2]
else:
	print('Wrong number of arguments')
	sys.exit(0)

#inputimg = '/Volumes/LaCie/NeuroVascu/ICAs/loc_5_F12/AIC_01_0091/AIC_01_0091_0.4.seg.nrrd'
#inputFid = '/Volumes/LaCie/NeuroVascu/ICAs/loc_5_F12/AIC_01_0091/F.mrk.json'
#inputimg = '/Volumes/LaCie/NeuroVascu/ICAs/loc_118_F7/AIC_09_0017/AIC_09_0017_0.4.seg.nrrd'
#inputFid = '/Volumes/LaCie/NeuroVascu/ICAs/loc_118_F7/AIC_09_0017/F.mrk.json'
FileDir = os.path.dirname(os.path.abspath(inputimg)) + '/'
FileName = (os.path.basename(inputimg))
psl = [i for i, ch in enumerate(inputimg) if ch == '/']
LastDir = inputimg[psl[len(psl)-2]+1:psl[len(psl)-1]]

sitkimg = sitk.ReadImage(inputimg, sitk.sitkUInt16)
#sitkimg = resample_image2(sitkimg, is_label=True)
stack = sitk.GetArrayFromImage(sitkimg)

graph = GetGraph(stack.astype(np.uint8))

# Opening JSON file
f = open(inputFid)

# returns JSON object as a dictionary
data = json.load(f)
# Closing file
f.close()

Fiducials = data['markups'][0]['controlPoints']

print("")
print("export path="+FileDir)
print("export pathSeg="+FileDir)
print("")

# Iterating through the json list
for idx in range(len(Fiducials)):
	fid = Fiducials[idx]['id']
	label = Fiducials[idx]['label']
	pos = Fiducials[idx]['position']
	
	#print(fid)
	#print(label)
	#print(pos)

	Xf = round(pos[0])
	Yf = round(pos[1])
	Zf = round(pos[2])
	#print((Xf, Yf, Zf))

	Dist = []
	for BifNum in range(len(graph)):
		bifcenter = graph.nodes[BifNum]['o']
		bifcenter = bifcenter[::-1].astype(int)
		#print('bifurcation center (x,y,z) : ' + str(bifcenter))
		Xc = bifcenter[0]
		Yc = bifcenter[1]
		Zc = bifcenter[2]
		
		Dist.append(np.sqrt((Xc-Xf)**2 + (Yc-Yf)**2 + (Zc-Zf)**2))
	
	#MinDist = [i for i,val in enumerate(Dist) if val==min(Dist)]
	Dist = np.asarray(Dist)
	FidPos = np.where(Dist == Dist.min())[0]

	#print(pos[::-1])
	#print(graph.nodes[MinDist[0]]['o'])

	""" """
	#print("min = " +str(Dist.min()) + "\t pos : "  + str(MinDist[0]) )
	if Dist.min() < 12:
		#print("python model_bifurcation_fid.py -i ${path}" + FileName +  " -seg ${pathSeg}" + FileName + "  -str ${strSpl} -sigst ${SigSt} -bn " + str(FidPos[0]) + " -fid " + str(fid) + "  # dist=" +str(round(Dist.min())))
		print("python model_bifurcation_fid.py -i ${path}" + FileName[:-8]+'nrrd' +  " -seg ${pathSeg}" + FileName + " -str ${strSpl} -sigst ${SigSt} -bn " + str(FidPos[0]) + " -fid " + str(fid) + " -cs 32")
	""" """
