#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Copyright - <---->
contributor(s) : <---->, <----> (February 2023)

<----@----.-->
<----@----.-->

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


# https://docs.enthought.com/mayavi/mayavi/auto/example_mri.html#example-mri

import tifffile
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
import random
#from tvtk.api import tvtk



DoGaussianBlur = 0


volname = sys.argv[1]
FileName = os.path.splitext(os.path.basename(volname))[0]
dirname = os.path.dirname(os.path.abspath(volname)) + '/'

#print(os.path.splitext(os.path.basename(volname))[1])
if os.path.splitext(os.path.basename(volname))[1] == '.nrrd':
    orig = sitk.ReadImage(volname)
    data = sitk.GetArrayFromImage(orig)
    #v = nrrd.read(volname)
    #data = v[0]
elif os.path.splitext(os.path.basename(volname))[1] == '.nii':
    v = nib.load(volname)
    data = v.get_fdata()
elif os.path.splitext(os.path.basename(volname))[1] == '.tif' or os.path.splitext(os.path.basename(volname))[1] == '.tiff':
    data = tifffile.imread(volname)
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


p = FileName.find('_')
imgNumber = FileName[0:p]

Files = (glob.glob(dirname + imgNumber + '__*BinModel*'))
NbFiles = len(Files)

RandFileNb = random.randint(0, NbFiles-1)
print('Displaying: ' + Files[RandFileNb])

data2 = sitk.GetArrayFromImage(sitk.ReadImage(Files[RandFileNb]))
data[data>0] = 255
data2[data2>0] = 255


buffer = np.zeros((data.shape[1], 12, data.shape[2]))

dataStack1 = np.hstack((data, buffer))
dataStack = np.hstack((dataStack1, data2))
data = dataStack


### Avoid display problems due to the presence of several colors in the stack,
### We threshold so that it's fully binary, everything is set to 255 :
#data[data>0] = 255


""" 
data[data>0] = 1
data2 = ndi.binary_dilation(data).astype(data.dtype)
data2[data2>0] = 1
data = data2 - data
""" 

data = np.uint16(data.T *20.0)

#FileDir = os.path.dirname(os.path.abspath(volname)) + '/'
#FileName = os.path.splitext(os.path.basename(volname))[0]


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

if int(imgNumber) < 10:
	imgNumber = imgNumber + '  '
elif int(imgNumber) >= 10 and int(imgNumber) < 100:
	imgNumber = imgNumber + ' '
mlab.text(0,0,imgNumber, width=0.2, color=(0,0,0))

FileName = FileName + '.png'
mlab.savefig(filename=FileName)
mlab.show()
