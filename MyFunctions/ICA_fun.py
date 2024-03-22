#!/usr/bin/env python
# -*- coding: utf-8 -*-


import numpy as np
import SimpleITK as sitk
import pandas as pd
from mayavi import mlab
from skimage.filters import threshold_otsu

from MyFunctions.GetGraph import *
from MyFunctions.misc_fun import *
from MyFunctions.GetBifurcDiameters import *

################################################################################################################################################
def Distance_3D(pA, pB):
	distance = math.sqrt( (pA[0][0]-pB[0])**2 + (pA[0][1]-pB[1])**2 + (pA[0][2]-pB[2])**2 )
	return(distance)

################################################################################################################################################
def Distance_3D_0(pA, pB):
	distance = math.sqrt( (pA[0]-pB[0])**2 + (pA[1]-pB[1])**2 + (pA[2]-pB[2])**2 )
	return(distance)

################################################################################################################################################
def unit_vector(vector):
    return vector / np.linalg.norm(vector)

################################################################################################################################################
def angle_between(v1, v2):
    v1_u = unit_vector(v1)
    v2_u = unit_vector(v2)
    angle_rad = np.arccos(np.clip(np.dot(v1_u, v2_u), -1.0, 1.0))
    angle_deg = 180.*angle_rad/np.pi
    return angle_deg


################################################################################################################################################
def Disp3D(data):

    data = np.uint16(data.T *20.0)

    mlab.figure("3D View", bgcolor=(0.63, 0.63, 0.63), size=(600, 600))
    src = mlab.pipeline.scalar_field(data)
    src.update_image_data = True

    # Extract some inner structures: the ventricles and the inter-hemisphere
    # fibers. We define a volume of interest (VOI) that restricts the
    # iso-surfaces to the inner of the brain. We do this with the ExtractGrid
    # filter.
    ''' '''
    blur = mlab.pipeline.user_defined(src, filter='ImageGaussianSmooth')
    ''' '''
    voi = mlab.pipeline.extract_grid(blur)

    mlab.pipeline.iso_surface(voi, colormap='hot')
    mlab.show()


################################################################################################################################################
def Disp3D_2(TOF, ICA):

    TOF = np.uint16(TOF.T *20.0)
    ICA = np.uint16(ICA.T *20.0)

    mlab.figure("3D View", bgcolor=(0.63, 0.63, 0.63), size=(600, 600))
    src1 = mlab.pipeline.scalar_field(TOF)
    src2 = mlab.pipeline.scalar_field(ICA)
    src1.update_image_data = True
    src2.update_image_data = True

    # Extract some inner structures: the ventricles and the inter-hemisphere
    # fibers. We define a volume of interest (VOI) that restricts the
    # iso-surfaces to the inner of the brain. We do this with the ExtractGrid
    # filter.
    ''' 
    src1 = mlab.pipeline.user_defined(src1, filter='ImageGaussianSmooth')
    src2 = mlab.pipeline.user_defined(src2, filter='ImageGaussianSmooth')
    '''
    voi1 = mlab.pipeline.extract_grid(src1)
    voi2 = mlab.pipeline.extract_grid(src2)
    ##voi.trait_set(x_min=1, x_max=x-1, y_min=1, y_max=y-1, z_min=1, z_max=z-1)

    mlab.pipeline.iso_surface(voi1, colormap='hot')
    mlab.pipeline.iso_surface(voi2, colormap='winter')
    mlab.show()


################################################################################################################################################
def Disp3D_3(TOF, ICA, MotherArt):

    #MotherArt = np.float32(ndimage.binary_dilation(MotherArt))
    TOF = np.uint16(TOF.T *20.0)
    ICA = np.uint16(ICA.T *20.0)
    MotherArt = np.uint16(MotherArt.T *20.0)

    mlab.figure("3D View", bgcolor=(0.63, 0.63, 0.63), size=(600, 600))
    src1 = mlab.pipeline.scalar_field(TOF)
    src2 = mlab.pipeline.scalar_field(ICA)
    src3 = mlab.pipeline.scalar_field(MotherArt)
    src1.update_image_data = True
    src2.update_image_data = True
    src3.update_image_data = True

    # Extract some inner structures: the ventricles and the inter-hemisphere
    # fibers. We define a volume of interest (VOI) that restricts the
    # iso-surfaces to the inner of the brain. We do this with the ExtractGrid
    # filter.
    ''' 
    src1 = mlab.pipeline.user_defined(src1, filter='ImageGaussianSmooth')
    src2 = mlab.pipeline.user_defined(src2, filter='ImageGaussianSmooth')
    src3 = mlab.pipeline.user_defined(src3, filter='ImageGaussianSmooth')
    '''
    voi1 = mlab.pipeline.extract_grid(src1)
    voi2 = mlab.pipeline.extract_grid(src2)
    voi3 = mlab.pipeline.extract_grid(src3)
    ##voi.trait_set(x_min=1, x_max=x-1, y_min=1, y_max=y-1, z_min=1, z_max=z-1)

    mlab.pipeline.iso_surface(voi1, colormap='hot')
    mlab.pipeline.iso_surface(voi2, colormap='winter')
    mlab.pipeline.iso_surface(voi3, colormap='terrain')
    mlab.show()


################################################################################################################################################
def Embed_AIC_Bin(Coords_BranchM, Coords_BranchD1, Coords_BranchD2, BifCoords, BinCrop, radius, sigmaED, diameters, AGrowth):
	#VascuArr12, AICArr12 = Embed_AIC_Bin(Coords_Branch1, Coords_Branch2, Coords_Branch3, BifCoords, CroppedSegm, radius, sigmaED, diam_branch1, diam_branch2, diam_branch3)
	"""
	if posmax == 0:
		Coords_BranchM = Coords_Branch1
		Coords_BranchD1 = Coords_Branch2
		Coords_BranchD2 = Coords_Branch3
		BinCrop = FullStackModelNoTh  ## CroppedSegm
		radius = Radius
		sigmaED = SigmaED
	"""
	ThM  = diameters[0]
	ThD1 = diameters[1]
	ThD2 = diameters[2]

	Ths = np.asarray([ThM, ThD1, ThD2])
	MaxTh = Ths.max()
	AvgTh = Ths.mean()
	MinTh = Ths.min()
	print('Max thickness : ' + str(MaxTh))
	#print('Avg thickness : ' + str(AvgTh))
	#print('Min thickness : ' + str(MinTh))

	#BinCrop[BinCrop>0] = 1

	Sz,Sy,Sx = BinCrop.shape


	if Distance_3D(Coords_BranchM, BifCoords) < 3.:
		if len(Coords_BranchM) >= MaxTh:
			Dx1 = Coords_BranchM[MaxTh-1][2] - BifCoords[2]
			Dy1 = Coords_BranchM[MaxTh-1][1] - BifCoords[1]
			Dz1 = Coords_BranchM[MaxTh-1][0] - BifCoords[0]
		else:
			Dx1 = Coords_BranchM[len(Coords_BranchM)-1][2] - BifCoords[2]
			Dy1 = Coords_BranchM[len(Coords_BranchM)-1][1] - BifCoords[1]
			Dz1 = Coords_BranchM[len(Coords_BranchM)-1][0] - BifCoords[0]
	else:
		if len(Coords_BranchM) >= MaxTh:
			Dx1 = Coords_BranchM[len(Coords_BranchM)-MaxTh][2] - BifCoords[2]
			Dy1 = Coords_BranchM[len(Coords_BranchM)-MaxTh][1] - BifCoords[1]
			Dz1 = Coords_BranchM[len(Coords_BranchM)-MaxTh][0] - BifCoords[0]
		else:
			Dx1 = Coords_BranchM[0][2] - BifCoords[2]
			Dy1 = Coords_BranchM[0][1] - BifCoords[1]
			Dz1 = Coords_BranchM[0][0] - BifCoords[0]
	if Distance_3D(Coords_BranchD1, BifCoords) < 3.:	## <-- up to v8, the condition here was < 2. !
		if len(Coords_BranchD1) >= MaxTh:
			Dx2 = Coords_BranchD1[MaxTh-1][2] - BifCoords[2]
			Dy2 = Coords_BranchD1[MaxTh-1][1] - BifCoords[1]
			Dz2 = Coords_BranchD1[MaxTh-1][0] - BifCoords[0]
		else:
			Dx2 = Coords_BranchD1[len(Coords_BranchD1)-1][2] - BifCoords[2]
			Dy2 = Coords_BranchD1[len(Coords_BranchD1)-1][1] - BifCoords[1]
			Dz2 = Coords_BranchD1[len(Coords_BranchD1)-1][0] - BifCoords[0]
	else:
		if len(Coords_BranchD1) >= MaxTh:
			Dx2 = Coords_BranchD1[len(Coords_BranchD1)-MaxTh][2] - BifCoords[2]
			Dy2 = Coords_BranchD1[len(Coords_BranchD1)-MaxTh][1] - BifCoords[1]
			Dz2 = Coords_BranchD1[len(Coords_BranchD1)-MaxTh][0] - BifCoords[0]
		else:
			Dx2 = Coords_BranchD1[0][2] - BifCoords[2]
			Dy2 = Coords_BranchD1[0][1] - BifCoords[1]
			Dz2 = Coords_BranchD1[0][0] - BifCoords[0]
	if Distance_3D(Coords_BranchD2, BifCoords) < 3.:	## <-- up to v8, the condition here was < 2. !
		if len(Coords_BranchD2) >= MaxTh:
			Dx3 = Coords_BranchD2[MaxTh-1][2] - BifCoords[2]
			Dy3 = Coords_BranchD2[MaxTh-1][1] - BifCoords[1]
			Dz3 = Coords_BranchD2[MaxTh-1][0] - BifCoords[0]
		else:
			Dx3 = Coords_BranchD2[len(Coords_BranchD2)-1][2] - BifCoords[2]
			Dy3 = Coords_BranchD2[len(Coords_BranchD2)-1][1] - BifCoords[1]
			Dz3 = Coords_BranchD2[len(Coords_BranchD2)-1][0] - BifCoords[0]
	else:
		if len(Coords_BranchD2) >= MaxTh:
			Dx3 = Coords_BranchD2[len(Coords_BranchD2)-MaxTh][2] - BifCoords[2]
			Dy3 = Coords_BranchD2[len(Coords_BranchD2)-MaxTh][1] - BifCoords[1]
			Dz3 = Coords_BranchD2[len(Coords_BranchD2)-MaxTh][0] - BifCoords[0]
		else:
			Dx3 = Coords_BranchD2[0][2] - BifCoords[2]
			Dy3 = Coords_BranchD2[0][1] - BifCoords[1]
			Dz3 = Coords_BranchD2[0][0] - BifCoords[0]

	if Dx2 == Dy2 == Dz2 ==0:
		Dx2 = Dy2 = Dz2 = 1
	if Dx3 == Dy3 == Dz3 ==0:
		Dx3 = Dy3 = Dz3 = 1

	### 'VecSumXYZ' : bissectrice entre les branches 2 & 3 (artères filles) :
	VecSumX23 = Dx2 + Dx3
	VecSumY23 = Dy2 + Dy3
	VecSumZ23 = Dz2 + Dz3
	#VecNorm23 = np.sqrt((VecSumX23*VecSumX23)+(VecSumY23*VecSumY23)+(VecSumZ23*VecSumZ23))


	""" ### OPTION : ###
		Consider the mother artery orientation as well here !
		If the daughter arteries are not 3D-aligned (on the same 2D plane) as the mother artery,
		the ICA won't be aligned with the incoming blood flow (thus, need to add up [Dx1, Dy1, Dz1]).
		So, we subtract the vector of the mother branch from the bissector.
		Without this option, see for instance bad alignment here :
		python model_add_ICA.py -i ${path}82.nrrd -seg ${pathSeg}82.seg.nrrd -str 2 -sigst ${SigSt} -bn 46 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -d3D ${d3D}
	"""
	VecSumX23 = VecSumX23 -Dx1
	VecSumY23 = VecSumY23 -Dy1
	VecSumZ23 = VecSumZ23 -Dz1


	### On pose l'AIC sur la bissectrice ainsi calculée:
	NormVecSum = np.sqrt((VecSumX23**2)+(VecSumY23**2)+(VecSumZ23**2))

	#TargetDistance = (ThB1/2. + radius)	## <-- ICPR config !!!
	#Ratio2 = TargetDistance / NormVecSum	## <-- ICPR config !!!

	a23 = angle_between((Dx2, Dy2, Dz2), (Dx3, Dy3, Dz3))
	print('angle : ' + str(a23))

	angleRad = a23*np.pi/180.
	TargetDistance = radius * AGrowth + math.sqrt(((AvgTh/2.)/math.tan(angleRad/2.))**2 + (AvgTh/2.)**2)

	ShiftFromWall = (radius / math.sin(angleRad/2.)) - radius
	TargetDistance = TargetDistance + ShiftFromWall
	#print("TargetDistance: " + str(TargetDistance))
	#print("ShiftFromWall: " + str(ShiftFromWall))


	Ratio2 = TargetDistance / NormVecSum	## <-- ICPR config !!!
	ShiftX = int(Ratio2 * VecSumX23)
	ShiftY = int(Ratio2 * VecSumY23)
	ShiftZ = int(Ratio2 * VecSumZ23)

	AIC_pos = np.asarray(((BifCoords[0] + ShiftZ), (BifCoords[1] + ShiftY), (BifCoords[2] + ShiftX)))

	if AIC_pos[0] > Sz: AIC_pos[0] = Sz
	if AIC_pos[1] > Sy: AIC_pos[1] = Sy
	if AIC_pos[2] > Sx: AIC_pos[2] = Sx

	xa = np.float64(AIC_pos[2])
	ya = np.float64(AIC_pos[1])
	za = np.float64(AIC_pos[0])
	radius = np.float64(radius)

	zs, ys, xs = BinCrop.shape

	#AICArr = Make_Sphere(xs, ys, zs, xa, ya, za, radius, sigmaED)
	AICArr = Make_Sphere_NoED(xs, ys, zs, xa, ya, za, radius)

	#sitk.WriteImage(sitk.GetImageFromArray(AICArr), "/Users/---/Desktop/AICArr_Orig.nrrd")

	#if radius > 3:
	#	AICArrThromb = Make_Sphere(xs, ys, zs, xa, ya, za, radius/2., sigmaED)
	#	AICArr = AICArr - AICArrThromb
	#sitk.WriteImage(sitk.GetImageFromArray(AICArr), "/Users/---/Desktop/AICArr.nrrd")

	#AICArr = elasticdeform.deform_random_grid(AICArr, sigma=sigmaED, points=5)
	if sigmaED != 0:
		AICArr = elasticdeform.deform_random_grid(AICArr, sigma=sigmaED, points=3)
	else:
		if np.random.uniform(0, 1) > 0.5:    ## <--- either run three times a small elastic Deform or add up two different modelled ICAs.
			for ed in range(3):
				AICArr = elasticdeform.deform_random_grid(AICArr, sigma=sigmaED, points=3)
		else :
			## Summing two ICAs to get some bumps in the global shape :
			AICArr1 = elasticdeform.deform_random_grid(AICArr, sigma=3.0, points=3)
			AICArr2 = elasticdeform.deform_random_grid(AICArr1, sigma=3.0, points=3)
			AICArr = AICArr1 + AICArr2


	AICArr = np.abs(AICArr)
	AICArr[AICArr<0.1] = 0
	#sitk.WriteImage(sitk.GetImageFromArray(AICArr), "/Users/---/Desktop/AICArr_Deformed.nrrd")

	''' 
		Add Thrombosis within the ICA: 
	'''
	""" """
	#MaxThromb = 0.3 # or :
	MaxThromb = np.random.uniform(0.1,0.4)
	if radius >= 4 : #and AGrowth >= 0.5:
		if np.random.uniform(0, 1) > 0.3:
			AICArrE = np.copy(AICArr)
			#for idxe in range(int(radius-1)):
			#	AICArrE = np.float32(ndimage.binary_erosion(AICArrE))
			AICArrE = np.float32(ndimage.binary_erosion(AICArrE))
			AICArrE = np.float32(ndimage.binary_closing(AICArrE))
			AICArrE[AICArrE > 1] = 1.
			Thromb = gaussian_filter(AICArrE, sigma=np.random.uniform(0.8,1.5))
			Thromb = (Thromb / Thromb.max()) * MaxThromb
			Thromb = 1 - Thromb
			ShX = np.random.randint(0,radius)
			ShY = np.random.randint(0,radius)
			Thromb = np.roll(Thromb, (ShX, 0), axis=(1, 0))
			Thromb = np.roll(Thromb, (ShY, 0), axis=(0, 1))
		else:
			Thromb = np.ones(AICArr.shape)
			#sitk.WriteImage(sitk.GetImageFromArray(Thromb),"/Users/---/Desktop/Thrombosis.nrrd")
	else:
		Thromb = np.ones(AICArr.shape)
	""" """
	AICArr[AICArr < 2] = 0

	AICArr = np.float32(ndimage.binary_closing(AICArr))

	#sitk.WriteImage(sitk.GetImageFromArray(AICArr), "/Users/---/Desktop/AICArr_Before_Shift.nrrd")
	'''
		Shifting the ICA back to where it belongs within the 3D Crop ! (coordinates (xa, ya, za))
	'''
	SitkImgAIC = sitk.GetImageFromArray(AICArr)
	dist_img = sitk.SignedMaurerDistanceMap(SitkImgAIC != 0, insideIsPositive=False, squaredDistance=False, useImageSpacing=False)
	seeds = sitk.ConnectedComponent(dist_img < 0)

	shape_stats = sitk.LabelShapeStatisticsImageFilter()
	shape_stats.ComputeOrientedBoundingBoxOn()
	shape_stats.Execute(seeds)

	intensity_stats = sitk.LabelIntensityStatisticsImageFilter()
	intensity_stats.Execute(seeds, SitkImgAIC)

	Centroid = [(shape_stats.GetCentroid(i)) for i in shape_stats.GetLabels()]
	Dx_Centroid = xa - Centroid[0][0]
	Dy_Centroid = ya - Centroid[0][1]
	Dz_Centroid = za - Centroid[0][2]

	AICArr_Centered = np.copy(AICArr)
	AICArr_Centered = np.roll(AICArr_Centered, int(Dx_Centroid), axis=0)
	AICArr_Centered = np.roll(AICArr_Centered, int(Dy_Centroid), axis=1)
	AICArr_Centered = np.roll(AICArr_Centered, int(Dz_Centroid), axis=2)
	AICArr = AICArr_Centered
	#sitk.WriteImage(sitk.GetImageFromArray(AICArr), "/Users/---/Desktop/AICArr_Shifted.nrrd")


	#sitk.WriteImage(sitk.GetImageFromArray(AICArr),"/Users/---/Desktop/AICArr.nrrd")

	#### Adding AIC on top of the bifurcation : ####
	VascuArr = np.copy(BinCrop)
	CleanVascu = np.copy(BinCrop)
	VascuArr[AICArr > 0] = 1

	print('Angle :  Dx = ' + str(VecSumX23) + ',  Dy = ' + str(VecSumY23) + ',  Dz = ' + str(VecSumZ23) + '\n')

	return(np.float32(CleanVascu), np.float32(VascuArr), np.float32(AICArr), Thromb)

################################################################################################################################################
def Make_Sphere(x, y, z, x0, y0, z0, r, sED):

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
		#z_3D[i,:,:] = np.ones((y,x),dtype=np.float64)*i

	Sph_3D = np.zeros([x, y, z], dtype=np.float64)
	Sph_3D = np.power((x_3D-x0), 2) + np.power((y_3D-y0),2) + np.power((z_3D-z0), 2)

	Sph_3D[Sph_3D <= (r*r)] = 255
	Sph_3D[Sph_3D != 255] = 0

	#Crop = Sph_3D[int(z0-20):int(z0+20),int(y0-20):int(y0+20),int(x0-20):int(x0+20)]

	### distort the sphere :
	##Sph_dist = elasticdeform.deform_random_grid(Sph_3D, sigma=7, points=5, order=0)
	#Sph_dist = elasticdeform.deform_random_grid(Sph_3D, sigma=7, points=5, order=2)
	#Crop_dist = elasticdeform.deform_random_grid(Crop, sigma=5, points=3, order=0)
	#Crop_dist = elasticdeform.deform_random_grid(Crop, sigma=sED, points=3, order=0)

	Crop_dist = elasticdeform.deform_random_grid(Sph_3D, sigma=sED, points=3)

	#Sph_3D[int(z0-20):int(z0+20),int(y0-20):int(y0+20),int(x0-20):int(x0+20)] = Crop_dist
	Sph_3D = Crop_dist

	#SphB_dist = skimage.filters.gaussian(np.uint8(Sph_3D), sigma=int(r/4))
	SphB_dist = np.copy(Sph_3D)
	SphB_dist[SphB_dist<0.1] = 0

	#thresh = threshold_otsu(SphB_dist)
	#SphB_dist = SphB_dist > thresh

	return(SphB_dist)


################################################################################################################################################
def Make_Sphere_NoED(x, y, z, x0, y0, z0, r):

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
	Sph_3D = np.power((x_3D-x0), 2) + np.power((y_3D-y0),2) + np.power((z_3D-z0), 2)

	Sph_3D[Sph_3D <= (r*r)] = 255
	Sph_3D[Sph_3D != 255] = 0

	SphB_dist = np.copy(Sph_3D)
	SphB_dist[SphB_dist<0.1] = 0

	return(SphB_dist)
