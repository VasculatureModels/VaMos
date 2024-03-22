#!/usr/bin/env python
# -*- coding: utf-8 -*-


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

