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

import os
import cv2
import sknw
import numpy as np
import elasticdeform
import SimpleITK as sitk
from scipy.ndimage import gaussian_filter
from scipy.ndimage import map_coordinates
from skimage.morphology import skeletonize_3d
from scipy.interpolate import RegularGridInterpolator

import raster_geometry as rg
#import tempfile
#import itertools as IT
#from scipy import ndimage
#from skimage.filters import *
#from skimage.morphology import skeletonize_3d
#import sknw
#import scipy.ndimage as ndi


#########################################################################################################

def uniquify(path):
	filename, extension = os.path.splitext(path)
	counter = 1

	while os.path.exists(path):
		path = filename + " (" + str(counter) + ")" + extension
		counter += 1

	return path

#########################################################################################################
def getRodriguesMatrix(axis, theta):
	v_length = np.linalg.norm(axis)
	if v_length==0:
		raise ValueError("length of rotation axis cannot be zero.")
	if theta==0.0:
		print('\nWarning: rotation of 0 degrees !\n')
		sys.exit(0)
	v = np.array(axis) / v_length
	### Rodrigues rotation matrix
	W = np.array([[0, -v[2], v[1]],
				[v[2], 0, -v[0]],
				[-v[1], v[0], 0]])
	rot3d_mat = np.identity(3) + W * np.sin(theta) + np.dot(W, W) * (1.0 - np.cos(theta))
	return rot3d_mat

#########################################################################################################
def getRodriguesMatrix_v2(axis, theta):
	RodMat = np.zeros((3,3))
	x = axis[0]
	y = axis[1]
	z = axis[2]

	RodMat[0,0] = np.cos(theta)+x*x*(1-np.cos(theta))
	RodMat[0,1] = x*y*(1-np.cos(theta))-z*np.sin(theta)
	RodMat[0,2] = y*np.sin(theta)+x*z*(1-np.cos(theta))

	RodMat[1,0] = z*np.sin(theta)+x*y*(1-np.cos(theta))
	RodMat[1,1] = np.cos(theta)+y*y*(1-np.cos(theta))
	RodMat[1,2] = -x*np.sin(theta)+y*z*(1-np.cos(theta))

	RodMat[2,0] = -y*np.sin(theta)+x*z*(1-np.cos(theta))
	RodMat[2,1] = x*np.sin(theta)+y*z*(1-np.cos(theta))
	RodMat[2,2] = np.cos(theta)+z*z*(1-np.cos(theta))

	return(RodMat)

#########################################################################################################
def max_entropy(data):
	"""
	Implements Kapur-Sahoo-Wong (Maximum Entropy) thresholding method
	Kapur J.N., Sahoo P.K., and Wong A.K.C. (1985) "A New Method for Gray-Level Picture Thresholding Using the Entropy
	of the Histogram", Graphical Models and Image Processing, 29(3): 273-285
	M. Emre Celebi
	06.15.2007
	Ported to ImageJ plugin by G.Landini from E Celebi's fourier_0.8 routines
	2016-04-28: Adapted for Python 2.7 by Robert Metchev from Java source of MaxEntropy() in the Autothresholder plugin
	http://rsb.info.nih.gov/ij/plugins/download/AutoThresholder.java
	:param data: Sequence representing the histogram of the image
	:return threshold: Resulting maximum entropy threshold
	"""

	# calculate CDF (cumulative density function)
	cdf = data.astype(np.float).cumsum()

	# find histogram's nonzero area
	valid_idx = np.nonzero(data)[0]
	first_bin = valid_idx[0]
	last_bin = valid_idx[-1]

	# initialize search for maximum
	max_ent, threshold = 0, 0

	for it in range(first_bin, last_bin + 1):
		# Background (dark)
		hist_range = data[:it + 1]
		hist_range = hist_range[hist_range != 0] / cdf[it]  # normalize within selected range & remove all 0 elements
		tot_ent = -np.sum(hist_range * np.log(hist_range))  # background entropy

		# Foreground/Object (bright)
		hist_range = data[it + 1:]
		# normalize within selected range & remove all 0 elements
		hist_range = hist_range[hist_range != 0] / (cdf[last_bin] - cdf[it])
		tot_ent -= np.sum(hist_range * np.log(hist_range))  # accumulate object entropy

		# find max
		if tot_ent > max_ent:
			max_ent, threshold = tot_ent, it

	return threshold

#########################################################################################################
def maxEntropyTh(stack):
	z,y,x = stack.shape
	for i in range(z):
		BinSlice = np.uint8(stack[i, :, :])
		hist = np.histogram(BinSlice, bins=256, range=(0, 256))[0]
		th = max_entropy(hist)
		stack[i, :, :][stack[i, :, :] >= th] = 255
		stack[i, :, :][stack[i, :, :] < th] = 0

	stack[stack > 0] = 255
	return(stack)

#########################################################################################################
def rot_3d(image, x_center, y_center, z_center, axis, theta):

	transform_matrix = getRodriguesMatrix(image, x_center, y_center, z_center, axis, theta)

	trans_mat_inv = np.linalg.inv(transform_matrix)

	Nz, Ny, Nx = image.shape
	x = np.linspace(0, Nx - 1, Nx)
	y = np.linspace(0, Ny - 1, Ny)
	z = np.linspace(0, Nz - 1, Nz)
	zz, yy, xx = np.meshgrid(z, y, x, indexing='ij')
	coor = np.array([xx - x_center, yy - y_center, zz - z_center])

	coor_prime = np.tensordot(trans_mat_inv, coor, axes=((1), (0)))
	xx_prime = coor_prime[0] + x_center
	yy_prime = coor_prime[1] + y_center
	zz_prime = coor_prime[2] + z_center

	x_valid1 = xx_prime>=0
	x_valid2 = xx_prime<=Nx-1
	y_valid1 = yy_prime>=0
	y_valid2 = yy_prime<=Ny-1
	z_valid1 = zz_prime>=0
	z_valid2 = zz_prime<=Nz-1
	valid_voxel = x_valid1 * x_valid2 * y_valid1 * y_valid2 * z_valid1 * z_valid2
	z_valid_idx, y_valid_idx, x_valid_idx = np.where(valid_voxel > 0)

	image_transformed = np.zeros((Nz, Ny, Nx))

	data_w_coor = RegularGridInterpolator((z, y, x), image, method="nearest") ## method = "linear", "nearest", "slinear", "cubic", "quintic" or "pchip"
	interp_points = np.array([zz_prime[z_valid_idx, y_valid_idx, x_valid_idx],
							yy_prime[z_valid_idx, y_valid_idx, x_valid_idx],
							xx_prime[z_valid_idx, y_valid_idx, x_valid_idx]]).T
	interp_result = data_w_coor(interp_points)
	image_transformed[z_valid_idx, y_valid_idx, x_valid_idx] = interp_result

	return(image_transformed)

#########################################################################################################
def Make_Sphere_1(x, y, z):

	x1D = np.linspace(0, x-1, x)
	y1D = np.linspace(0, y-1, y)
	x2D, y2D = np.meshgrid(x1D, y1D)

	x_3D = np.zeros([z, y, x], dtype=np.float64)
	y_3D = np.zeros([z, y, x], dtype=np.float64)
	z_3D = np.zeros([z, y, x], dtype=np.float64)

	for i in range(z):
		x_3D[i, :, :] = x2D
		y_3D[i, :, :] = y2D
		z_3D[i, :, :] = np.float64(i)

	Sph_3D = np.zeros([x, y, z], dtype=np.float64)
	Sph_3D = np.power((x_3D-int(x/2)), 2) + np.power((y_3D-int(y/2)),2) + np.power((z_3D-int(z/2)), 2)

	Sph_3D[Sph_3D <= ((int(x/2)-1)*(int(x/2)-1))] = 1
	Sph_3D[Sph_3D != 1] = 0

	return(Sph_3D)

#########################################################################################################

def Make_Sphere_2(x, y, z):

	x1D = np.linspace(0, x-1, x)
	y1D = np.linspace(0, y-1, y)
	x2D, y2D = np.meshgrid(x1D, y1D)

	x_3D = np.zeros([z, y, x], dtype=np.float64)
	y_3D = np.zeros([z, y, x], dtype=np.float64)
	z_3D = np.zeros([z, y, x], dtype=np.float64)

	for i in range(z):
		x_3D[i, :, :] = x2D
		y_3D[i, :, :] = y2D
		z_3D[i, :, :] = np.float64(i)

	Sph_3D = np.zeros([x, y, z], dtype=np.float64)
	Sph_3D = np.power((x_3D-int(x/2)), 2) + np.power((y_3D-int(y/2)),2) + np.power((z_3D-int(z/2)), 2)

	Sph_3D[Sph_3D <= ((int(x/2)-1)*(int(x/2)-1))] = 1
	Sph_3D[Sph_3D != 1] = 0
	Rx = int(int(x/2) + np.random.uniform(-int(x/4), int(x/4)))
	Ry = int(int(y/2) + np.random.uniform(-int(y/4), int(y/4)))
	Rz = int(int(z/2) + np.random.uniform(-int(z/4), int(z/4)))
	Sph_3D[Rx,Ry,Rz] = 0
	Sph_3D[int(x/2),int(y/2),int(z/2)] = 0
	#dilated1 = ndi.binary_dilation(mask3d, diamond, iterations=15)

	return(Sph_3D)

#########################################################################################################
""" """
def Make_Sphere_3(x):

	Sph_3D = rg.sphere((int(x), int(x), int(x)), (int(x/2))).astype(np.int_)
	#Rx = int(int(x/2) + np.random.uniform(-int(x/4), int(x/4)))
	#Ry = int(int(x/2) + np.random.uniform(-int(x/4), int(x/4)))
	#Rz = int(int(x/2) + np.random.uniform(-int(x/4), int(x/4)))
	#Sph_3D[Rx,Ry,Rz] = 0
	#Sph_3D[int(x/2),int(x/2),int(x/2)] = 0

	return(Sph_3D)
""" """

#########################################################################################################
def Make_Sphere_4(diam):

	radius = np.uint8(diam/2)
	position = (radius, radius, radius)
	shape = (diam, diam, diam)
	position = np.array(position).reshape((-1,) + (1,) * 3)
	arr = np.linalg.norm(np.indices(shape) - position, axis=0)
	p = arr <= radius
	return(np.uint8(p))

#########################################################################################################
def Display_dual_3D(Model, GTruth):

	from mayavi import mlab

	zm,ym,xm = Model.shape
	zg,yg,xg = GTruth.shape

	Model[Model > 0] = 255
	"""
	Edges1 = np.zeros(Model.shape)
	Edges2 = np.zeros(Model.shape)
	Edges3 = np.zeros(Model.shape)
	Edges4 = np.zeros(Model.shape)
	Edges5 = np.zeros(Model.shape)
	Edges6 = np.zeros(Model.shape)
	Edges1[0:2,:,:] = 1
	Edges2[zm-2:zm,:,:] = 1
	Edges3[:,0:2,:] = 1
	Edges4[:,ym-2:ym,:] = 1
	Edges5[:,:,0:2] = 1
	Edges6[:,:,xm-2:xm] = 1
	
	Edges = Edges1 + Edges2 + Edges3 + Edges4 + Edges5 + Edges6
	Edges[Edges>=2] = 255
	Model[Edges==255] = 255
	#sitk.WriteImage(sitk.GetImageFromArray(np.uint16(Model)), "/Users/florent/Desktop/Model.nrrd")
	"""

	""" 
	Model[Model>0] = 1
	Model2 = ndi.binary_dilation(Model).astype(Model.dtype)
	Model2[Model2>0] = 1
	Model = Model2 - Model
	#sitk.WriteImage(sitk.GetImageFromArray(np.uint16(data)), "/Users/florent/Desktop/data.nrrd")
	""" 
	Model = np.uint16(Model.T *20.0)

	mlab.figure(bgcolor=(0.63, 0.63, 0.63), size=(600, 600))

	src1 = mlab.pipeline.scalar_field(Model)
	#src1.spacing = [1, 1, 1.5]
	src1.update_image_data = True


	blur1 = mlab.pipeline.user_defined(src1, filter='ImageGaussianSmooth')
	voi1 = mlab.pipeline.extract_grid(blur1)
	voi1.trait_set(x_min=1, x_max=xm-1, y_min=1, y_max=ym-1, z_min=1, z_max=zm-1)

	mlab.pipeline.iso_surface(voi1, colormap='hot')
	mlab.title("Model", size=0.6)

	#voi1b = mlab.pipeline.extract_grid(src1)
	#voi1b.trait_set(y_max=int(ym/3), z_max=int(zm*2/3))
	##voi1b.trait_set(y_max=12, z_max=53)
	##outer1b = mlab.pipeline.iso_surface(voi1b, contours=[1776, ], color=(0.8, 0.7, 0.6))
	#outer1b = mlab.pipeline.iso_surface(voi1b, color=(0.8, 0.7, 0.6))

	"""
	GTruth[GTruth > 0] = 255
	GTruth[Edges==255] = 255
	"""
	
	""" 
	GTruth[GTruth>0] = 1
	GTruth2 = ndi.binary_dilation(GTruth).astype(GTruth.dtype)
	GTruth2[GTruth2>0] = 1
	GTruth = GTruth2 - GTruth
	#sitk.WriteImage(sitk.GetImageFromArray(np.uint16(data)), "/Users/florent/Desktop/data.nrrd")
	""" 
	GTruth = np.uint16(GTruth.T *20.0)

	mlab.figure(bgcolor=(0.63, 0.63, 0.63), size=(600, 600))

	src2 = mlab.pipeline.scalar_field(GTruth)
	#src2.spacing = [1, 1, 1.5]
	src2.update_image_data = True


	blur2 = mlab.pipeline.user_defined(src2, filter='ImageGaussianSmooth')
	voi2 = mlab.pipeline.extract_grid(blur2)
	voi2.trait_set(x_min=1, x_max=xg-1, y_min=1, y_max=yg-1, z_min=1, z_max=zg-1)

	mlab.pipeline.iso_surface(voi2, colormap='hot')
	mlab.title("Ground Truth", size=0.6)
	
	#voi2b = mlab.pipeline.extract_grid(src2)
	#voi2b.trait_set(y_max=int(yg/3), z_max=int(zg*2/3))
	##voi2b.trait_set(y_max=12, z_max=53)
	##outer2b = mlab.pipeline.iso_surface(voi2b, contours=[1776, ], color=(0.8, 0.7, 0.6))
	#outer2b = mlab.pipeline.iso_surface(voi2b, color=(0.8, 0.7, 0.6))

	mlab.show()

#########################################################################################################

def Display_dual_3D_grouped(Model, GTruth, FileName):

	from mayavi import mlab
	DoGaussianBlur = 0

	Model[Model > 0] = 220
	GTruth[GTruth > 0] = 255

	buffer = np.zeros((Model.shape[1], 12, Model.shape[2]))

	dataStack1 = np.hstack((Model, buffer))
	dataStack = np.hstack((dataStack1, GTruth))
	data = dataStack

	### Avoid display problems due to the presence of several colors in the stack,
	### We threshold so that it's fully binary, everything is set to 255 :

	#Model = np.uint16(Model.T *20.0)

	# Display the data ############################################################

	print(FileName)
	mlab.figure(FileName, bgcolor=(0.63, 0.63, 0.63), size=(600, 600))
	src = mlab.pipeline.scalar_field(data)
	# Our data is not equally spaced in all directions:
	#src.spacing = [1, 1, 1.5]
	src.update_image_data = True


	# Extract some inner structures: the ventricles and the inter-hemisphere
	# fibers. We define a volume of interest (VOI) that restricts the
	# iso-surfaces to the inner of the brain. We do this with the ExtractGrid
	# filter.

	if DoGaussianBlur == 1:
		blur = mlab.pipeline.user_defined(src, filter='ImageGaussianSmooth')
		voi = mlab.pipeline.extract_grid(blur)
	else:
		voi = mlab.pipeline.extract_grid(src)

	#mlab.pipeline.iso_surface(voi, contours=[1610, 2480], colormap='autumn')
	mlab.pipeline.iso_surface(voi, colormap='hot')

	#FileName = FileName + '.png'
	#mlab.savefig(filename=FileName)
	mlab.show()


#########################################################################################################

def Display_dual_3D_grouped2(Model, GTruth, ICA, MotherBranch):

	from mayavi import mlab
	DoGaussianBlur = 0

	Model[Model > 0] = 220
	GTruth[GTruth > 0] = 255

	buffer = np.zeros((Model.shape[1], 12, Model.shape[2]))

	dataStack1 = np.hstack((Model, buffer))
	dataStack = np.hstack((dataStack1, GTruth))
	data = dataStack

	dataStack2 = np.hstack((ICA, buffer))
	dataStackICA = np.hstack((dataStack2, np.zeros(GTruth.shape)))
	dataica = dataStackICA

	dataStack3 = np.hstack((MotherBranch, buffer))
	dataStackMB = np.hstack((dataStack3, np.zeros(GTruth.shape)))
	datamb = dataStackMB

	mlab.figure("3D View", bgcolor=(0.63, 0.63, 0.63), size=(600, 600))
	#src = mlab.pipeline.scalar_field(data)
	#src.update_image_data = True
	src1 = mlab.pipeline.scalar_field(data)
	src2 = mlab.pipeline.scalar_field(dataica)
	src3 = mlab.pipeline.scalar_field(datamb)
	src1.update_image_data = True
	src2.update_image_data = True
	src3.update_image_data = True

	if DoGaussianBlur == 1:
		blur1 = mlab.pipeline.user_defined(src1, filter='ImageGaussianSmooth')
		blur2 = mlab.pipeline.user_defined(src2, filter='ImageGaussianSmooth')
		blur3 = mlab.pipeline.user_defined(src3, filter='ImageGaussianSmooth')
		voi1 = mlab.pipeline.extract_grid(blur1)
		voi2 = mlab.pipeline.extract_grid(blur2)
		voi3 = mlab.pipeline.extract_grid(blur3)
	else:
		voi1 = mlab.pipeline.extract_grid(src1)
		voi2 = mlab.pipeline.extract_grid(src2)
		voi3 = mlab.pipeline.extract_grid(src3)

	mlab.pipeline.iso_surface(voi1, colormap='hot')
	mlab.pipeline.iso_surface(voi2, colormap='winter')
	mlab.pipeline.iso_surface(voi3, colormap='terrain')

	mlab.show()



#########################################################################################################

def Display_3D(SplineModelTOF):

	from mayavi import mlab

	SplineModelTOF[SplineModelTOF > 0] = 255
	SplineModelTOF = np.uint16(SplineModelTOF.T *20.0)

	mlab.figure(bgcolor=(0, 0, 0), size=(600, 600))

	src = mlab.pipeline.scalar_field(SplineModelTOF)
	# Our data is not equally spaced in all directions:
	src.spacing = [1, 1, 1.5]
	src.update_image_data = True

	z,y,x = SplineModelTOF.shape

	# Extract some inner structures: the ventricles and the inter-hemisphere
	# fibers. We define a volume of interest (VOI) that restricts the
	# iso-surfaces to the inner of the brain. We do this with the ExtractGrid
	# filter.
	DoGaussianBlur = 0
	if DoGaussianBlur == 1:
		blur = mlab.pipeline.user_defined(src, filter='ImageGaussianSmooth')
		voi = mlab.pipeline.extract_grid(blur)
	else:
		voi = mlab.pipeline.extract_grid(src)
	voi.trait_set(x_min=1, x_max=x-1, y_min=1, y_max=y-1, z_min=1, z_max=z-1)

	#voi = mlab.pipeline.extract_grid(src)

	#mlab.pipeline.iso_surface(voi, contours=[1610, 2480], colormap='autumn')
	mlab.pipeline.iso_surface(voi, colormap='autumn')


	# Extract two views of the outside surface. We need to define VOIs in
	# order to leave out a cut in the head.
	"""
	voi2 = mlab.pipeline.extract_grid(src)
	#voi2.trait_set(y_min=1)
	#outer = mlab.pipeline.iso_surface(voi2, contours=[1776, ], color=(0.8, 0.4, 0.3))
	outer = mlab.pipeline.iso_surface(voi2, color=(0.8, 0.4, 0.3))
	"""
	""" """
	voi3 = mlab.pipeline.extract_grid(src)
	voi3.trait_set(y_max=12, z_max=53)
	outer3 = mlab.pipeline.iso_surface(voi3, contours=[1776, ], color=(0.8, 0.7, 0.6))
	""" """

	#mlab.view(-125, 54, 326, (145.5, 138, 66.5))
	#mlab.roll(-175)

	mlab.show()

#########################################################################################################

def resample_image2(itk_image, is_label=False):
	original_spacing = itk_image.GetSpacing()
	out_spacing=[original_spacing[0], original_spacing[0], original_spacing[0]]
	original_size = itk_image.GetSize()
	out_size = [
		int(np.round(original_size[0] * (original_spacing[0] / out_spacing[0]))),
		int(np.round(original_size[1] * (original_spacing[1] / out_spacing[1]))),
		int(np.round(original_size[2] * (original_spacing[2] / out_spacing[2])))
	]
	resample = sitk.ResampleImageFilter()
	resample.SetOutputSpacing(out_spacing)
	resample.SetSize(out_size)
	resample.SetOutputDirection(itk_image.GetDirection())
	resample.SetOutputOrigin(itk_image.GetOrigin())
	resample.SetTransform(sitk.Transform())
	resample.SetDefaultPixelValue(itk_image.GetPixelIDValue())
	if is_label:
		resample.SetInterpolator(sitk.sitkNearestNeighbor)
	else:
		resample.SetInterpolator(sitk.sitkLinear)
	return resample.Execute(itk_image)

#########################################################################################################
# From : https://www.kaggle.com/code/ori226/data-augmentation-with-elastic-deformations/notebook
def elastic_transform(image, alpha, sigma, alpha_affine, random_state=None):
    """Elastic deformation of images as described in [Simard2003]_ (with modifications).
    .. [Simard2003] Simard, Steinkraus and Platt, "Best Practices for
         Convolutional Neural Networks applied to Visual Document Analysis", in
         Proc. of the International Conference on Document Analysis and
         Recognition, 2003.

     Based on https://gist.github.com/erniejunior/601cdf56d2b424757de5
    """
    if random_state is None:
        random_state = np.random.RandomState(None)

    shape = image.shape
    shape_size = shape[:2]
    
    # Random affine
    center_square = np.float32(shape_size) // 2
    square_size = min(shape_size) // 3
    pts1 = np.float32([center_square + square_size, [center_square[0]+square_size, center_square[1]-square_size], center_square - square_size])
    pts2 = pts1 + random_state.uniform(-alpha_affine, alpha_affine, size=pts1.shape).astype(np.float32)
    M = cv2.getAffineTransform(pts1, pts2)
    image = cv2.warpAffine(image, M, shape_size[::-1], borderMode=cv2.BORDER_REFLECT_101)

    dx = gaussian_filter((random_state.rand(*shape) * 2 - 1), sigma) * alpha
    dy = gaussian_filter((random_state.rand(*shape) * 2 - 1), sigma) * alpha
    dz = np.zeros_like(dx)

    x, y, z = np.meshgrid(np.arange(shape[1]), np.arange(shape[0]), np.arange(shape[2]))
    indices = np.reshape(y+dy, (-1, 1)), np.reshape(x+dx, (-1, 1)), np.reshape(z, (-1, 1))

    return map_coordinates(image, indices, order=1, mode='reflect').reshape(shape)

########################################################################################################################

def max_entropy(data): # pour la segmentation
    """
    Implements Kapur-Sahoo-Wong (Maximum Entropy) thresholding method
    Kapur J.N., Sahoo P.K., and Wong A.K.C. (1985) "A New Method for Gray-Level Picture Thresholding Using the Entropy
    of the Histogram", Graphical Models and Image Processing, 29(3): 273-285
    M. Emre Celebi
    06.15.2007
    Ported to ImageJ plugin by G.Landini from E Celebi's fourier_0.8 routines
    2016-04-28: Adapted for Python 2.7 by Robert Metchev from Java source of MaxEntropy() in the Autothresholder plugin
    http://rsb.info.nih.gov/ij/plugins/download/AutoThresholder.java
    :param data: Sequence representing the histogram of the image
    :return threshold: Resulting maximum entropy threshold
    """

    # calculate CDF (cumulative density function)
    cdf = data.astype(np.float).cumsum()

    # find histogram's nonzero area
    valid_idx = np.nonzero(data)[0]
    first_bin = valid_idx[0]
    last_bin = valid_idx[-1]

    # initialize search for maximum
    max_ent, threshold = 0, 0

    for it in range(first_bin, last_bin + 1):
        # Background (dark)
        hist_range = data[:it + 1]
        hist_range = hist_range[hist_range != 0] / cdf[it]  # normalize within selected range & remove all 0 elements
        tot_ent = -np.sum(hist_range * np.log(hist_range))  # background entropy

        # Foreground/Object (bright)
        hist_range = data[it + 1:]
        # normalize within selected range & remove all 0 elements
        hist_range = hist_range[hist_range != 0] / (cdf[last_bin] - cdf[it])
        tot_ent -= np.sum(hist_range * np.log(hist_range))  # accumulate object entropy

        # find max
        if tot_ent > max_ent:
            max_ent, threshold = tot_ent, it

    return threshold


#########################################################################################################

def CropStack(stack):

	z,y,x = stack.shape

	###   Find min & max position of the ROI along the z-axis:   ###
	s_z = []
	for i in range(z):
		s_z.append(stack[i,:,:].sum())

	s_z = np.asarray(s_z)
	pos_z = np.asarray(np.where(s_z>0))
	len_pos_z = pos_z.shape[1]
	pz0 = pos_z[0][0]
	pz1 = pos_z[0][len_pos_z-1]+1

	###   Find min & max position of the ROI along the x-axis:   ###
	proj_x = []
	pos_x0 = []
	pos_x1 = []
	for i in range(pz0,pz1):
		proj_x.append(np.sum(stack[i,:,:], axis=0))
		s_x = np.asarray(proj_x[i-pz0])
		pos_x = np.asarray(np.where(s_x>0))
		len_pos_x = pos_x.shape[1]
		pos_x0.append(pos_x[0][0])
		pos_x1.append(pos_x[0][len_pos_x-1]+1)

	px0 = min(pos_x0)
	px1 = max(pos_x1)

	###   Find min & max position of the ROI along the y-axis:   ###
	proj_y = []
	pos_y0 = []
	pos_y1 = []
	for i in range(pz0,pz1):
		proj_y.append(np.sum(stack[i,:,:], axis=1))
		s_y = np.asarray(proj_y[i-pz0])
		pos_y = np.asarray(np.where(s_y>0))
		len_pos_y = pos_y.shape[1]
		pos_y0.append(pos_y[0][0])
		pos_y1.append(pos_y[0][len_pos_y-1]+1)

	py0 = min(pos_y0)
	py1 = max(pos_y1)

	CroppedStack = np.zeros(((pz1-pz0),(py1-py0),(px1-px0)), dtype=np.uint8)
	CroppedStack = stack[pz0:pz1 , py0:py1 , px0:px1]

	return(CroppedStack)


#########################################################################################################

def CropStack_XYZ(stack, CropCenter, CropSize):

	z,y,x = stack.shape
	Xc = int(CropCenter[0])
	Yc = int(CropCenter[1])
	Zc = int(CropCenter[2])
	hc = int(CropSize/2.)

	CroppedStack = np.zeros((CropSize,CropSize,CropSize), dtype=np.uint16)
	CroppedStack = stack[Zc-hc:Zc+hc, Yc-hc:Yc+hc , Xc-hc:Xc+hc]

	return(CroppedStack)


#########################################################################################################
def Get_Json_Bifs(stack, coords_gt_bif):

	ske = skeletonize_3d(stack).astype(np.uint16)
	graph = sknw.build_sknw(ske)
	stack[stack>0]=255

	#detection des centres de bifurcations
	List_coords_bif=[]
	List_noeud_graph_bifurc=[]
	for j in range(len(graph)):
		if len( list(graph.neighbors(j) ) )>2   :
			neighbors=list(graph.neighbors(j))
			if j  in neighbors:
				neighbors.remove(j )
			if len(neighbors)<3:
				continue
			if len(neighbors)<2 or len(graph[j][neighbors[0]]['pts'] ) <4 or len(graph[j][neighbors[1]]['pts'] ) <4 or len(graph[j][neighbors[2]]['pts'] ) <4: #<=10 before
				continue
			else:
				coords_noeud_central=graph.nodes[j]['o']
				z=coords_noeud_central[0]
				y=coords_noeud_central[1]
				x=coords_noeud_central[2]
				posBifurc=[x,y]
				posBifurc.append(z)
				posBifurc=[posBifurc]
				List_coords_bif.append(posBifurc) #contient les coordonénes 3D des centres des bifs
				List_noeud_graph_bifurc.append(j) #contient l'indice des des noeuds du graph constituant les centres des bifs

		else:
			continue

	#print('nbr bif : ',len(List_noeud_graph_bifurc))
	dist=[]
	min_coords_id=[]
	node_id=[]

	for coords_gt in coords_gt_bif:
		for i in range(len(List_noeud_graph_bifurc)):
			dist.append(np.linalg.norm(np.array(coords_gt)- np.array(List_coords_bif[i][0])))
		min_coords_id.append(List_coords_bif[dist.index(min(dist))])
		node_id.append(List_noeud_graph_bifurc[dist.index(min(dist))])
		dist=[]

	return (coords_gt_bif, node_id)

#########################################################################################################
def Get_Json_Bifs2(stack, coords_gt_bif):

	stack[stack > 0] = 1.
	ske = skeletonize_3d(stack).astype(np.uint16)
	graph = sknw.build_sknw(ske)
	stack[stack>0]=255

	#print('----- Preprocessing de la stack')
	#-------------------------------------------------------------------------------------------
	#pré-processing pour supprimer les petits voxels associés au bruit + supprimer du squelette les petites artères dont length<10 + réduire dans le squellete les artères dont length>=25
	for i in graph.nodes():

		if len(list(graph.neighbors(i)))==0: #supression des petits voxels associés au bruit
			pts=graph.nodes[i]['pts']
			for k in range(len(pts)):
				ske[int(pts[k][0]),int(pts[k][1]),int(pts[k][2]) ]=0

		elif len(list(graph.neighbors(i)))==1	  :	#supression des suites de voxels associés au bruit
			if len(  list(graph.neighbors( list(graph.neighbors(i))[0] ) ) )==1:
				neighbor=list(graph.neighbors(i) ) [0]
				pts=graph[i][neighbor]['pts'].copy()
				coords_center_bif=graph.nodes[i]['o']
				if(np.linalg.norm(pts[0]- coords_center_bif)> np.linalg.norm(pts[len(pts )-1]- coords_center_bif)):
					pts=list(reversed(pts ) )
				pts=np.vstack( [ graph.nodes[i ][ 'o'] , pts  ] )
				pts=np.vstack( [ pts ,graph.nodes[neighbor ][ 'o'] ] )

				for k in range(len(pts)):
					ske[int(pts[k][0]),int(pts[k][1]),int(pts[k][2]) ]=0


				pts=graph.nodes[i]['pts']
				for k in range(len(pts)):
					ske[int(pts[k][0]),int(pts[k][1]),int(pts[k][2]) ]=0


				pts=graph.nodes[neighbor]['pts']
				for k in range(len(pts)):
					ske[int(pts[k][0]),int(pts[k][1]),int(pts[k][2]) ]=0

		else:
			neighbors=list(graph.neighbors(i))
			for j in range(len(neighbors)):

				if (len(graph[i][neighbors[j]]['pts']) <=5 ): #suppresion dans le skelette des petites artères
					if ( len(  list(graph.neighbors(neighbors[j]))  )==1) :
						neighbor=neighbors[j]
						pts=graph[i][neighbor]['pts'].copy()
						coords_center_bif=graph.nodes[i]['o']
						if(np.linalg.norm(pts[0]- coords_center_bif)> np.linalg.norm(pts[len(pts )-1]- coords_center_bif)):
							pts=list(reversed(pts ) )
						pts=np.vstack( [ pts ,graph.nodes[neighbors[j] ][ 'o'] ] )


						for k in range(len(pts)):
							ske[int(pts[k][0]),int(pts[k][1]),int(pts[k][2]) ]=0

						pts=graph.nodes[neighbor]['pts']
						for k in range(len(pts)):
							ske[int(pts[k][0]),int(pts[k][1]),int(pts[k][2]) ]=0

	ListBifurcBox=[]
	List_noeud_graph_bifurc=[]
	for j in range(len(graph)):
		if len( list(graph.neighbors(j) ) )>2   :
			neighbors=list(graph.neighbors(j))
			if j  in neighbors:
				neighbors.remove(j )
				if len(neighbors)<3:
					continue
			if len(neighbors)<2 or len(graph[j][neighbors[0]]['pts'] ) <4 or len(graph[j][neighbors[1]]['pts'] ) <4 or len(graph[j][neighbors[2]]['pts'] ) <4: #<=10 before
				#print("continue");
				continue
			else:
				coords_noeud_central=graph.nodes[j]['o']
				z=coords_noeud_central[0]
				y=coords_noeud_central[1]
				x=coords_noeud_central[2]
				center=j
				posBifurc=[x,y]
				posBifurc.append(z)
				posBifurc=[posBifurc]
				ListBifurcBox.append(posBifurc) #contient les coordonénes 3D des centres des bifs
				List_noeud_graph_bifurc.append(j) #contient l'indice des des noeuds du graph constituant les centres des bifs

		else:
			continue

	graph = sknw.build_sknw(ske)
	for i in graph.nodes():

		if len(list(graph.neighbors(i)))==0: #supression des petits voxels associés au bruit
			pts=graph.nodes[i]['pts']
			for k in range(len(pts)):
				ske[int(pts[k][0]),int(pts[k][1]),int(pts[k][2]) ]=0

		elif len(list(graph.neighbors(i)))==1	  :	#supression des suites de voxels associés au bruit
			if len(  list(graph.neighbors( list(graph.neighbors(i))[0] ) ) )==1:
				neighbor=list(graph.neighbors(i) ) [0]
				pts=graph[i][neighbor]['pts'].copy()
				coords_center_bif=graph.nodes[i]['o']
				if(np.linalg.norm(pts[0]- coords_center_bif)> np.linalg.norm(pts[len(pts )-1]- coords_center_bif)):
					pts=list(reversed(pts ) )
				pts=np.vstack( [ graph.nodes[i ][ 'o'] , pts  ] )
				pts=np.vstack( [ pts ,graph.nodes[neighbor ][ 'o'] ] )

				for k in range(len(pts)):
					ske[int(pts[k][0]),int(pts[k][1]),int(pts[k][2]) ]=0


				pts=graph.nodes[i]['pts']
				for k in range(len(pts)):
					ske[int(pts[k][0]),int(pts[k][1]),int(pts[k][2]) ]=0


				pts=graph.nodes[neighbor]['pts']
				for k in range(len(pts)):
					ske[int(pts[k][0]),int(pts[k][1]),int(pts[k][2]) ]=0

		else:
			neighbors=list(graph.neighbors(i))
			for j in range(len(neighbors)):

				if (len(graph[i][neighbors[j]]['pts']) <=5 ): #suppresion dans le skelette des petites artères
					if ( len(  list(graph.neighbors(neighbors[j]))  )==1) :
						neighbor=neighbors[j]
						pts=graph[i][neighbor]['pts'].copy()
						coords_center_bif=graph.nodes[i]['o']
						if(np.linalg.norm(pts[0]- coords_center_bif)> np.linalg.norm(pts[len(pts )-1]- coords_center_bif)):
							pts=list(reversed(pts ) )
						pts=np.vstack( [ pts ,graph.nodes[neighbors[j] ][ 'o'] ] )


						for k in range(len(pts)):
							ske[int(pts[k][0]),int(pts[k][1]),int(pts[k][2]) ]=0

						pts=graph.nodes[neighbor]['pts']
						for k in range(len(pts)):
							ske[int(pts[k][0]),int(pts[k][1]),int(pts[k][2]) ]=0

	ListBifurcBox=[]
	List_noeud_graph_bifurc=[]
	for j in range(len(graph)):
		if len( list(graph.neighbors(j) ) )>2   :
			neighbors=list(graph.neighbors(j))
			if j  in neighbors:
				neighbors.remove(j )
				if len(neighbors)<3:
					continue
			if len(neighbors)<2 or len(graph[j][neighbors[0]]['pts'] ) <4 or len(graph[j][neighbors[1]]['pts'] ) <4 or len(graph[j][neighbors[2]]['pts'] ) <4: #<=10 before
				#print("continue");
				continue
			else:
				coords_noeud_central=graph.nodes[j]['o']
				z=coords_noeud_central[0]
				y=coords_noeud_central[1]
				x=coords_noeud_central[2]
				center=j
				posBifurc=[x,y]
				posBifurc.append(z)
				posBifurc=[posBifurc]
				ListBifurcBox.append(posBifurc) #contient les coordonénes 3D des centres des bifs
				List_noeud_graph_bifurc.append(j) #contient l'indice des des noeuds du graph constituant les centres des bifs

		else:
			continue

	#print('nbr bif : ',len(List_noeud_graph_bifurc))
	dist=[]
	min_coords_id=[]
	node_id=[]

	for coords_gt in coords_gt_bif:
		for i in range(len(List_noeud_graph_bifurc)):
			dist.append(np.linalg.norm(np.array(coords_gt)- np.array(ListBifurcBox[i][0])))
		min_coords_id.append(ListBifurcBox[dist.index(min(dist))])
		node_id.append(List_noeud_graph_bifurc[dist.index(min(dist))])
		dist=[]

	return (coords_gt_bif, node_id)

#########################################################################################################
def Get_Json_Bifs3(stack, coords_gt_bif):

	stack[stack > 0] = 1.
	ske = skeletonize_3d(stack).astype(np.uint16)
	graph = sknw.build_sknw(ske)
	stack[stack>0]=255

	dist = []
	node_id=[]
	for coords_gt in coords_gt_bif:
		for i in range(len(graph)):
			coords_center_bif = graph.nodes[i]['o']
			coords_center_bif = coords_center_bif[::-1]
			dist.append(np.linalg.norm(np.array(coords_gt) - np.array(coords_center_bif)))
		node_id.append(dist.index(min(dist)))
		dist=[]

	return (coords_gt_bif, node_id)

#########################################################################################################
def Get_Json_Bifs4(stackSegm, coords_gt_bif):

	stackSegm[stackSegm > 0] = 1.
	ske = skeletonize_3d(stackSegm).astype(np.uint16)
	graph = sknw.build_sknw(ske)

	node_centers = []
	for i in graph.nodes():
		node_centers.append(graph.nodes[i]['o'])

	node_id = []
	for i in range(len(coords_gt_bif)):
		dist = []
		for j in range(len(node_centers)):
			dist.append(np.sqrt((coords_gt_bif[i][0] - node_centers[j][2])**2 +
								(coords_gt_bif[i][1] - node_centers[j][1])**2 +
								(coords_gt_bif[i][2] - node_centers[j][0])**2))
		node_id.append(dist.index(min(dist)))
		#print("Fid: F-%d, dist: %f, bif_id: %d" %(i+1, dist[dist.index(min(dist))], dist.index(min(dist))))

	return(node_id)

#########################################################################################################
def Skeletonization(stack):
	z,y,x = stack.shape
	#print('image size : (x,y,z) = (%d,%d,%d)' %(x,y,z))
	#np.save('stack.npy', stack)
	""" """
	t=3
	stack[0:t,0:t,0:t]       = 1
	stack[0:t,0:t,x-t:x]     = 1
	stack[0:t,y-t:y,x-t:x]   = 1
	stack[0:t,y-t:y,0:t]     = 1
	stack[z-t:z,0:t,0:t]     = 1
	stack[z-t:z,0:t,x-t:x]   = 1
	stack[z-t:z,y-t:y,x-t:x] = 1
	stack[z-t:z,y-t:y,0:t]   = 1
	#sitk.WriteImage(sitk.GetImageFromArray(np.uint8(stack*255)), 'Temp.nrrd')
	""" """

	"""
	skels = kimimaro.skeletonize(
		stack,
		teasar_params={
			'scale': 2, #4,
			'const': 1, #500, # physical units
			'pdrf_exponent': 4,
			'pdrf_scale': 100000,
			'soma_detection_threshold': 1100, # physical units
			'soma_acceptance_threshold': 3500, # physical units
			'soma_invalidation_scale': 1.0,
			'soma_invalidation_const': 300, # physical units
			'max_paths': None, # default None
		},
		# object_ids=[ ... ], # process only the specified labels
		# extra_targets_before=[ (27,33,100), (44,45,46) ], # target points in voxels
		# extra_targets_after=[ (27,33,100), (44,45,46) ], # target points in voxels
		dust_threshold=10, #1000, # skip connected components with fewer than this many voxels
		anisotropy=(40,40,40), # (32,32,32), #(16,16,40), # default True
		fix_branching=True, # default True
		fix_borders=True, # default True
		fill_holes=True, # default False
		fix_avocados=True, #False, # default False
		progress=False, # default False, show progress bar
		parallel=4, # <= 0 all cpu, 1 single process, 2+ multiprocess
		parallel_chunk_size=100, # how many skeletons to process before updating progress bar
	)
	"""

	skels = kimimaro.skeletonize(
		stack,
		teasar_params={
			'scale': 2, #4,
			'const': 1, #500,  # physical units
			'pdrf_exponent': 4,
			'pdrf_scale': 100000,
			'soma_detection_threshold': 1100,  # physical units
			'soma_acceptance_threshold': 3500,  # physical units
			'soma_invalidation_scale': 1.0,
			'soma_invalidation_const': 300,  # physical units
			'max_paths': None,  # default None
		},
		# object_ids=[ ... ], # process only the specified labels
		dust_threshold=10,
		anisotropy=(40, 40, 40),  # default True
		fix_branching=True,  # default True
		fix_borders=True,  # default True
		#fill_holes=True, # default False
		#fix_avocados=True, #False, # default False
		progress=True,  # default False
		parallel=1,  # <= 0 all cpu, 1 single process, 2+ multiprocess
		parallel_chunk_size=100,  # how many skeletons to process before updating progress bar
	)

	##---------------------------------------------##
	for label, skel in skels.items():
		fname = 'skeleton.swc'
		with open(fname, 'wt') as f:
			f.write(skel.to_swc())


	##---------------------------------------------##
	"""
	with open(fname, "rt") as swc:
		skel = Skeleton.from_swc(swc.read())

	skel.viewer()
	"""

	##---------------------------------------------##
	S = np.loadtxt('skeleton.swc')
	X = S[:,4]
	Y = S[:,3]
	Z = S[:,2]
	maxX = X.max()
	maxY = Y.max()
	maxZ = Z.max()

	M = np.zeros((z,y,x))

	Xn = ((X*(x-1))/maxX).astype(int)
	Yn = ((Y*(y-1))/maxY).astype(int)
	Zn = ((Z*(z-1))/maxZ).astype(int)
	kern = np.ones((3,3),np.uint8)


	for i in range(len(S)):
		M[Zn[i], Yn[i], Xn[i]] = 1

	M[0:t,0:t,0:t]       = 0
	M[0:t,0:t,x-t:x]     = 0
	M[0:t,y-t:y,x-t:x]   = 0
	M[0:t,y-t:y,0:t]     = 0
	M[z-t:z,0:t,0:t]     = 0
	M[z-t:z,0:t,x-t:x]   = 0
	M[z-t:z,y-t:y,x-t:x] = 0
	M[z-t:z,y-t:y,0:t]   = 0

	#M = ndimage.binary_dilation(M).astype(M.dtype)

	return(M)

