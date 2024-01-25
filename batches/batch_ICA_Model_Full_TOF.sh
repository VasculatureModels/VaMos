#!/bin/bash

#ComputerName=`scutil --get ComputerName | tr a-z A-Z`
ComputerName=$(echo $HOSTNAME)
#if [[ "$ComputerName" == "autrusseau.polytech.univ-nantes.prive" ]]
if [[ "$ComputerName" == "mb-odnt-10CML86.local" ]]
then
    echo 'Using Laptop'
    export path=/Users/florent/ownCloud/NeuroVascu/TOF_Dataset_Spacing_0.4/
    export pathSeg=/Users/florent/ownCloud/NeuroVascu/TOF_Dataset_Spacing_0.4/
elif [[ "$ComputerName" == "autrusseau.polytech.univ-nantes.prive" ]]
then
    echo "Using Laptop"
    export path=/Users/florent/ownCloud/NeuroVascu/TOF_Dataset_Spacing_0.4/
    export pathSeg=/Users/florent/ownCloud/NeuroVascu/TOF_Dataset_Spacing_0.4/
else
    echo "Linux (?)"
    #export path=/home/florent/Nextcloud/NeuroVascu/TOFs/50_TOFs/
    #export pathSeg=/home/florent/Nextcloud/NeuroVascu/TOFs/50_TOFs/
    export path=/media/florent/LaCie/SubjDataset/InputImages/
    export pathSeg=/media/florent/LaCie/SubjDataset/InputImages/
fi


alias python=python3.11
export strSpl=2
export SigSt=0.0


for iter in 1 2 3 4 5
    do
        #export FidNb=$(( ( RANDOM % 15 )  + 1 ))

        python model_add_ICA_Full_TOF.py -i ${path}0.nii -seg ${pathSeg}0.seg.nii -j ${path}0.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        python model_add_ICA_Full_TOF.py -i ${path}1.nii -seg ${pathSeg}1.seg.nii -j ${path}1.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        python model_add_ICA_Full_TOF.py -i ${path}3.nii -seg ${pathSeg}3.seg.nii -j ${path}3.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        python model_add_ICA_Full_TOF.py -i ${path}4.nii -seg ${pathSeg}4.seg.nii -j ${path}4.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        python model_add_ICA_Full_TOF.py -i ${path}5.nii -seg ${pathSeg}5.seg.nii -j ${path}5.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        python model_add_ICA_Full_TOF.py -i ${path}6.nii -seg ${pathSeg}6.seg.nii -j ${path}6.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        python model_add_ICA_Full_TOF.py -i ${path}7.nii -seg ${pathSeg}7.seg.nii -j ${path}7.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        python model_add_ICA_Full_TOF.py -i ${path}8.nii -seg ${pathSeg}8.seg.nii -j ${path}8.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        python model_add_ICA_Full_TOF.py -i ${path}9.nii -seg ${pathSeg}9.seg.nii -j ${path}9.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        python model_add_ICA_Full_TOF.py -i ${path}10.nii -seg ${pathSeg}10.seg.nii -j ${path}10.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        python model_add_ICA_Full_TOF.py -i ${path}11.nii -seg ${pathSeg}11.seg.nii -j ${path}11.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        python model_add_ICA_Full_TOF.py -i ${path}12.nii -seg ${pathSeg}12.seg.nii -j ${path}12.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        python model_add_ICA_Full_TOF.py -i ${path}13.nii -seg ${pathSeg}13.seg.nii -j ${path}13.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        python model_add_ICA_Full_TOF.py -i ${path}14.nii -seg ${pathSeg}14.seg.nii -j ${path}14.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        python model_add_ICA_Full_TOF.py -i ${path}15.nii -seg ${pathSeg}15.seg.nii -j ${path}15.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        python model_add_ICA_Full_TOF.py -i ${path}16.nii -seg ${pathSeg}16.seg.nii -j ${path}16.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        python model_add_ICA_Full_TOF.py -i ${path}17.nii -seg ${pathSeg}17.seg.nii -j ${path}17.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        python model_add_ICA_Full_TOF.py -i ${path}18.nii -seg ${pathSeg}18.seg.nii -j ${path}18.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        python model_add_ICA_Full_TOF.py -i ${path}19.nii -seg ${pathSeg}19.seg.nii -j ${path}19.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        python model_add_ICA_Full_TOF.py -i ${path}20.nii -seg ${pathSeg}20.seg.nii -j ${path}20.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}21.nii -seg ${pathSeg}21.seg.nii -j ${path}21.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}22.nii -seg ${pathSeg}22.seg.nii -j ${path}22.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}23.nii -seg ${pathSeg}23.seg.nii -j ${path}23.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}24.nii -seg ${pathSeg}24.seg.nii -j ${path}24.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}25.nii -seg ${pathSeg}25.seg.nii -j ${path}25.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}26.nii -seg ${pathSeg}26.seg.nii -j ${path}26.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}27.nii -seg ${pathSeg}27.seg.nii -j ${path}27.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}28.nii -seg ${pathSeg}28.seg.nii -j ${path}28.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}29.nii -seg ${pathSeg}29.seg.nii -j ${path}29.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}30.nii -seg ${pathSeg}30.seg.nii -j ${path}30.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}31.nii -seg ${pathSeg}31.seg.nii -j ${path}31.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}32.nii -seg ${pathSeg}32.seg.nii -j ${path}32.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}33.nii -seg ${pathSeg}33.seg.nii -j ${path}33.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}35.nii -seg ${pathSeg}35.seg.nii -j ${path}35.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}36.nii -seg ${pathSeg}36.seg.nii -j ${path}36.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}37.nii -seg ${pathSeg}37.seg.nii -j ${path}37.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}38.nii -seg ${pathSeg}38.seg.nii -j ${path}38.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}39.nii -seg ${pathSeg}39.seg.nii -j ${path}39.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}40.nii -seg ${pathSeg}40.seg.nii -j ${path}40.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}41.nii -seg ${pathSeg}41.seg.nii -j ${path}41.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}42.nii -seg ${pathSeg}42.seg.nii -j ${path}42.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}43.nii -seg ${pathSeg}43.seg.nii -j ${path}43.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}45.nii -seg ${pathSeg}45.seg.nii -j ${path}45.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}46.nii -seg ${pathSeg}46.seg.nii -j ${path}46.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}47.nii -seg ${pathSeg}47.seg.nii -j ${path}47.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}48.nii -seg ${pathSeg}48.seg.nii -j ${path}48.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}49.nii -seg ${pathSeg}49.seg.nii -j ${path}49.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}53.nii -seg ${pathSeg}53.seg.nii -j ${path}53.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}55.nii -seg ${pathSeg}55.seg.nii -j ${path}55.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}56.nii -seg ${pathSeg}56.seg.nii -j ${path}56.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}57.nii -seg ${pathSeg}57.seg.nii -j ${path}57.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}58.nii -seg ${pathSeg}58.seg.nii -j ${path}58.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
        #python model_add_ICA_Full_TOF.py -i ${path}59.nii -seg ${pathSeg}59.seg.nii -j ${path}59.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -f 22
    done

