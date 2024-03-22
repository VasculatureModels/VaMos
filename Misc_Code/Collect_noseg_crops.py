
import os
import sys
import random
import numpy as np
import SimpleITK as sitk
from scipy.ndimage import distance_transform_edt


N = 30

inputname = sys.argv[1]
inputnameS = sys.argv[1]

Stack = sitk.GetArrayFromImage(sitk.ReadImage(inputname))
Segm = sitk.GetArrayFromImage(sitk.ReadImage(inputnameS))
z,y,x = Segm.shape


BaseName = (os.path.basename(inputname))
FileDir = os.path.dirname(os.path.abspath(inputname)) + '/'
FileNameNoExt = os.path.splitext(BaseName)[0]
FileExt = os.path.splitext(BaseName)[1]


InvSegm = 1 - Segm

dist = distance_transform_edt(InvSegm)

dist[0:32,:,:] = 0
dist[:,0:32,:] = 0
dist[:,:,0:32] = 0
dist[z-32:z,:,:] = 0
dist[:,y-32:y,:] = 0
dist[:,:,x-32:x] = 0


pos = np.where(dist > 64)

zpos = pos[0]
ypos = pos[1]
xpos = pos[2]


Len = len(zpos)

R = random.sample(range(1, Len), N)

for i in range(N):
	zp = zpos[R[i]]
	yp = ypos[R[i]]
	xp = xpos[R[i]]

	Crop = Stack[zp-32:zp+32, yp-32:yp+32, xp-32:xp+32]
	if Crop.sum() > 0 :
		sitk.WriteImage(sitk.GetImageFromArray(Crop), '/Users/---/Desktop/noseg/' + FileNameNoExt + '_xyz=_'+ str(xp) + '_' + str(yp) + '_' + str(zp) + '_noseg.seg.nrrd')
		print(FileNameNoExt + '_xyz=_'+ str(xp) + '_' + str(yp) + '_' + str(zp) + '_noseg.seg.nrrd' + '\t' + str(Crop.sum()))


