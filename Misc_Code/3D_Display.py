#!/usr/bin/env python
# -*- coding: utf-8 -*-


# https://docs.enthought.com/mayavi/mayavi/auto/example_mri.html#example-mri

#import tifffile
#import tarfile
import numpy as np
from mayavi import mlab
import sys
import nrrd
import os, glob
#import nibabel as nib
import SimpleITK as sitk
import cv2
import scipy.ndimage as ndi
#from tvtk.api import tvtk

volname = sys.argv[1]
basename = os.path.splitext(os.path.basename(volname))[0]
#volname = '/Users/---/Nextcloud/NeuroVascu/TOFs/Manual_Segm/nrrd_mask/training_BET/11.nrrd'
#print (volname)
#print(os.path.splitext(os.path.basename(volname))[1])
if os.path.splitext(os.path.basename(volname))[1] == '.nrrd':
    orig = sitk.ReadImage(volname)
    data = sitk.GetArrayFromImage(orig)
    #v = nrrd.read(volname)
    #data = v[0]
elif os.path.splitext(os.path.basename(volname))[1] == '.nii':
    v = nib.load(volname)
    data = v.get_fdata()
#elif os.path.splitext(os.path.basename(volname))[1] == '.tif' or os.path.splitext(os.path.basename(volname))[1] == '.tiff':
#    data = tifffile.imread(volname)
else:
    files = sorted(glob.glob(volname + '/*'))
    nbfiles = len(files)
    if os.path.splitext(os.path.basename(files[0]))[1] == '.png':
        arr = cv2.imread(files[0],0)
        h,w = arr.shape
        stack = np.zeros((nbfiles,h,w))
        for i in range(len(files)):
            arr = cv2.imread(files[i],0)
            stack[i,:,:] = arr
        data = np.uint8(stack*255.0/stack.max())
    else:
        img0 = sitk.ReadImage(files[0])
        w = img0.GetWidth()
        h = img0.GetHeight()

        stack = np.zeros((nbfiles,w,h))
        for i in range(len(files)):
            img = sitk.ReadImage(files[i])
            arr = sitk.GetArrayFromImage(img)
            if len(arr.shape) == 3:
                arr=arr[:,:,0]
                stack[i,:,:] = arr

        data = np.uint8(stack*255.0/stack.max())


if len(data.shape) > 3:
    data = data[:,:,:,0]

z,y,x = data.shape

### Avoid display problems due to the presence of several colors in the stack,
### We threshold so that it's fully binary, everything is set to 255 :
#data[data>0] = 255

"""
#data = tifffile.imread("/Users/---/Desktop/mrbrain-8bit.tif")
data = tifffile.imread("/Users/---/Desktop/AIC_08_0247_012_TOF_3D_multi-slab_TH_AIC_z68_x196_y158.tif")
"""

""" 
data[data>0] = 1
data2 = ndi.binary_dilation(data).astype(data.dtype)
data2[data2>0] = 1
data = data2 - data
#sitk.WriteImage(sitk.GetImageFromArray(np.uint16(data)), "/Users/---/Desktop/data.nrrd")
""" 

#data = np.uint16(data.T *20.0)
data = np.uint16(data *20.0)

FileDir = os.path.dirname(os.path.abspath(volname)) + '/'
FileName = os.path.splitext(os.path.basename(volname))[0]


# Display the data ############################################################

print(FileName)
mlab.figure(FileName, bgcolor=(0.63, 0.63, 0.63), size=(600, 600))
src = mlab.pipeline.scalar_field(data)
# Our data is not equally spaced in all directions:
#src.spacing = [1, 1, 1.5]
src.update_image_data = True


# Extract some inner structures: the ventricles and the inter-hemisphere
# fibers. We define a volume of interest (VOI) that restricts the
# iso-surfaces to the inner of the brain. We do this with the ExtractGrid
# filter.
DoGaussianBlur = 0

if DoGaussianBlur == 1:
    blur = mlab.pipeline.user_defined(src, filter='ImageGaussianSmooth')
    voi = mlab.pipeline.extract_grid(blur)
else:
    voi = mlab.pipeline.extract_grid(src)

#voi.trait_set(x_min=1, x_max=x-1, y_min=1, y_max=y-1, z_min=1, z_max=z-1)

#voi = mlab.pipeline.extract_grid(src)

#mlab.pipeline.iso_surface(voi, contours=[1610, 2480], colormap='autumn')
mlab.pipeline.iso_surface(voi, colormap='hot')


# Extract two views of the outside surface. We need to define VOIs in
# order to leave out a cut in the head.
"""
voi2 = mlab.pipeline.extract_grid(src)
#voi2.trait_set(y_min=1)
#outer = mlab.pipeline.iso_surface(voi2, contours=[1776, ], color=(0.8, 0.4, 0.3))
outer = mlab.pipeline.iso_surface(voi2, color=(0.8, 0.4, 0.3))
"""

""" 
voi3 = mlab.pipeline.extract_grid(blur)
voi3.trait_set(y_max=2, z_max=5)
outer3 = mlab.pipeline.iso_surface(voi3, color=(0.8, 0.7, 0.6))
""" 

#mlab.view(-125, 54, 326, (145.5, 138, 66.5))
#mlab.roll(-175)
#axes = mlab.axes(color=(0, 0, 0), nb_labels=4)

p = basename.find('_')
if p != -1 :
	imgNumber = basename[0:p]
	if int(imgNumber) < 10:
		imgNumber = imgNumber + '  '
	elif int(imgNumber) >= 10 and int(imgNumber) < 100:
		imgNumber = imgNumber + ' '
	mlab.text(0,0,imgNumber, width=0.2, color=(0,0,0))

	basename = basename + '.png'
	mlab.savefig(filename=basename)

mlab.show()
