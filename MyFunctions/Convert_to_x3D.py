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

from mpl_toolkits.mplot3d import Axes3D
import sys, os, glob, platform
import numpy as np
import cv2
import matplotlib.pyplot as plt
import SimpleITK as sitk
import argparse
from mayavi import mlab

 
def draw3d_mayavi(array, path):
	mlab.contour3d(array.astype(np.int32)) # a window would pop up
	mlab.savefig(path)
	mlab.clf() # clear the scene to generate a new one
 
#########################################################################################################

#
# construct the argument parser and parse the arguments
ap = argparse.ArgumentParser()
#ap.add_argument("-seg", "--seg", type=str, default='/Users/florent/Nextcloud/NeuroVascu/TOFs/Manual_Segm/nrrd_mask/training_BET/55.nrrd',
ap.add_argument("-seg", "--seg", type=str, default='/Users/florent/Desktop/55.nrrd',
	help="Segmented input 3D image (stack)")
args = vars(ap.parse_args())


seg= args["seg"]
print('seg=\'%s\'' %(seg))

FileDir = os.path.dirname(os.path.abspath(seg)) + '/'
FileNameStack = (os.path.basename(seg))
FileName = os.path.splitext(os.path.basename(FileNameStack))[0]


fileext = os.path.splitext(seg)[1]
if fileext == '.nii' or fileext == '.mha' or fileext == '.nrrd':
	sitkimgSegm = sitk.ReadImage(seg)
	stackSegm = sitk.GetArrayFromImage(sitkimgSegm)
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


outname = FileDir + FileName + '.x3d'

print("\nSaving as : ")
print(outname)

draw3d_mayavi(stackSegm, outname)

