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

#import os
#import tempfile
#import numpy as np
#import pandas as pd
#import elasticdeform
#import itertools as IT
#from scipy import ndimage
#from skimage.filters import *
#from copy import deepcopy
#from scipy import interpolate
#from scipy.ndimage import zoom
#from mpl_toolkits.mplot3d import Axes3D
#from scipy.ndimage import gaussian_filter
#from skimage.morphology import skeletonize_3d
#import sknw
#import SimpleITK as sitk
#import math
import random


###   Local imports :   ###
from MyFunctions.GetGraph import *
from MyFunctions.misc_fun import *
from MyFunctions.GetBifurcDiameters import *


#########################################################################################################

def ICA_noise_generator(SplineModelTOF, CropOrig):

	#SplineFitTOF = SplineFitTOF + ((random.uniform(-10.0, 10.0) * SplineFitTOF) / 100)
	SplineModelTOF = SplineModelTOF + ((random.uniform(-10.0, 10.0) * SplineModelTOF) / 100)
	ArteryAmpl = SplineModelTOF.max()

	MaskSplineModelTOF = np.copy(SplineModelTOF)
	MaskSplineModelTOF[MaskSplineModelTOF > 0] = 255

	'''
		Detect the bright / dark areas within the 3D crop &
		create binary masks accordingly :
	'''
	thOtsu = threshold_multiotsu(CropOrig, classes=4)

	DarkMatter = np.copy(CropOrig)					####  <- CSF, ventricle, corpus callosum...
	DarkMatter[DarkMatter < thOtsu[0]] = 1
	DarkMatter[DarkMatter >= thOtsu[0]] = 0

	GrayMatter = np.copy(CropOrig)					####  <- White / Gray matter only !
	GrayMatter[GrayMatter < thOtsu[0]] = 0
	GrayMatter[GrayMatter >= thOtsu[1]] = 0
	GrayMatter[GrayMatter !=0] = 1

	BrightMatter = np.copy(CropOrig)					####  <- White / Gray matter & arteries
	BrightMatter[BrightMatter <= thOtsu[0]] = 0
	BrightMatter[BrightMatter > thOtsu[0]] = 1

	BrighterMatter = np.copy(CropOrig)				####  <- Arteries mostly... (incl. neighborhood)
	BrighterMatter[BrighterMatter < thOtsu[1]] = 0
	BrighterMatter[BrighterMatter >= thOtsu[1]] = 1
	#BrighterMatter[BrighterMatter != 0] = 1

	#sitk.WriteImage(sitk.GetImageFromArray(np.float32(DarkMatter)), "/Users/florent/Desktop/DarkMatter.nrrd")
	#sitk.WriteImage(sitk.GetImageFromArray(np.float32(GrayMatter)), "/Users/florent/Desktop/GrayMatter.nrrd")
	#sitk.WriteImage(sitk.GetImageFromArray(np.float32(BrightMatter)), "/Users/florent/Desktop/BrightMatter.nrrd")
	#sitk.WriteImage(sitk.GetImageFromArray(np.float32(BrighterMatter)), "/Users/florent/Desktop/BrighterMatter.nrrd")

	'''
		Collect the averages and standard deviations within those portions :
	'''

	CropDarkMPortion = CropOrig * DarkMatter					####  <- CSF, ventricle, corpus callosum...
	AvgDarkM = CropDarkMPortion[CropDarkMPortion != 0].mean()
	StDevDarkM = CropDarkMPortion[CropDarkMPortion != 0].std()

	CropGrayMPortion = CropOrig * GrayMatter					####  <- White / Gray matter only !
	AvgGrayM = CropGrayMPortion[CropGrayMPortion != 0].mean()
	StDevGrayM = CropGrayMPortion[CropGrayMPortion != 0].std()

	CropBrighterPortion = CropOrig * BrighterMatter				####  <- Arteries mostly...
	AvgBrighter = CropBrighterPortion[CropBrighterPortion != 0].mean()
	StDevBrigther = CropBrighterPortion[CropBrighterPortion != 0].std()


	randGMu = random.uniform(-12.0, 12.0)
	mu_GM = AvgGrayM + randGMu * AvgGrayM / 100.
	randDMu = random.uniform(-12.0, 12.0)
	mu_DM = AvgDarkM + randDMu * AvgDarkM / 100.

	#DarkMatter = elasticdeform.deform_random_grid(DarkMatter, sigma=1., points=2)
	DarkMatter = elastic_transform(DarkMatter, DarkMatter.shape[1] * 2.0, DarkMatter.shape[1] * 0.08, DarkMatter.shape[1] * 0.08)

	'''
		Replacing mu & sigma (Gray Matter) :
	'''
	mu = mu_GM
	randGStd = random.uniform(-12.0, 12.0)
	sigma = StDevGrayM + randGStd * StDevGrayM / 100.
	# Simpler alternative... :
	#mu_DM = (2.*mu)/3.

	#ArteryAmpl = AvgBrighter - mu_GM


	'''
		Generate grey Matter Noise ('GM_noise') &
		Dark matter Noise ('DM_Noise') :
	'''
	sigma_0 = 2. * sigma
	sigma_f = 1. * sigma # (testé avec 0.9 * sigma pour atténuer un peu les fréquences du bruit de fond...)
	DM_noise = np.random.normal(mu_DM, sigma_f, SplineModelTOF.shape)
	GM_noise = np.random.normal(mu_GM, sigma_f, SplineModelTOF.shape)
	#BM_noise = np.random.normal(mu, 2.*sigma, SplineModelTOF.shape)
	#print("std(GM) : " +str(GM_noise.std()))

	"""
		Zoom into the Noise arrays in order to slightly increase their period (decrease their frequency...) :
	"""
	'''
	GM_noise = zoom(GM_noise, (1.5, 1.5, 1.5))
	GM_noise = GM_noise[0:CropOrig.shape[0],0:CropOrig.shape[1],0:CropOrig.shape[2]]
	DM_noise = zoom(DM_noise, (1.5, 1.5, 1.5))
	DM_noise = DM_noise[0:CropOrig.shape[0],0:CropOrig.shape[1],0:CropOrig.shape[2]]
	'''
	#print("std(GM) : " +str(GM_noise.std()))
	sigma_f = GM_noise.std()


	"""
		Compute the Gaussian filter's Sigma, so that after filtering we attain the target Sigma_f :
	"""
	#sigma_G = 2. * sigma / (sigma * 1.5 * np.sqrt(np.pi))
	sigma_G = sigma_0 / (2. * sigma_f * np.sqrt(np.pi))

	"""
		Combine Dark and Bright Noises (and slightly filter the result) :
	"""
	#SplineModelTOF_N[DarkMatter == 1] = DM_noise[DarkMatter == 1] # <--- !
	GM_noise[DarkMatter == 1] = DM_noise[DarkMatter == 1]
	"""
		Add up the arteries :
	"""
	GM_noise[SplineModelTOF > 0] = SplineModelTOF[SplineModelTOF > 0]
	GM_noise = gaussian_filter(GM_noise, sigma=0.12)


	"""
		Zoom into the Noise arrays in order to slightly increase their period (decrease their frequency...) :
	"""
	#GM_noise = zoom(GM_noise, (1.5, 1.5, 1.5))
	#GM_noise = GM_noise[0:CropOrig.shape[0],0:CropOrig.shape[1],0:CropOrig.shape[2]]
	#print("std(GM) : " +str(GM_noise.std()))

	''' Gaussian Filtering : '''
	noisy_model_GM = gaussian_filter(GM_noise, sigma=sigma_G)
	#noisy_model_GM = gaussian_filter(noisy_model_GM, sigma=0.88)
	noisy_model_GM[noisy_model_GM < 0] = 0


	return(MaskSplineModelTOF, noisy_model_GM, ArteryAmpl, mu, sigma)
