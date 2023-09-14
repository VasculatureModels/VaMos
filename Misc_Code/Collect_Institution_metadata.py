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

