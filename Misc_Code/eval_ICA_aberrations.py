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

import SimpleITK as sitk
import numpy as np
from scipy.ndimage import *
import raster_geometry as rg
import os, sys
import scipy


filename = sys.argv[1]

""" True ICAs : """
#filename = "/Users/florent/ownCloud/NeuroVascu/ICAs/New_Dataset/loc_107_F5/AIC_17_0035/AIC_17_0035_0.4.seg.nrrd"   ### near sphere (R = 0.74)
#filename = "/Users/florent/ownCloud/NeuroVascu/ICAs/New_Dataset/loc_118_F7/AIC_07_0294/AIC_07_0294_0.4.seg.nrrd"   ### R = 0.57
#filename = "/Users/florent/ownCloud/NeuroVascu/ICAs/New_Dataset/loc_105_F11/AIC_05_0047/AIC_05_0047_0.4.seg.nrrd"  ### R = 0.59
#filename = "/Users/florent/ownCloud/NeuroVascu/ICAs/New_Dataset/loc_121_F9/AIC_19_0044/AIC_19_0044_0.4.seg.nrrd"   ### high aberrations - elongated (R = 0.37)
#filename = "/Users/florent/ownCloud/NeuroVascu/ICAs/New_Dataset/loc_7_F6/AIC_16_0003/AIC_16_0003_0.4.seg.nrrd"     ### near sphere (R = 0.77)
#filename = "/Users/florent/ownCloud/NeuroVascu/ICAs/New_Dataset/loc_5_F12/AIC_09_0015/AIC_09_0015_0.4.seg.nrrd"    ### near sphere (R = 0.80)
#filename = "/Users/florent/ownCloud/NeuroVascu/ICAs/New_Dataset/loc_11_F1/AIC_13_0135/AIC_13_0135_0.4.seg.nrrd"    ### very high aberrations (R = 0.28)
#filename = "/Users/florent/ownCloud/NeuroVascu/ICAs/New_Dataset/loc_112_F3/AIC_11_0031/AIC_11_0031_0.4.seg.nrrd"   ### high aberrations - elongated (R = 0.40)

""" Modeled ICAs : """
#filename = "/Users/florent/ownCloud/NeuroVascu/ICAs/_ICA_Model/Bif_6/1_Bif=6_Spl=2_R=3_Sed=1.0_AGr=0.5_ICA_Arr.nrrd"
#filename = "/Users/florent/ownCloud/NeuroVascu/TOF_Dataset_Spacing_0.4/_ICA_Model/107_Bif=8_Spl=2_R=4_Sed=2.0_AGr=0.75_ICA_Arr.nrrd"
#filename = "/Users/florent/ownCloud/NeuroVascu/TOF_Dataset_Spacing_0.4/_ICA_Model/40_Bif=6_Spl=2_R=4_Sed=2.0_AGr=1.0_ICA_Arr.nrrd"     ### R = 0.67 
#filename = "/Users/florent/ownCloud/NeuroVascu/TOF_Dataset_Spacing_0.4/_ICA_Model/40_Bif=6_Spl=2_R=4_Sed=2.0_AGr=0.75_ICA_Arr.nrrd"
#filename = "/Users/florent/ownCloud/NeuroVascu/TOF_Dataset_Spacing_0.4/_ICA_Model/40_Bif=6_Spl=2_R=4_Sed=4.0_AGr=0.75_ICA_Arr.nrrd"    ### relatively high aberrations (R = 0.53)
#filename = "/Users/florent/ownCloud/NeuroVascu/TOF_Dataset_Spacing_0.4/_ICA_Model/40_Bif=6_Spl=2_R=4_Sed=1.0_AGr=0.75_ICA_Arr.nrrd"    ### R = 0.68 
#filename = "/Users/florent/ownCloud/NeuroVascu/TOF_Dataset_Spacing_0.4/_ICA_Model/40_Bif=6_Spl=2_R=4_Sed=0.2_AGr=1.0_ICA_Arr.nrrd"     ### R = 0.80
#filename = "/Users/florent/ownCloud/NeuroVascu/TOF_Dataset_Spacing_0.4/_ICA_Model/40_Bif=6_Spl=2_R=4_Sed=8.0_AGr=1.0_ICA_Arr.nrrd"     ### R = 0.63
#filename = "/Users/florent/ownCloud/NeuroVascu/TOF_Dataset_Spacing_0.4/_ICA_Model/40_Bif=6_Spl=2_R=4_Sed=12.0_AGr=0.44_ICA_Arr.nrrd"   ### moderate aberrations (R = 0.51)


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

#sitk.WriteImage(sitk.GetImageFromArray(np.float32(Hollow_ICA)), "/Users/florent/Desktop/Hollow_ICA.nrrd")

"""
BinHollow_ICA = np.copy(Hollow_ICA)
BinHollow_ICA[BinHollow_ICA > 0] = 1

DistHollow = distance_transform_cdt(BinHollow_ICA)
sitk.WriteImage(sitk.GetImageFromArray(np.float32(DistHollow)), "/Users/florent/Desktop/DistHollow.nrrd")
"""

print("\nDistance from sphere : " +str(Hollow_ICA.sum()))
print("ICA volume : " + str(ICAVol) + ", Sph volume : " + str(SphVol) + ", Ratio : " + str(np.float32(SphVol/ICAVol)))

