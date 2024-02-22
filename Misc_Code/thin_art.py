import os, sys
import numpy as np
import SimpleITK as sitk

labelsN = sys.argv[1]
#labelsN = "/home/florent/Images/MRA-Dataset/59_labels.seg.nrrd"
#labelsN2 = "/home/florent/Bureau/Arteries_Labels/59_labels.seg.nrrd"

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
