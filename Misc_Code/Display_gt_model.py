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
import os, glob, sys
import SimpleITK as sitk
import numpy as np


imname = sys.argv[1]
#imname = '/Users/florent/Nextcloud/NeuroVascu/TOFs/CNN_Dataset/_Model_v6b/_Fid_5/0__ArtAmpl=66.93_mu=36.58_Sigma=5.3_Bif=77_Spl=3_Fid=5_ED_NoiseMod_.nrrd'
#imname = '/Users/florent/Nextcloud/NeuroVascu/TOFs/CNN_Dataset/_Model_v6b/_Fid_11/124__ArtAmpl=374.45_mu=193.46_Sigma=30.1_Bif=148_Spl=9_Fid=11_ED_NoiseMod_.nrrd'


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
