
set_PATHS
export path=/Users/---/ownCloud/NeuroVascu/TOF_Dataset_Spacing_0.4/
export pathSeg=/Users/---/ownCloud/NeuroVascu/TOF_Dataset_Spacing_0.4/
alias python=python3.9
export SigSt=4
export radius=4
export strSpl=12
export elasticStDev=2.0
export AGrowth=1.0
export d3D=1

export path=/home/---/Bureau/images/
export pathSeg=/home/---/Bureau/images/


#################################
### Bifurcation Recognition : ###
#################################
python model_bifurcation_fid_json.py -i ${path}12.nii -seg ${pathSeg}12.seg.nii -j ${path}12.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32 -f 2 -d3D 1
python model_bifurcation_fid_json.py -i ${path}36.nii -seg ${pathSeg}36.seg.nii -j ${path}36.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32 -f 5 -d3D 1
python model_bifurcation_fid_json.py -i ${path}43.nii -seg ${pathSeg}43.seg.nii -j ${path}43.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32 -f 7 -d3D 1
python model_bifurcation_fid_json.py -i ${path}71.nii -seg ${pathSeg}71.seg.nii -j ${path}71.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32 -f 7 -d3D 1
python model_bifurcation_fid_json.py -i ${path}121.nii -seg ${pathSeg}121.seg.nii -j ${path}121.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32 -f 7 -d3D 1
python model_bifurcation_fid_json.py -i ${path}145.nii -seg ${pathSeg}145.seg.nii -j ${path}145.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32 -f 4 -d3D 1
python model_bifurcation_fid_json.py -i ${path}154.nii -seg ${pathSeg}154.seg.nii -j ${path}154.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32 -f 5 -d3D 1
python model_bifurcation_fid_json.py -i ${path}162.nii -seg ${pathSeg}162.seg.nii -j ${path}162.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32 -f 13 -d3D 1

# Results : 93% recog ! (modèle) et 92% en GT


####################################
### Vascular tree segmentation : ###
####################################
#export SigSt=3
python model_rand_point_skel.py -i ${path}14.nii -seg ${pathSeg}14.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64 -d3D 1
python model_rand_point_skel.py -i ${path}31.nii -seg ${pathSeg}31.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64 -d3D 1
python model_rand_point_skel.py -i ${path}81.nii -seg ${pathSeg}81.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64 -d3D 1
python model_rand_point_skel.py -i ${path}114.nii -seg ${pathSeg}114.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64 -d3D 1
python model_rand_point_skel.py -i ${path}127.nii -seg ${pathSeg}127.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64 -d3D 1
python model_rand_point_skel.py -i ${path}142.nii -seg ${pathSeg}142.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64 -d3D 1
python model_rand_point_skel.py -i ${path}159.nii -seg ${pathSeg}159.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64 -d3D 1
python model_rand_point_skel.py -i ${path}174.nii -seg ${pathSeg}174.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64 -d3D 1

# Results : 80 % (modèle) et 87% en GT


####################################
### Vascular tree segmentation : ###
####################################
#export radius=6
#export elasticStDev=1.0
#export AGrowth=0.7
#export path=/media/florent/LaCie/SubjDataset/InputImages/
#export pathSeg=/media/florent/LaCie/SubjDataset/InputImages/

export path=/home/florent/Bureau/images/
export pathSeg=/home/florent/Bureau/images/

python model_add_ICA_json_rand.py -i ${path}8.nii -seg ${pathSeg}8.seg.nii -j ${path}8.seg_F.mrk.json -f 1 -d3D 1
python model_add_ICA_json_rand.py -i ${path}14.nii -seg ${pathSeg}14.seg.nii -j ${path}14.seg_F.mrk.json -f 6 -d3D 1
python model_add_ICA_json_rand.py -i ${path}32.nii -seg ${pathSeg}32.seg.nii -j ${path}32.seg_F.mrk.json -f 7 -d3D 1
python model_add_ICA_json_rand.py -i ${path}43.nii -seg ${pathSeg}43.seg.nii -j ${path}43.seg_F.mrk.json -f 11 -d3D 1
python model_add_ICA_json_rand.py -i ${path}70.nii -seg ${pathSeg}70.seg.nii -j ${path}70.seg_F.mrk.json -f 5 -d3D 1
python model_add_ICA_json_rand.py -i ${path}107.nii -seg ${pathSeg}107.seg.nii -j ${path}107.seg_F.mrk.json -f 6 -d3D 1
python model_add_ICA_json_rand.py -i ${path}112.nii -seg ${pathSeg}112.seg.nii -j ${path}112.seg_F.mrk.json -f 7 -d3D 1
python model_add_ICA_json_rand.py -i ${path}134.nii -seg ${pathSeg}134.seg.nii -j ${path}134.seg_F.mrk.json -f 8 -d3D 1
python model_add_ICA_json_rand.py -i ${path}140.nii -seg ${pathSeg}140.seg.nii -j ${path}140.seg_F.mrk.json -f 6 -d3D 1
python model_add_ICA_json_rand.py -i ${path}152.nii -seg ${pathSeg}152.seg.nii -j ${path}152.seg_F.mrk.json -f 3 -d3D 1
python model_add_ICA_json_rand.py -i ${path}165.nii -seg ${pathSeg}165.seg.nii -j ${path}165.seg_F.mrk.json -f 13 -d3D 1


# Results : 87 % val - 80 % test  (modèle uniquement)

