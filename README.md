# VaMos

Vasculature Models (cerebral vascular tree modeling to feed a CNN  for its training phase)


## Description

VaMos proposes three different models :

- "model_bifurcation_fid.py"  --> models a given bifurcation (along with it's surrounding area)
- "model_rand_point_skel.py"  --> models a portion of the image (randomly looks for a 3D patch along the skeleton)
- "model_add_ICA.py"          --> models a given bifurcation and adds up an Intra-Cranial Aneurysm


## Visuals


<!---
![plot](./imgs/gt_vs_model.png =100x)

![plot](./imgs/gt_vs_model_3D.png =100x)
-->

<!---
<img src="./imgs/gt_vs_model.png" width="500">

<img src="./imgs/gt_vs_model_3D.png" width="500">

<img src="./imgs/ICA_3D.png" width="500">
-->


<div class="row">
  <div class="column">
    <img src="/imgs/gt_vs_model.png" alt="2D_model_" width="30%">
  </div>
  <div class="column">
    <img src="./imgs/gt_vs_model_3D.png" alt="3D_Model_" width="30%">
  </div>
  <div class="column">
    <img src="./imgs/ICA_3D.png" alt="3D_ICA_" width="30%">
  </div>
</div>


## Requirements

The following python packages should be installed :

- scikit-image
- opencv-python
- sknw
- networkx
- numba
- scipy
- mayavi
- SimpleITK
- raster_geometry
- kimimaro
- napari
- matplotlib
- wxpython
- pynrrd
- pydicom
- pandas
- openpyxl


## Usage

`python model_bifurcation_fid.py -i <image.nrrd> -seg <image.seg.nrrd> -str <strSpl> -bn <BifNum> -fid <ID> -cs <CropSize>`

`python model_rand_point_skel.py -i <image.mha> -seg <segmentation.mha> -str <strSpl> -cs <CropSize>`

`python model_add_ICA.py -i <image.nrrd> -seg <image.seg.nrrd> -str <strSpl> -bn <BifNum> -fid <ID> -cs <CropSize> -r <Radius> -Sed <StdDev>`



## Authors and acknowledgment
<------>


## License
"CEA CNRS INRIA logiciel libre" CeCILL version 2.1


