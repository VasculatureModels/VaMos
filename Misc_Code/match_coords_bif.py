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

import sys, os
import argparse
import SimpleITK as sitk
from copy import deepcopy

sys.path.insert(1, '../')

###   Local imports :   ###
from MyFunctions.misc_fun import *
from MyFunctions.GetGraph import *
#from MyFunctions.Noise_Model import *
#from MyFunctions.Geometric_Model import *
#from MyFunctions.GetBifurcDiameters import *


def Distance_3D_0(pA, pB):
	distance = math.sqrt( (pA[0]-pB[0])**2 + (pA[1]-pB[1])**2 + (pA[2]-pB[2])**2 )
	return(distance)


#########################################################################################################

#
# construct the argument parser and parse the arguments
ap = argparse.ArgumentParser()
#ap.add_argument("-i", "--image", type=str, default='/Users/florent/Nextcloud/NeuroVascu/TOFs/Manual_Segm/nrrd_mask/training_BET/17.nrrd',
ap.add_argument("-i", "--image", type=str, default='/Volumes/LaCie/NeuroVascu/New_dataset_Spacing_0.4/tofs/100.nii',
	help="Input 3D image (stack) (.nrrd, .nii or .mha)")
ap.add_argument("-seg", "--seg", type=str, default='/Volumes/LaCie/NeuroVascu/New_dataset_Spacing_0.4/tofs/100.seg.nii',
	help="Segmented input 3D image (stack)")
ap.add_argument("-cs", "--CropSize", type=int, default=32,
	help="Size of the 3D crops to grab around the point of interest")
ap.add_argument("-fid", "--FiducialNb", type=str, default='1',
	help="Fiducial Number, i.e. anatomical label of the bifurcation (in [1,15])")
ap.add_argument("-d3D", "--Disp3D", type=int, default=0,
	help="Display the output 3D model (1 or 0)")
ap.add_argument("-x", "--XCoord", type=int, default=239,
	help="X Coordinate")
ap.add_argument("-y", "--YCoord", type=int, default=167,
	help="Y Coordinate")
ap.add_argument("-z", "--ZCoord", type=int, default=163,
	help="Z Coordinate")

args = vars(ap.parse_args())



inputimage= args["image"]
#print('\ninputimage=\'%s\'' %(inputimage))
seg= args["seg"]
#print('seg=\'%s\'' %(seg))
CropSize = int(args["CropSize"])
#print('CropSize=%d' %(CropSize))
FidNb = args["FiducialNb"]
#print('FidNb=\'%s\'' %(FidNb))
d3D = int(args["Disp3D"])
#print('d3D=%d' %(d3D))
XCoord = int(args["XCoord"])
#print('XCoord=%d' %(XCoord))
YCoord = int(args["YCoord"])
#print('YCoord=%d' %(YCoord))
ZCoord = int(args["ZCoord"])
#print('ZCoord=%d\n' %(ZCoord))

if FidNb not in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15']:
	print('Not considering this bifurcation\n')
	sys.exit()


FileDir = os.path.dirname(os.path.abspath(inputimage)) + '/'
ImName = (os.path.basename(inputimage))

FileDirSeg = os.path.dirname(os.path.abspath(seg)) + '/'
SegName = (os.path.basename(seg))


fileext = os.path.splitext(seg)[1]
if fileext == '.nii' or fileext == '.mha' or fileext == '.nrrd':
	sitkimg = sitk.ReadImage(seg, sitk.sitkUInt16)
	#resampling
	sitkimg = resample_image2(sitkimg, is_label=True) ## <-- if segmented image : then is_label = True !
	#spacing = sitkimg.GetSpacing()
	stackSegm = sitk.GetArrayFromImage(sitkimg)

else:		   # Probably a DICOM folder...
	print('Give a 3D stack as an input (.nrrd, .nii or .mha)\n')
	sys.exit(0)

z,y,x = stackSegm.shape

xyz = np.asarray([XCoord,YCoord,ZCoord])

graph = GetGraph(stackSegm.astype(np.uint8))


listDist = np.zeros(len(graph))

for BifNum in range(len(graph)):
	bifcenter = graph.nodes[BifNum]['o']
	bifcenter = bifcenter[::-1].astype(int)

	listDist[BifNum] = Distance_3D_0(xyz, bifcenter)
	
#print('Distance to closest bif : ' + str(listDist.min()))

Nbif = np.where(listDist==listDist.min())[0][0]
bifcenter2 = graph.nodes[Nbif]['o']
bifcenter2 = bifcenter2[::-1].astype(int)
#print('\tCoords (x,y,z) : ' + str(xyz) + '\t---\tbif (x,y,z) : ' + str(bifcenter2) + '\t---\tDist = ' +str(listDist.min()))

if listDist.min() > 7:
	print('#python model_bifurcation_fid.py -i ${path}' + ImName + ' -seg ${pathSeg}' +SegName + ' -str ${strSpl} -sigst ${SigSt} -bn ' +str(Nbif) + ' -fid ' +str(FidNb) + ' -cs 32  ### <-- \tDist = ' + str(listDist.min()) )
else:
	print('python model_bifurcation_fid.py -i ${path}' + ImName + ' -seg ${pathSeg}' +SegName + ' -str ${strSpl} -sigst ${SigSt} -bn ' +str(Nbif) + ' -fid ' +str(FidNb) + ' -cs 32')
