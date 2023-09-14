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

import SimpleITK as sitk
import numpy as np
from scipy.ndimage import *
import raster_geometry as rg
import os, sys
import scipy


filename = sys.argv[1]


FileDir = os.path.dirname(os.path.abspath(filename)) + '/'
#FileNameStack = (os.path.basename(filename))
#FileName = os.path.splitext(os.path.basename(FileNameStack))[0]


sitkLabels =sitk.ReadImage(filename, sitk.sitkUInt16)
Labels = sitk.GetArrayFromImage(sitkLabels)

ICA = np.copy(Labels)

if Labels.max() == 2:	# True ICA ?
	ICA[ICA < 2] = 0
	ICA[ICA == 2] = 1
else:					# Modelled ICA ?
	ICA[ICA > 0] = 1

z,y,x = ICA.shape
ICAVol = ICA.sum()

sitk.WriteImage(sitk.GetImageFromArray(np.uint16(ICA)), FileDir + "_ICA.seg.nrrd")
print("saving : "  + FileDir + "_ICA.seg.nrrd")


#Dist = distance_transform_edt(ICA, sampling=None, return_distances=True, return_indices=False, distances=None, indices=None)
#Dist = distance_transform_cdt(ICA)
Dist = distance_transform_bf(ICA)

#sitk.WriteImage(sitk.GetImageFromArray(np.float32(Dist)), FileDir + "_Dist.nrrd")

[zm,ym,xm] = np.where(Dist == Dist.max())

# Find Center of Mass : 
A=[zm,ym,xm]
Arr = np.array(A).T
CM = np.average(Arr, axis=0)
zidx = int(CM[0])
yidx = int(CM[1])
xidx = int(CM[2])

Dist[zidx, yidx, xidx]


#Sph = rg.sphere((int(z[0]), int(y[0]), int(x[0])), (int(3))).astype(np.int_)
Sph = rg.sphere((Dist.shape), (int(Dist.max()+1)), (zidx/z, yidx/y, xidx/x)).astype(np.int_)
SphVol = Sph.sum()

sitk.WriteImage(sitk.GetImageFromArray(np.uint8(Sph)), FileDir + "_Sph.seg.nrrd")
print("saving : " + FileDir + "_Sph.seg.nrrd")

#ICA[Sph == 1] = 2
#sitk.WriteImage(sitk.GetImageFromArray(np.uint8(ICA)), FileDir + "_ICA+Sph.seg.nrrd")
#print("saving : " + FileDir + "_ICA+Sph.seg.nrrd")

Hollow_ICA = np.copy(Dist)
Sph = binary_dilation(Sph).astype(Sph.dtype)
Hollow_ICA[Sph > 0] = 0


"""
BinHollow_ICA = np.copy(Hollow_ICA)
BinHollow_ICA[BinHollow_ICA > 0] = 1

DistHollow = distance_transform_cdt(BinHollow_ICA)
"""

print("\nDistance from sphere : " +str(Hollow_ICA.sum()))
print("ICA volume : " + str(ICAVol) + ", Sph volume : " + str(SphVol) + ", Ratio : " + str(np.float32(SphVol/ICAVol)))

