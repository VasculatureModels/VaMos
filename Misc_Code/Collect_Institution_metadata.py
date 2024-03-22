#!/usr/bin/env python
# -*- coding: utf-8 -*-


from glob import glob
import os, sys
import pydicom

path = sys.argv[1]
imnames = glob(path + "*")

for im in imnames:
	print(im)
	imnames_l2 = glob(im+"/*" + '/')

	for im_l2 in imnames_l2:

		dicom_files = glob("%s/*" %im_l2)

		#filename = "/Users/---/Downloads/dataset/_DICOM/AIC_01_0174/308318/AIC_01_0174_20181128_TOF_3D_BIBLIO SIEMENS_1.2.840.113704.7.1.0.16723317255137249.1557758077.743.dcm"
		ds = pydicom.dcmread(dicom_files[0])
		#elem = ds[0x0008, 0x0081]

		Inst = ds.dir('Institution')
		#print(im)
		if Inst :
			if len(Inst) == 1:
				print(ds.data_element(Inst[0]))
			elif len(Inst) > 1:
				print(ds.data_element(Inst[0]))
				print(ds.data_element(Inst[1]))
		else:
			print('No institution metadata')

