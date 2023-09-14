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

#import json
#import cv2
import napari
import sys
import nrrd
import pandas as pd

ver = sys.version_info
if ver[0] == 3 and ver[1] == 9 or ver[1] == 10:
	print("Using Python version {}.{} ... OK !".format(ver[0], ver[1]))
else :
	print('\n\t----------------')
	print('\t   WARNING ! ')
	print('\t----------------')
	print('\t --> Tested only with python versions 3.9 and 3.10...\n\n')
	#sys.exit(0)


#from MyFunctions.misc_fun import *
from MyFunctions.ICA_fun import *
#from MyFunctions.ICA_noise_generator import *
#from MyFunctions.GetBifurcDiameters import *


################################################################################################################################################
################################################################################################################################################
# construct the argument parser and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-i", "--image", type=str, default='/Users/----/Downloads/mult_unrupt_untreat/AIC_01_0011_F8-T_F9-O/200812/',
	help="Input 3D image (stack) (.nrrd, .nii or .mha)")
ap.add_argument("-f", "--Fid", type=int, default='9', required=True,
	help="Specify a Fiducial number (0 for all fiducials)")
ap.add_argument("-cs", "--CropSize", type=int, default=64,
	help="Size of the 3D crops to grab around the point of interest")
#ap.add_argument("-d3D", "--Disp3D", type=int, default=1,
#	help="Display the output 3D model (1 or 0)")


args = vars(ap.parse_args())

inputimage = args["image"]
print('\ninputimage=\'%s\'' %(inputimage))
seg = inputimage + '/../' + '_Segm_ICA/Segmentation.seg.nrrd'
#seg= args["seg"]
print('seg=\'%s\'' %(seg))
#Json = args["json"]
#print('Json=\'%s\'' %(Json))
Csv = inputimage + '/../' + '__fiducials.csv'
#Csv = args["csv"]
print('Csv=\'%s\'' %(Csv))
Fid = int(args["Fid"])
print('Fid=%d' %(Fid))
CropSize = int(args["CropSize"])
print('CropSize=%d' %(CropSize))
#d3D = int(args["Disp3D"])
#print('d3D=%d' %(d3D))


FileDir = os.path.dirname(os.path.abspath(inputimage)) + '/'
FileNameStack = (os.path.basename(inputimage))
FileName = os.path.splitext(os.path.basename(FileNameStack))[0]


'''
	Read input image:
'''
fileextG = os.path.splitext(inputimage)[1]
if fileextG == '.nii' or fileextG == '.mha' or fileextG == '.nrrd':
	sitkimg = sitk.ReadImage(inputimage, sitk.sitkUInt16)
	stackGray = sitk.GetArrayFromImage(sitkimg)

else:		   # Probably a DICOM folder...
	reader1 = sitk.ImageSeriesReader()
	dicom_names = reader1.GetGDCMSeriesFileNames(inputimage)
	reader1.SetFileNames(dicom_names)
	sitkimg = reader1.Execute()
	stackGray = sitk.GetArrayFromImage(sitkimg)
	#print('Warning, the input image is most probably a Dicom folder.\n This format is not fully supported !\n')


fileextS = os.path.splitext(seg)[1]
if fileextS == '.nii' or fileextS == '.mha' or fileextS == '.nrrd':
	#sitkimgSegm = sitk.ReadImage(seg)
	stackSegm1, headerSegm = nrrd.read(seg)
	if len(stackSegm1.shape) == 4:
		stackSegm1 = stackSegm1[0,:,:,:]
	x,y,z = stackSegm1.shape
	stackSegm = np.zeros((z,y,x))
	for i in range(z):
		stackSegm[i,:,:] = cv2.flip(cv2.rotate(stackSegm1[:,:,i], cv2.ROTATE_90_CLOCKWISE),2)
	
else:		   # Probably a DICOM folder...
	reader2 = sitk.ImageSeriesReader()
	dicom_names2 = reader2.GetGDCMSeriesFileNames(seg)
	reader2.SetFileNames(dicom_names2)
	sitkimgSeg = reader2.Execute()
	stackSegm = sitk.GetArrayFromImage(sitkimgSeg)
	#print('Warning, the segmentation is most probably a Dicom folder.\n This format is not fully supported !\n')

#z,y,x = stackGray.shape


'''
	Read Csv File:
'''
df = pd.read_csv(Csv, usecols = ['x','y','z'])
coords_arr = df.to_numpy()
coords_gt_bif = df.values.tolist()

[coords_gt_bif, node_id] = Get_Json_Bifs2(stackSegm, coords_gt_bif)

'''
	Read Json File:
'''
"""
f = open(Json)
data = json.load(f)

coords_gt_bif = []
fid_label = []
for i in range(len(data['markups'][0]['controlPoints'])):
	if (data['markups'][0]['controlPoints'][i]['position']) != '':
		coords_gt_bif.append(np.abs(data['markups'][0]['controlPoints'][i]['position']))
	else:
		coords_gt_bif.append(np.array([0,0,0]))
		print("\nWARNING : Bif Nb {} - No Fiducial was set !".format(i))
	fid_label.append(data['markups'][0]['controlPoints'][i]['label'])

[coords_gt_bif, node_id] = Get_Json_Bifs2(stackSegm, coords_gt_bif)
"""


""" """
print('------------------------------------------------------------------------------------\n')
k=0
for i in node_id:
	print('coords (x,y,z): ' +  str(int(coords_gt_bif[k][0])) + ', ' +
		str(int(coords_gt_bif[k][1])) + ', ' +
		str(int(coords_gt_bif[k][2])) + '\t' +
		'Fid:' + str(k+1) + ',\t' +
		'bif nb: ' + str(i))
	k+=1
print('------------------------------------------------------------------------------------\n')
""" """


fid_label = ['F-' +str(Fid)]


for FidLabel in fid_label:
	FidNb = int(FidLabel[FidLabel.find('-')+1:len(FidLabel)])
	XYZbif = coords_gt_bif[FidNb-1]
	BifNum = node_id[FidNb-1]
	hcs = int(CropSize/2)
	Xc, Yc, Zc = XYZbif
	print("Cropping around coords (x,y,z)= (%d,%d,%d)\n" %(Xc,Yc,Zc))

	if Xc < hcs:
		Xc = hcs
	if Yc < hcs:
		Yc = hcs
	if Zc < hcs:
		Zc = hcs
	if Xc > x - hcs:
		Xc = x - hcs
	if Yc > y - hcs:
		Yc = y - hcs
	if Zc > z - hcs:
		Zc = z - hcs

	CropBif = stackGray[Zc - hcs:Zc + hcs, Yc - hcs:Yc + hcs, Xc - hcs:Xc + hcs]
	CropSegm = stackSegm[Zc - hcs:Zc + hcs, Yc - hcs:Yc + hcs, Xc - hcs:Xc + hcs]

	

viewer = napari.view_image(CropBif)
#Disp3D(CropSegm)
napari.run()

print("\n")
