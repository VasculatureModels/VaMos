#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Copyright - <--->
contributor(s) : <--->, <---> (February 2023)

<---@----.-->
<---@----.-->

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


from scipy.ndimage import zoom
from skimage.filters import threshold_multiotsu
#from skimage.filters import threshold_otsu
import random


###   Local imports :   ###
#from MyFunctions.GetGraph import *
from MyFunctions.misc_fun import *
from MyFunctions.GetBifurcDiameters import *



#########################################################################################################

def noise_model(SplineModelTOF, CropOrig, SigmStart, ZoomIn):

	ArteryAmpl = SplineModelTOF.max()

	''' Use 3D Gaussian filtering to smooth the binary bifurcation model a bit: '''
	#SplineModelTOF = gaussian_filter(SplineModelTOF, sigma=1)

	MaskSplineModelTOF = np.copy(SplineModelTOF)
	MaskSplineModelTOF[MaskSplineModelTOF > 0] = 255

	''' 
		Get the Standard Deviation of the noise superimposed onto the arteries : 
	'''
	""" 
	GLarteries = np.copy(CropOrig)
	GLarteries[SplineModelTOF == 0] = 0
	art_avg = GLarteries[np.nonzero(GLarteries)].mean()
	art_std = GLarteries[np.nonzero(GLarteries)].std()
	art_sigma_f = art_std + random.uniform(-12.0, 12.0) * art_std / 100.
	art_Noise = np.random.normal(art_avg, art_sigma_f, CropOrig.shape)
	art_sigma_G = (art_std) / (2. * (art_sigma_f) * np.sqrt(np.pi))
	art_noisy_model = gaussian_filter(art_Noise, sigma=art_sigma_G)
	"""

	'''
	 	Add a (rather) Low Frequency noise onto the arteries :
	'''
	"""
	avg = SplineModelTOF[np.nonzero(SplineModelTOF)].mean()
	Artery_noise = np.random.normal(avg, avg/10, SplineModelTOF.shape)
	SplineModelTOF_N = SplineModelTOF + Artery_noise
	SplineModelTOF_N = zoom(SplineModelTOF_N, (1.2, 1.2, 1.2))
	SplineModelTOF_N = SplineModelTOF_N[0:SplineModelTOF.shape[0], 0:SplineModelTOF.shape[1], 0:SplineModelTOF.shape[2]]
	SplineModelTOF_N[SplineModelTOF == 0] = 0
	SplineModelTOF = np.copy(SplineModelTOF_N)
	"""


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
	GrayMatter[GrayMatter != 0] = 1

	#BrightMatter = np.copy(CropOrig)					####  <- White / Gray matter & arteries
	#BrightMatter[BrightMatter <= thOtsu[0]] = 0
	#BrightMatter[BrightMatter > thOtsu[0]] = 1

	#BrighterMatter = np.copy(CropOrig)				####  <- Arteries mostly... (incl. neighborhood)
	#BrighterMatter[BrighterMatter < thOtsu[1]] = 0
	#BrighterMatter[BrighterMatter >= thOtsu[1]] = 1
	#BrighterMatter[BrighterMatter != 0] = 1

	WholeNoise = np.zeros(CropOrig.shape)
	WholeNoise[SplineModelTOF==0] = CropOrig[SplineModelTOF==0]
	StDevWholeNoise = WholeNoise[WholeNoise != 0].std()

	''' 
		Collect the averages and standard deviations within those portions :
	'''
	CropDarkMPortion = CropOrig * DarkMatter					####  <- CSF, ventricle, corpus callosum...
	AvgDarkM = CropDarkMPortion[CropDarkMPortion != 0].mean()
	#StDevDarkM = CropDarkMPortion[CropDarkMPortion != 0].std()

	CropGrayMPortion = CropOrig * GrayMatter					####  <- White / Gray matter only !
	AvgGrayM = CropGrayMPortion[CropGrayMPortion != 0].mean()
	#StDevGrayM = CropGrayMPortion[CropGrayMPortion != 0].std()

	#CropBrighterPortion = CropOrig * BrighterMatter				####  <- Arteries mostly...
	#AvgBrighter = CropBrighterPortion[CropBrighterPortion != 0].mean()
	#StDevBrigther = CropBrighterPortion[CropBrighterPortion != 0].std()

	""" Modify the noise average and standard deviation randomly within the range +/- 12% : """
	randGMu = random.uniform(-12.0, 12.0)
	mu_GM = AvgGrayM + randGMu * AvgGrayM / 100.
	randDMu = random.uniform(-12.0, 12.0)
	mu_DM = AvgDarkM + randDMu * AvgDarkM / 100.

	###DarkMatter = elasticdeform.deform_random_grid(DarkMatter, sigma=1., points=1)
	### Modify the shape of the dark matters (fluids and stuff) :
	#DarkMatter = elastic_transform(DarkMatter, DarkMatter.shape[1] * 3.0, DarkMatter.shape[1] * 0.08, DarkMatter.shape[1] * 0.08)

	''' 
		Replacing mu & sigma (Gray Matter) :
	'''
	mu = mu_GM
	randGStd = random.uniform(-12.0, 12.0)
	sigma_f = StDevWholeNoise + randGStd * StDevWholeNoise / 100.

	''' 
		Generate Grey Matter noise ('GM_noise') & 
		Dark Matter noise ('DM_noise') : 
	'''
	sigma_0 = SigmStart * sigma_f
	DM_noise = np.random.normal(mu_DM, sigma_0, SplineModelTOF.shape)
	GM_noise = np.random.normal(mu_GM, sigma_0, SplineModelTOF.shape)
	#BM_noise = np.random.normal(mu, 2.*sigma, SplineModelTOF.shape)
	#print("std(GM) : " +str(GM_noise.std()))

	"""
		Zoom into the Noise arrays in order to slightly increase their period (decrease their frequency...) :
	"""
	if (ZoomIn == 1):
		GM_noise = zoom(GM_noise, (1.2, 1.2, 1.2))
		GM_noise = GM_noise[0:CropOrig.shape[0],0:CropOrig.shape[1],0:CropOrig.shape[2]]
		DM_noise = zoom(DM_noise, (1.2, 1.2, 1.2))
		DM_noise = DM_noise[0:CropOrig.shape[0],0:CropOrig.shape[1],0:CropOrig.shape[2]]
		""" Recompute the new modified StDev : """
		sigma_0 = GM_noise.std()

	"""
		Compute the Gaussian filter's Sigma, so that after filtering we attain the target Sigma_f :
	"""
	sigma_G = sigma_0 / (2. * sigma_f * np.sqrt(np.pi))

	"""
		Combine Dark and Bright Noises :
	"""
	GM_noise[DarkMatter == 1] = DM_noise[DarkMatter == 1]

	"""
		Add up the arteries :
		(but first, add some noise onto the arteries as well)
	"""
	SplineModelTOF[SplineModelTOF > 0] = SplineModelTOF[SplineModelTOF > 0] + GM_noise[SplineModelTOF > 0]
	GM_noise[SplineModelTOF > 0] = SplineModelTOF[SplineModelTOF > 0]
	#sitk.WriteImage(sitk.GetImageFromArray(GM_noise),"~/Desktop/GM_noise.nrrd")

	'''
		Add up the arterial noise (specifically LF noise onto the arteries) : 
	'''
	#GM_noise[GLarteries > 0] = art_noisy_model[GLarteries > 0]

	''' Gaussian Filtering : '''
	noisy_model_GM = gaussian_filter(GM_noise, sigma=sigma_G)

	''' Correct a bit the smoothing...'''
	noisy_model_GM = gaussian_filter(noisy_model_GM, sigma=np.random.uniform(0.8,1.2))
	#noisy_model_GM = gaussian_filter(noisy_model_GM, sigma=0.7)

	noisy_model_GM[noisy_model_GM < 0] = 0


	return(MaskSplineModelTOF, noisy_model_GM, ArteryAmpl, mu, sigma_f)
