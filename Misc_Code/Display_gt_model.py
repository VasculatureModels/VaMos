#!/usr/bin/env python
# -*- coding: utf-8 -*-


import os, glob, sys
import SimpleITK as sitk
import numpy as np


imname = sys.argv[1]
#imname = '/Users/---/Nextcloud/NeuroVascu/TOFs/CNN_Dataset/_Model_v6b/_Fid_5/0__ArtAmpl=66.93_mu=36.58_Sigma=5.3_Bif=77_Spl=3_Fid=5_ED_NoiseMod_.nrrd'
#imname = '/Users/---/Nextcloud/NeuroVascu/TOFs/CNN_Dataset/_Model_v6b/_Fid_11/124__ArtAmpl=374.45_mu=193.46_Sigma=30.1_Bif=148_Spl=9_Fid=11_ED_NoiseMod_.nrrd'


FileDir = os.path.dirname(os.path.abspath(imname)) + '/'
FileName = (os.path.basename(imname))

idx = FileName.find('_')
imidx = FileName[0:idx]

fileOrig = glob.glob(FileDir + imidx + "*Orig*")


model = sitk.GetArrayFromImage(sitk.ReadImage(imname))#, sitk.sitkUInt16))
orig = sitk.GetArrayFromImage(sitk.ReadImage(fileOrig))#, sitk.sitkUInt16))

orig = orig[0,:,:,:]

(z,y,x) = orig.shape

maxi = max(model.max(), orig.max())
mini = max(model.min(), orig.min())


buffer = np.zeros((z,3,x), dtype=np.uint16)
buffer[:,0,:] = 0
buffer[:,1,:] = maxi
buffer[:,2,:] = 0

tmp = np.hstack((orig, buffer))
Stack = np.hstack((tmp, model))
zs,ys,xs = Stack.shape

rot_stack = np.zeros([zs, xs, ys], dtype=np.float32)
zr,yr,xr = rot_stack.shape

for i in range(z):
	rot_stack[:,i,:] = Stack[:,:,i]

sitk.WriteImage(sitk.GetImageFromArray(np.uint16(rot_stack)), "/tmp/Stack.nrrd")

os.system('/Applications/Fiji.app/Contents/MacOS/ImageJ-macosx /tmp/Stack.nrrd')
