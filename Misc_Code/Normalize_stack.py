#!/usr/bin/env python
# -*- coding: utf-8 -*-


import os, sys, glob
import argparse
import numpy as np
import SimpleITK as sitk

sys.path.insert(1, '../')
from Misc_code.misc_fun import *

# construct the argument parser and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-i", "--image", type=str, default='/Volumes/LaCie/ITKTubeTK/Normal002-MRA.mha',
	help="Input 3D image (stack) (.nrrd, .nii or .mha)")

args = vars(ap.parse_args())



inputpath= args["image"]
print('\ninputpath=\'%s\'' %(inputpath))


FileDir = os.path.dirname(os.path.abspath(inputpath)) + '/'
FileNameStack = (os.path.basename(inputpath))
FileName = os.path.splitext(os.path.basename(FileNameStack))[0]


fileext = os.path.splitext(inputpath)[1]
if fileext == '.nii' or fileext == '.mha' or fileext == '.nrrd':
	sitkimg = sitk.ReadImage(inputpath, sitk.sitkUInt16)
	#resampling
	sitkimg = resample_image2(sitkimg, is_label=False)
	spacing = sitkimg.GetSpacing()
	stackGray = sitk.GetArrayFromImage(sitkimg)

else:		   # Probably a DICOM folder...
	print('Give a 3D stack as an input (.nrrd, .nii or .mha)\n')
	sys.exit(0)

print(spacing)


stackGray = stackGray.astype(np.float32)

NormStack = ((stackGray - stackGray.min()) / ((stackGray - stackGray.min())).max()) * 255.

SaveName = FileDir + FileName + '_N' + fileext
sitk.WriteImage(sitk.GetImageFromArray(np.uint8(NormStack)), SaveName)
