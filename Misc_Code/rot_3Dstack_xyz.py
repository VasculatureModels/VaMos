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

import numpy as np
import SimpleITK as sitk
import matplotlib.pyplot as plt
import os, sys



"""
        z
       /
      /
     /
    /
    ---------- x
    |
    |
    |
    |
    y

"""




# This function is from https://github.com/rock-learning/pytransform3d/blob/7589e083a50597a75b12d745ebacaa7cc056cfbd/pytransform3d/rotations.py#L302
def matrix_from_axis_angle(a):
    """ Compute rotation matrix from axis-angle.
    This is called exponential map or Rodrigues' formula.
    Parameters
    ----------
    a : array-like, shape (4,)
        Axis of rotation and rotation angle: (x, y, z, angle)
    Returns
    -------
    R : array-like, shape (3, 3)
        Rotation matrix
    """
    ux, uy, uz, theta = a
    c = np.cos(theta)
    s = np.sin(theta)
    ci = 1.0 - c
    R = np.array([[ci * ux * ux + c,
                   ci * ux * uy - uz * s,
                   ci * ux * uz + uy * s],
                  [ci * uy * ux + uz * s,
                   ci * uy * uy + c,
                   ci * uy * uz - ux * s],
                  [ci * uz * ux - uy * s,
                   ci * uz * uy + ux * s,
                   ci * uz * uz + c],
                  ])

    # This is equivalent to
    # R = (np.eye(3) * np.cos(theta) +
    #      (1.0 - np.cos(theta)) * a[:3, np.newaxis].dot(a[np.newaxis, :3]) +
    #      cross_product_matrix(a[:3]) * np.sin(theta))

    return R


def resample(image, transform):
    """
    This function resamples (updates) an image using a specified transform
    :param image: The sitk image we are trying to transform
    :param transform: An sitk transform (ex. resizing, rotation, etc.
    :return: The transformed sitk image
    """
    reference_image = image
    interpolator = sitk.sitkLinear
    default_value = 0
    return sitk.Resample(image, reference_image, transform,
                         interpolator, default_value)


def get_center(img):
    """
    This function returns the physical center point of a 3d sitk image
    :param img: The sitk image we are trying to find the center of
    :return: The physical center point of the image
    """
    width, height, depth = img.GetSize()
    return img.TransformIndexToPhysicalPoint((int(np.ceil(width/2)),
                                              int(np.ceil(height/2)),
                                              int(np.ceil(depth/2))))


def rotation3d_z(image, theta_z):
    """
    This function rotates an image across each of the x, y, z axes by theta_x, theta_y, and theta_z degrees
    respectively
    :param image: An sitk MRI image
    :param theta_x: The amount of degrees the user wants the image rotated around the x axis
    :param theta_y: The amount of degrees the user wants the image rotated around the y axis
    :param theta_z: The amount of degrees the user wants the image rotated around the z axis
    :param show: Boolean, whether or not the user wants to see the result of the rotation
    :return: The rotated image
    """
    theta_z = np.deg2rad(theta_z)
    euler_transform = sitk.Euler3DTransform()
    #print(euler_transform.GetMatrix())
    image_center = get_center(image)
    euler_transform.SetCenter(image_center)

    direction = image.GetDirection()
    axis_angle = (direction[2], direction[5], direction[8], theta_z)
    np_rot_mat = matrix_from_axis_angle(axis_angle)
    euler_transform.SetMatrix(np_rot_mat.flatten().tolist())
    resampled_image = resample(image, euler_transform)

    return resampled_image

def rotation3d_y(image, theta_y):
    """
    This function rotates an image across each of the x, y, z axes by theta_x, theta_y, and theta_z degrees
    respectively
    :param image: An sitk MRI image
    :param theta_x: The amount of degrees the user wants the image rotated around the x axis
    :param theta_y: The amount of degrees the user wants the image rotated around the y axis
    :param theta_z: The amount of degrees the user wants the image rotated around the z axis
    :param show: Boolean, whether or not the user wants to see the result of the rotation
    :return: The rotated image
    """
    theta_y = np.deg2rad(theta_y)
    euler_transform = sitk.Euler3DTransform()
    #print(euler_transform.GetMatrix())
    image_center = get_center(image)
    euler_transform.SetCenter(image_center)

    direction = image.GetDirection()
    axis_angle = (direction[1], direction[4], direction[7], theta_y)
    np_rot_mat = matrix_from_axis_angle(axis_angle)
    euler_transform.SetMatrix(np_rot_mat.flatten().tolist())
    resampled_image = resample(image, euler_transform)

    return resampled_image

def rotation3d_x(image, theta_x):
    """
    This function rotates an image across each of the x, y, z axes by theta_x, theta_y, and theta_z degrees
    respectively
    :param image: An sitk MRI image
    :param theta_x: The amount of degrees the user wants the image rotated around the x axis
    :param theta_y: The amount of degrees the user wants the image rotated around the y axis
    :param theta_z: The amount of degrees the user wants the image rotated around the z axis
    :param show: Boolean, whether or not the user wants to see the result of the rotation
    :return: The rotated image
    """
    theta_x = np.deg2rad(theta_x)
    euler_transform = sitk.Euler3DTransform()
    #print(euler_transform.GetMatrix())
    image_center = get_center(image)
    euler_transform.SetCenter(image_center)

    direction = image.GetDirection()
    axis_angle = (direction[0], direction[3], direction[6], theta_x)
    np_rot_mat = matrix_from_axis_angle(axis_angle)
    euler_transform.SetMatrix(np_rot_mat.flatten().tolist())
    resampled_image = resample(image, euler_transform)

    return resampled_image


def rotation3d_bis(image, theta_x, theta_y, theta_z):
  """
  This function rotates an image across each of the x, y, z axes by theta_x, theta_y, and theta_z degrees
  respectively
  :param image: An sitk MRI image
  :param theta_x: The amount of degrees the user wants the image rotated around the x axis
  :param theta_y: The amount of degrees the user wants the image rotated around the y axis
  :param theta_z: The amount of degrees the user wants the image rotated around the z axis
  :param show: Boolean, whether or not the user wants to see the result of the rotation
  :return: The rotated image
  """
  theta_x = np.deg2rad(theta_x)
  theta_y = np.deg2rad(theta_y)
  theta_z = np.deg2rad(theta_z)
  euler_transform = sitk.Euler3DTransform(get_center(image), theta_x, theta_y, theta_z, (0, 0, 0))
  image_center = get_center(image)
  euler_transform.SetCenter(image_center)
  euler_transform.SetRotation(theta_x, theta_y, theta_z)
  resampled_image = resample(image, euler_transform)

  return resampled_image



if __name__ == "__main__":

  #filename = sys.argv[1]
  #filename = "/Volumes/LaCie/TOMOSTEO/CBCT_2/Anne-Marie_B/_Volume/Anne-Marie_B.nrrd"
  #filename = "/Volumes/LaCie/TOMOSTEO/CBCT_2/Dominique_B/_Volume/Dominique_B.nrrd"
  filename = sys.argv[1]
  FileDir = os.path.dirname(os.path.abspath(filename))+'/'
  FileName = os.path.splitext(os.path.basename(filename))[0]
  FileExt = os.path.splitext(os.path.basename(filename))[1]

  img = sitk.ReadImage(filename)

  #img_arr = sitk.GetArrayFromImage(img)[0] # Represents the 0th slice, since numpy swaps the first and third axes default to sitk
  #plt.imshow(img_arr); plt.show()
  #input("Press enter to continue...")

  rotim = rotation3d_y(img, 90)
  sitk.WriteImage(rotim, "rot_90y.nrrd")

  rotim = rotation3d_z(rotim, 90)
  sitk.WriteImage(rotim, "rot_90y_90z.nrrd")

  rotim = rotation3d_z(img, 90)
  sitk.WriteImage(rotim, "rot_90z.nrrd")

  rotim = rotation3d_x(img, 90)
  sitk.WriteImage(rotim, "rot_90x.nrrd")

  rotim = rotation3d_x(img, 270)
  sitk.WriteImage(rotim, "rot_270x.nrrd")


  rotim = rotation3d_y(img, 180)
  sitk.WriteImage(rotim, "rot_180y.nrrd")

  rotim = rotation3d_z(img, 180)
  sitk.WriteImage(rotim, "rot_180z.nrrd")

  rotim = rotation3d_x(img, 180)
  sitk.WriteImage(rotim, "rot_180x.nrrd")
