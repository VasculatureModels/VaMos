
### https://medium.com/vitrox-publication/rotation-of-voxels-in-3d-space-using-python-c3b2fc0afda1

import numpy as np
import SimpleITK as sitk
from scipy.interpolate import RegularGridInterpolator


def getRodriguesMatrix(axis, theta):
    v_length = np.linalg.norm(axis)
    if v_length==0:
        raise ValueError("length of rotation axis cannot be zero.")
    if theta==0.0:
        print('\nWarning: rotation of 0 degrees !\n'); sys.exit(0)
    v = np.array(axis) / v_length
    # rodrigues rotation matrix
    W = np.array([[0, -v[2], v[1]],
                     [v[2], 0, -v[0]],
                     [-v[1], v[0], 0]])
    rot3d_mat = np.identity(3) + W * np.sin(theta) + np.dot(W, W) * (1.0 - np.cos(theta))
    return rot3d_mat


def rot_3d(image, x_center, y_center, z_center, axis, theta):

	transform_matrix = getRodriguesMatrix(axis, theta)

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

	data_w_coor = RegularGridInterpolator((z, y, x), image, method="nearest") # "linear", "nearest", "slinear", "cubic", "quintic" or "pchip" 
	interp_points = np.array([zz_prime[z_valid_idx, y_valid_idx, x_valid_idx],
                yy_prime[z_valid_idx, y_valid_idx, x_valid_idx],
                xx_prime[z_valid_idx, y_valid_idx, x_valid_idx]]).T
	interp_result = data_w_coor(interp_points)
	image_transformed[z_valid_idx, y_valid_idx, x_valid_idx] = interp_result

	return(image_transformed)



image = sitk.GetArrayFromImage(sitk.ReadImage("/Users/---/ownCloud/NeuroVascu/TOF_Dataset_Spacing_0.4/_ICA_Model/7_Bif=5_Spl=2_R=4_Sed=2.0_AGr=1.0_ICA_Label.nrrd"))
x_center = image.shape[0]/2
y_center = image.shape[1]/2
z_center = image.shape[2]/2
axis = (0.05,0.05,0.05) ### --> (x,y,z)
theta = np.pi/4
#axis = (np.random.uniform(0, 1), np.random.uniform(0, 1), np.random.uniform(0, 1))
#theta = np.random.uniform(0,np.pi/4)

rot_img = rot_3d(image, x_center, y_center, z_center, axis, theta)

sitk.WriteImage(sitk.GetImageFromArray(rot_img), "/Users/---/Desktop/Rotated.nrrd")
