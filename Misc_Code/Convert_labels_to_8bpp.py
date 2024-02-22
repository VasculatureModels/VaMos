import SimpleITK as sitk
import numpy as np
import os, glob


imnames = sorted(glob.glob("/home/florent/Images/MRA-Dataset/*labels*"))

for imname in imnames :
    sitk_labels = sitk.ReadImage(imname)
    labels = sitk.GetArrayFromImage(sitk_labels)
    newlabels = np.zeros(labels.shape, dtype=np.uint8)

    vals = np.unique(labels)

    inc = 1
    for i in vals:
        if i > 0:
            newlabels[labels == i] = inc
            inc += 1

    sitk.WriteImage(sitk.GetImageFromArray(newlabels), imname)
