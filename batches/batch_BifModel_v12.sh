#!/bin/bash

###### LAUNCHED ON SEPT 22TH at 7:30 AM ######

#ComputerName=`scutil --get ComputerName | tr a-z A-Z`
ComputerName=$(echo $HOSTNAME)
if [[ "$ComputerName" == "<---->.local" ]]
then
    echo 'Using Laptop'
    export path=/Volumes/LaCie/NeuroVascu/New_dataset_Spacing_0.4/tofs/
    export pathSeg=/Volumes/LaCie/NeuroVascu/New_dataset_Spacing_0.4/tofs/
elif [[ "$ComputerName" == "<---->" ]]
then
    echo "Using MacPro"
    export path=/Users/----/Desktop/CNN_Bif_DataSet_ManualSegm/
    export pathSeg=/Users/----/Desktop/CNN_Bif_DataSet_ManualSegm/
else
    echo "Linux (?)"
    export path=/home/data/Datasets/New_dataset_Spacing_0.4/tofs/
    export pathSeg=/home/data/Datasets/New_dataset_Spacing_0.4/tofs/
fi

alias python=python3.9
export SigSt=4
#export strSpl=2

for i in 1 2 3 4 5 6 7 8 9 10
  do
    #for strSpl in 10 12 14 16
    for strSpl in 3 6 9 12
      do

        python3.9 model_bifurcation_fid_json.py -i ${path}0.nii -seg ${pathSeg}0.seg.nii -j ${path}0.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}1.nii -seg ${pathSeg}1.seg.nii -j ${path}1.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}3.nii -seg ${pathSeg}3.seg.nii -j ${path}3.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32 # <- ICA
        python3.9 model_bifurcation_fid_json.py -i ${path}4.nii -seg ${pathSeg}4.seg.nii -j ${path}4.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}5.nii -seg ${pathSeg}5.seg.nii -j ${path}5.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}6.nii -seg ${pathSeg}6.seg.nii -j ${path}6.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}7.nii -seg ${pathSeg}7.seg.nii -j ${path}7.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}8.nii -seg ${pathSeg}8.seg.nii -j ${path}8.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}9.nii -seg ${pathSeg}9.seg.nii -j ${path}9.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}10.nii -seg ${pathSeg}10.seg.nii -j ${path}10.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}11.nii -seg ${pathSeg}11.seg.nii -j ${path}11.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}12.nii -seg ${pathSeg}12.seg.nii -j ${path}12.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}13.nii -seg ${pathSeg}13.seg.nii -j ${path}13.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}14.nii -seg ${pathSeg}14.seg.nii -j ${path}14.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}15.nii -seg ${pathSeg}15.seg.nii -j ${path}15.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}16.nii -seg ${pathSeg}16.seg.nii -j ${path}16.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}17.nii -seg ${pathSeg}17.seg.nii -j ${path}17.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}18.nii -seg ${pathSeg}18.seg.nii -j ${path}18.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}19.nii -seg ${pathSeg}19.seg.nii -j ${path}19.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}20.nii -seg ${pathSeg}20.seg.nii -j ${path}20.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}21.nii -seg ${pathSeg}21.seg.nii -j ${path}21.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}22.nii -seg ${pathSeg}22.seg.nii -j ${path}22.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}23.nii -seg ${pathSeg}23.seg.nii -j ${path}23.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}24.nii -seg ${pathSeg}24.seg.nii -j ${path}24.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}25.nii -seg ${pathSeg}25.seg.nii -j ${path}25.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}26.nii -seg ${pathSeg}26.seg.nii -j ${path}26.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}27.nii -seg ${pathSeg}27.seg.nii -j ${path}27.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}28.nii -seg ${pathSeg}28.seg.nii -j ${path}28.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}29.nii -seg ${pathSeg}29.seg.nii -j ${path}29.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}30.nii -seg ${pathSeg}30.seg.nii -j ${path}30.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}31.nii -seg ${pathSeg}31.seg.nii -j ${path}31.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}32.nii -seg ${pathSeg}32.seg.nii -j ${path}32.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}33.nii -seg ${pathSeg}33.seg.nii -j ${path}33.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}35.nii -seg ${pathSeg}35.seg.nii -j ${path}35.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}36.nii -seg ${pathSeg}36.seg.nii -j ${path}36.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}37.nii -seg ${pathSeg}37.seg.nii -j ${path}37.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}38.nii -seg ${pathSeg}38.seg.nii -j ${path}38.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}39.nii -seg ${pathSeg}39.seg.nii -j ${path}39.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}40.nii -seg ${pathSeg}40.seg.nii -j ${path}40.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}41.nii -seg ${pathSeg}41.seg.nii -j ${path}41.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}42.nii -seg ${pathSeg}42.seg.nii -j ${path}42.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}43.nii -seg ${pathSeg}43.seg.nii -j ${path}43.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}45.nii -seg ${pathSeg}45.seg.nii -j ${path}45.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}46.nii -seg ${pathSeg}46.seg.nii -j ${path}46.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}47.nii -seg ${pathSeg}47.seg.nii -j ${path}47.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}48.nii -seg ${pathSeg}48.seg.nii -j ${path}48.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}49.nii -seg ${pathSeg}49.seg.nii -j ${path}49.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}53.nii -seg ${pathSeg}53.seg.nii -j ${path}53.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}55.nii -seg ${pathSeg}55.seg.nii -j ${path}55.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}56.nii -seg ${pathSeg}56.seg.nii -j ${path}56.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}57.nii -seg ${pathSeg}57.seg.nii -j ${path}57.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}58.nii -seg ${pathSeg}58.seg.nii -j ${path}58.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}59.nii -seg ${pathSeg}59.seg.nii -j ${path}59.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}60.nii -seg ${pathSeg}60.seg.nii -j ${path}60.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}61.nii -seg ${pathSeg}61.seg.nii -j ${path}61.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}62.nii -seg ${pathSeg}62.seg.nii -j ${path}62.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}63.nii -seg ${pathSeg}63.seg.nii -j ${path}63.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}64.nii -seg ${pathSeg}64.seg.nii -j ${path}64.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}65.nii -seg ${pathSeg}65.seg.nii -j ${path}65.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}66.nii -seg ${pathSeg}66.seg.nii -j ${path}66.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}67.nii -seg ${pathSeg}67.seg.nii -j ${path}67.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}69.nii -seg ${pathSeg}69.seg.nii -j ${path}69.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}70.nii -seg ${pathSeg}70.seg.nii -j ${path}70.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}71.nii -seg ${pathSeg}71.seg.nii -j ${path}71.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}73.nii -seg ${pathSeg}73.seg.nii -j ${path}73.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}74.nii -seg ${pathSeg}74.seg.nii -j ${path}74.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}75.nii -seg ${pathSeg}75.seg.nii -j ${path}75.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}76.nii -seg ${pathSeg}76.seg.nii -j ${path}76.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}77.nii -seg ${pathSeg}77.seg.nii -j ${path}77.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}79.nii -seg ${pathSeg}79.seg.nii -j ${path}79.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}80.nii -seg ${pathSeg}80.seg.nii -j ${path}80.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}81.nii -seg ${pathSeg}81.seg.nii -j ${path}81.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}82.nii -seg ${pathSeg}82.seg.nii -j ${path}82.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}100.nii -seg ${pathSeg}100.seg.nii -j ${path}100.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}101.nii -seg ${pathSeg}101.seg.nii -j ${path}101.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}102.nii -seg ${pathSeg}102.seg.nii -j ${path}102.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}103.nii -seg ${pathSeg}103.seg.nii -j ${path}103.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}104.nii -seg ${pathSeg}104.seg.nii -j ${path}104.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}105.nii -seg ${pathSeg}105.seg.nii -j ${path}105.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}106.nii -seg ${pathSeg}106.seg.nii -j ${path}106.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}107.nii -seg ${pathSeg}107.seg.nii -j ${path}107.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}108.nii -seg ${pathSeg}108.seg.nii -j ${path}108.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}109.nii -seg ${pathSeg}109.seg.nii -j ${path}109.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}110.nii -seg ${pathSeg}110.seg.nii -j ${path}110.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}111.nii -seg ${pathSeg}111.seg.nii -j ${path}111.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}112.nii -seg ${pathSeg}112.seg.nii -j ${path}112.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}113.nii -seg ${pathSeg}113.seg.nii -j ${path}113.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}114.nii -seg ${pathSeg}114.seg.nii -j ${path}114.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}115.nii -seg ${pathSeg}115.seg.nii -j ${path}115.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}116.nii -seg ${pathSeg}116.seg.nii -j ${path}116.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}117.nii -seg ${pathSeg}117.seg.nii -j ${path}117.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}118.nii -seg ${pathSeg}118.seg.nii -j ${path}118.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}119.nii -seg ${pathSeg}119.seg.nii -j ${path}119.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}120.nii -seg ${pathSeg}120.seg.nii -j ${path}120.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}121.nii -seg ${pathSeg}121.seg.nii -j ${path}121.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}122.nii -seg ${pathSeg}122.seg.nii -j ${path}122.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}123.nii -seg ${pathSeg}123.seg.nii -j ${path}123.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}124.nii -seg ${pathSeg}124.seg.nii -j ${path}124.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}125.nii -seg ${pathSeg}125.seg.nii -j ${path}125.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}126.nii -seg ${pathSeg}126.seg.nii -j ${path}126.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}127.nii -seg ${pathSeg}127.seg.nii -j ${path}127.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}128.nii -seg ${pathSeg}128.seg.nii -j ${path}128.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}129.nii -seg ${pathSeg}129.seg.nii -j ${path}129.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}130.nii -seg ${pathSeg}130.seg.nii -j ${path}130.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}131.nii -seg ${pathSeg}131.seg.nii -j ${path}131.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}132.nii -seg ${pathSeg}132.seg.nii -j ${path}132.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}133.nii -seg ${pathSeg}133.seg.nii -j ${path}133.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}134.nii -seg ${pathSeg}134.seg.nii -j ${path}134.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}135.nii -seg ${pathSeg}135.seg.nii -j ${path}135.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}136.nii -seg ${pathSeg}136.seg.nii -j ${path}136.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}137.nii -seg ${pathSeg}137.seg.nii -j ${path}137.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}138.nii -seg ${pathSeg}138.seg.nii -j ${path}138.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}139.nii -seg ${pathSeg}139.seg.nii -j ${path}139.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}140.nii -seg ${pathSeg}140.seg.nii -j ${path}140.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}141.nii -seg ${pathSeg}141.seg.nii -j ${path}141.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}142.nii -seg ${pathSeg}142.seg.nii -j ${path}142.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}143.nii -seg ${pathSeg}143.seg.nii -j ${path}143.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}144.nii -seg ${pathSeg}144.seg.nii -j ${path}144.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}145.nii -seg ${pathSeg}145.seg.nii -j ${path}145.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}146.nii -seg ${pathSeg}146.seg.nii -j ${path}146.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}147.nii -seg ${pathSeg}147.seg.nii -j ${path}147.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}149.nii -seg ${pathSeg}149.seg.nii -j ${path}149.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}150.nii -seg ${pathSeg}150.seg.nii -j ${path}150.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}151.nii -seg ${pathSeg}151.seg.nii -j ${path}151.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}152.nii -seg ${pathSeg}152.seg.nii -j ${path}152.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}153.nii -seg ${pathSeg}153.seg.nii -j ${path}153.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}154.nii -seg ${pathSeg}154.seg.nii -j ${path}154.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}155.nii -seg ${pathSeg}155.seg.nii -j ${path}155.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}156.nii -seg ${pathSeg}156.seg.nii -j ${path}156.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}158.nii -seg ${pathSeg}158.seg.nii -j ${path}158.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}159.nii -seg ${pathSeg}159.seg.nii -j ${path}159.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}160.nii -seg ${pathSeg}160.seg.nii -j ${path}160.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}161.nii -seg ${pathSeg}161.seg.nii -j ${path}161.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}162.nii -seg ${pathSeg}162.seg.nii -j ${path}162.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}163.nii -seg ${pathSeg}163.seg.nii -j ${path}163.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}164.nii -seg ${pathSeg}164.seg.nii -j ${path}164.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}165.nii -seg ${pathSeg}165.seg.nii -j ${path}165.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}166.nii -seg ${pathSeg}166.seg.nii -j ${path}166.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}167.nii -seg ${pathSeg}167.seg.nii -j ${path}167.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}169.nii -seg ${pathSeg}169.seg.nii -j ${path}169.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}170.nii -seg ${pathSeg}170.seg.nii -j ${path}170.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}171.nii -seg ${pathSeg}171.seg.nii -j ${path}171.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}172.nii -seg ${pathSeg}172.seg.nii -j ${path}172.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
        python3.9 model_bifurcation_fid_json.py -i ${path}174.nii -seg ${pathSeg}174.seg.nii -j ${path}174.seg_F.mrk.json -str ${strSpl} -sigst ${SigSt} -cs 32
      done
  done
