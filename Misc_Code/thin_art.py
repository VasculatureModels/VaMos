import os, sys
import numpy as np
import SimpleITK as sitk

labelsN = sys.argv[1]

BaseName = (os.path.basename(labelsN))
FileDir = os.path.dirname(os.path.abspath(labelsN)) + '/'
p = BaseName.find('_')

segmN = FileDir + BaseName[0:p] + ".seg.nii"

labels = sitk.ReadImage(labelsN, sitk.sitkUInt8)
segm = sitk.ReadImage(segmN, sitk.sitkUInt8)

labelsA = sitk.GetArrayFromImage(labels)
segmA = sitk.GetArrayFromImage(segm)

labelsA[segmA==0] = 0

sitk.WriteImage(sitk.GetImageFromArray(labelsA), labelsN)
