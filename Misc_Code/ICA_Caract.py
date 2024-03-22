#!/usr/bin/env python
# -*- coding: utf-8 -*-



import SimpleITK as sitk
import numpy as np
import os, sys
from scipy import ndimage
import pandas as pd
from scipy.ndimage import zoom


filename = sys.argv[1]

sitkimg =sitk.ReadImage(filename, sitk.sitkUInt16)
xs,ys,zs = sitkimg.GetSpacing()

array1 = sitk.GetArrayFromImage(sitkimg)
array = zoom(array1, (zs/xs, 1, 1))

dirname = os.path.dirname(filename) + "/"

Vascu = np.copy(array)
Vascu[Vascu > 1] = 0
AIC = np.copy(array)
AIC[AIC < 2] = 0
AIC[AIC != 0] = 1

Volume = AIC.sum()



### Alternative :  ###
Dilated = ndimage.binary_dilation(AIC).astype(AIC.dtype)


Vascu[Dilated > 0 ] = 0
SurfaceArr = Dilated - AIC

FolderExist = os.path.exists(dirname+"/Resultats/")
if not FolderExist:
    os.makedirs(dirname+"/Resultats/")

#slicer.util.saveNode(lmVN, dirname+"/Resultats/" + 'TOF.nrrd')
sitk.WriteImage(sitk.GetImageFromArray(SurfaceArr), dirname+"/Resultats/" + "Surface.nrrd")
sitk.WriteImage(sitk.GetImageFromArray(AIC), dirname+"/Resultats/" + "AIC.nrrd")
sitk.WriteImage(sitk.GetImageFromArray(Dilated), dirname+"/Resultats/" + "AIC_D.nrrd")
sitk.WriteImage(sitk.GetImageFromArray(Vascu), dirname+"/Resultats/" + "Vascu.nrrd")

Dilated2 = ndimage.binary_dilation(Dilated).astype(Dilated.dtype)
Collet = Dilated2 + Vascu

#Collet = Dilated + Vascu
Collet[Collet!=2] = 0
Collet[Collet==2] = 1

Surface = SurfaceArr.sum()

sitk.WriteImage(sitk.GetImageFromArray(Collet), dirname+"/Resultats/" + "Collet.nrrd")

Sphericity = (((np.pi**(1/3)*(6*Volume)**(2/3)))/(Surface))


sitkAICimg = sitk.GetImageFromArray(AIC)
dist_img = sitk.SignedMaurerDistanceMap(sitkAICimg != 0, insideIsPositive=False, squaredDistance=False, useImageSpacing=False)

radius = 0
# Seeds have a distance of "radius" or more to the object boundary, they are uniquely labelled.
seeds = sitk.ConnectedComponent(dist_img < radius)

#BinMask = sitk.BinaryThreshold(seeds, lowerThreshold=0, upperThreshold=1, insideValue=0, outsideValue=255)

shape_stats = sitk.LabelShapeStatisticsImageFilter()
shape_stats.ComputeOrientedBoundingBoxOn()
shape_stats.Execute(seeds)

intensity_stats = sitk.LabelIntensityStatisticsImageFilter()
intensity_stats.Execute(seeds,sitkAICimg)


stats_list = [ (shape_stats.GetPhysicalSize(i),
               shape_stats.GetPrincipalAxes(i)[:3],
               shape_stats.GetPrincipalAxes(i)[3:6],
               shape_stats.GetPrincipalAxes(i)[6:9],
               shape_stats.GetPrincipalMoments(i),
               shape_stats.GetCentroid(i),
               shape_stats.GetElongation(i),
               shape_stats.GetFlatness(i),
               shape_stats.GetOrientedBoundingBoxSize(i)[0],
               shape_stats.GetOrientedBoundingBoxSize(i)[1],
               shape_stats.GetOrientedBoundingBoxSize(i)[2],
               intensity_stats.GetMean(i),
               intensity_stats.GetStandardDeviation(i),
               intensity_stats.GetSkewness(i)) for i in shape_stats.GetLabels()]

cols=["Volume (nm^3)",
      "PrincipalAxis #1",
      "PrincipalAxis #2",
      "PrincipalAxis #3",
      "PrincipalMoments",
      "Centroid",
      "Elongation",
      "Flatness",
      "Oriented Bounding Box Size 1 (nm)",
      "Oriented Bounding Box Size 2 (nm)",
      "Oriented Bounding Box Size 3 (nm)",
      "Intensity Mean",
      "Intensity Standard Deviation",
      "Intensity Skewness"]

# Create the pandas data frame and display descriptive statistics.
stats = pd.DataFrame(data=stats_list, index=shape_stats.GetLabels(), columns=cols)
stats.describe()

#stats.to_excel("/Users/---/Desktop/AIC.xlsx")

"""
dfVol = stats.iloc[0]['Volume (nm^3)']
dfElongation = stats.iloc[0]['Elongation']
dfFlatness = stats.iloc[0]['Flatness']
dfBoxSize1 = stats.iloc[0]['Oriented Bounding Box Size 1 (nm)']
dfBoxSize2 = stats.iloc[0]['Oriented Bounding Box Size 2 (nm)']
dfBoxSize3 = stats.iloc[0]['Oriented Bounding Box Size 3 (nm)']
"""

#print("Volume AIC : " + str(Volume) + " voxels")
#print("Surface collet : " + str(Collet.sum()) + " voxels")
#print("Surface AIC : " + str(Surface) + " voxels")
#print("Sphericity : " + str(Sphericity) + "\n")

outputdata = []
outputdata.append(["Volume AIC : ", Volume * xs*xs*xs, "mm3"])
outputdata.append(["Surface du collet : ", Collet.sum()*xs*xs, "mm2"])
outputdata.append(["Surface AIC : ", Surface*xs*xs, "mm2"])
outputdata.append(["Sphericite : ", Sphericity])
#outputdata.append(["Vol (bis) : ", dfVol*xs*xs*xs, "mm3"])
"""
outputdata.append(["Elongation : ", dfElongation])
outputdata.append(["Flatness : ", dfFlatness])
outputdata.append(["Box Size (1) : ", dfBoxSize1*xs, "mm"])
outputdata.append(["Box Size (2) : ", dfBoxSize2*xs, "mm"])
outputdata.append(["Box Size (3) : ", dfBoxSize3*xs, "mm"])
"""
with open(dirname+"/Resultats/"+'caracterisation.txt', 'w') as fp:
    for item in outputdata:
        fp.write("%s\n" % item)

print("\n")
print("Volume AIC : " + str(Volume * xs*xs*xs) + " mm3" + "\t(" + str(Volume) + " vox3)")
print("Surface collet : " + str(Collet.sum()*xs*xs) + " mm2" + "\t(" + str(Collet.sum()) + " vox2)")
print("Surface AIC : " + str(Surface*xs*xs) + " mm2" + "\t(" + str(Surface) + " vox2)")
print("Sphericity : " + str(Sphericity))
#print("Vol (bis) : " + str(dfVol*xs*xs*xs))
"""
print("Elongation : " + str(dfElongation))
print("Flatness : " + str(dfFlatness))
print("Box Size (1) : " + str(dfBoxSize1*xs))
print("Box Size (2) : " + str(dfBoxSize2*xs))
print("Box Size (3) : " + str(dfBoxSize3*xs))
"""
print("\n")
