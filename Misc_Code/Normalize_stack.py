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