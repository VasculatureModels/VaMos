#!/usr/bin/env python
# -*- coding: utf-8 -*-


import numpy as np
import argparse
import cv2
#import imutils
#import scipy.misc
import skimage.transform



def diamMinMax(image ):
    #print('hello')
    #ap = argparse.ArgumentParser()
    #ap.add_argument("-i", "--image", required=True, help="path to the image file")
    #args = vars(ap.parse_args())

    #image = cv2.imread(image1,0)    
    proj = []
    for angle in np.arange(0, 180, 1):
        #rotated = imutils.rotate_bound(image, angle)
        #rotated = scipy.misc.imrotate(image, angle, interp='nearest')
        #rotated = skimage.transform.rotate(image, angle, resize=True, center=None, order=0, mode='constant', cval=0, clip=True, preserve_range=False)
        rotated = skimage.transform.rotate(image, angle, resize=True, order=0)
        proj.append(np.sum(rotated, axis=1))
        #cv2.imshow("Rotated", rotated)
        #cv2.waitKey(0)

    lenProj = np.zeros((180))
    for i in range(len(proj)):
        p = proj[i]
        p[p>0]=1
        lenProj[i] = sum(p)

    #print('\nDiametre min : ' + str(np.uint8(min(lenProj))))
    #print('Diametre max : ' + str(np.uint8(max(lenProj))) + '\n')
    return np.uint8(min(lenProj)), np.uint8(max(lenProj))

 
