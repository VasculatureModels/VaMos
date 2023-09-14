#!/bin/bash


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
    export path=/Users/----/Desktop/New_dataset_Spacing_0.4/tofs/
    export pathSeg=/Users/----/Desktop/New_dataset_Spacing_0.4/tofs/
else
    echo "Linux (?)"
    export path=/home/data/Datasets/CNN_Bif_DataSet_ManualSegm/
    export pathSeg=/home/data/Datasets/CNN_Bif_DataSet_ManualSegm/
fi

# Tests : 
#export path=/Users/----/Nextcloud/NeuroVascu/TOFs/CNN_Dataset/Quelques_TOFs_pour_tests/
# TOFs 1, 3, 4, 5, 8, 12

alias python=python3.9
export SigSt=3
#export strSpl=2

for i in {1..25}
  do
    #for strSpl in 2 3 4 5 6
    for strSpl in 2
      do
        python model_rand_point_skel.py -i ${path}0.nii -seg ${pathSeg}0.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}1.nii -seg ${pathSeg}1.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}3.nii -seg ${pathSeg}3.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}4.nii -seg ${pathSeg}4.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}5.nii -seg ${pathSeg}5.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}6.nii -seg ${pathSeg}6.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}7.nii -seg ${pathSeg}7.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}8.nii -seg ${pathSeg}8.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}9.nii -seg ${pathSeg}9.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}10.nii -seg ${pathSeg}10.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}11.nii -seg ${pathSeg}11.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}12.nii -seg ${pathSeg}12.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}13.nii -seg ${pathSeg}13.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}14.nii -seg ${pathSeg}14.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}15.nii -seg ${pathSeg}15.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}16.nii -seg ${pathSeg}16.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}17.nii -seg ${pathSeg}17.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}18.nii -seg ${pathSeg}18.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}19.nii -seg ${pathSeg}19.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}20.nii -seg ${pathSeg}20.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}21.nii -seg ${pathSeg}21.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}22.nii -seg ${pathSeg}22.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}23.nii -seg ${pathSeg}23.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}24.nii -seg ${pathSeg}24.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}25.nii -seg ${pathSeg}25.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}26.nii -seg ${pathSeg}26.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}27.nii -seg ${pathSeg}27.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}28.nii -seg ${pathSeg}28.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}29.nii -seg ${pathSeg}29.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}30.nii -seg ${pathSeg}30.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}31.nii -seg ${pathSeg}31.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}32.nii -seg ${pathSeg}32.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}33.nii -seg ${pathSeg}33.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}35.nii -seg ${pathSeg}35.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}36.nii -seg ${pathSeg}36.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        #python model_rand_point_skel.py -i ${path}37.nii -seg ${pathSeg}37.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}38.nii -seg ${pathSeg}38.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}39.nii -seg ${pathSeg}39.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}40.nii -seg ${pathSeg}40.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}41.nii -seg ${pathSeg}41.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}42.nii -seg ${pathSeg}42.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}43.nii -seg ${pathSeg}43.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}45.nii -seg ${pathSeg}45.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}46.nii -seg ${pathSeg}46.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}47.nii -seg ${pathSeg}47.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}48.nii -seg ${pathSeg}48.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}49.nii -seg ${pathSeg}49.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}53.nii -seg ${pathSeg}53.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}55.nii -seg ${pathSeg}55.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}56.nii -seg ${pathSeg}56.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}57.nii -seg ${pathSeg}57.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}58.nii -seg ${pathSeg}58.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}59.nii -seg ${pathSeg}59.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}60.nii -seg ${pathSeg}60.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}61.nii -seg ${pathSeg}61.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}62.nii -seg ${pathSeg}62.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}63.nii -seg ${pathSeg}63.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}64.nii -seg ${pathSeg}64.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}65.nii -seg ${pathSeg}65.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}66.nii -seg ${pathSeg}66.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}67.nii -seg ${pathSeg}67.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}68.nii -seg ${pathSeg}68.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}69.nii -seg ${pathSeg}69.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}70.nii -seg ${pathSeg}70.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}71.nii -seg ${pathSeg}71.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}73.nii -seg ${pathSeg}73.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}74.nii -seg ${pathSeg}74.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}75.nii -seg ${pathSeg}75.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}76.nii -seg ${pathSeg}76.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}77.nii -seg ${pathSeg}77.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}79.nii -seg ${pathSeg}79.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}80.nii -seg ${pathSeg}80.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}81.nii -seg ${pathSeg}81.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}83.nii -seg ${pathSeg}83.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}85.nii -seg ${pathSeg}85.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}86.nii -seg ${pathSeg}86.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}100.nii -seg ${pathSeg}100.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}101.nii -seg ${pathSeg}101.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}102.nii -seg ${pathSeg}102.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}103.nii -seg ${pathSeg}103.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}104.nii -seg ${pathSeg}104.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}105.nii -seg ${pathSeg}105.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}106.nii -seg ${pathSeg}106.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}107.nii -seg ${pathSeg}107.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}108.nii -seg ${pathSeg}108.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}109.nii -seg ${pathSeg}109.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}110.nii -seg ${pathSeg}110.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}111.nii -seg ${pathSeg}111.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}112.nii -seg ${pathSeg}112.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}113.nii -seg ${pathSeg}113.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}114.nii -seg ${pathSeg}114.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}115.nii -seg ${pathSeg}115.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}116.nii -seg ${pathSeg}116.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}117.nii -seg ${pathSeg}117.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}118.nii -seg ${pathSeg}118.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}119.nii -seg ${pathSeg}119.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}120.nii -seg ${pathSeg}120.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}121.nii -seg ${pathSeg}121.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}122.nii -seg ${pathSeg}122.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}123.nii -seg ${pathSeg}123.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}124.nii -seg ${pathSeg}124.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}125.nii -seg ${pathSeg}125.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}126.nii -seg ${pathSeg}126.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}127.nii -seg ${pathSeg}127.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}128.nii -seg ${pathSeg}128.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}129.nii -seg ${pathSeg}129.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}130.nii -seg ${pathSeg}130.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}131.nii -seg ${pathSeg}131.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}132.nii -seg ${pathSeg}132.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}133.nii -seg ${pathSeg}133.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}134.nii -seg ${pathSeg}134.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}135.nii -seg ${pathSeg}135.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}136.nii -seg ${pathSeg}136.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}137.nii -seg ${pathSeg}137.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}138.nii -seg ${pathSeg}138.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}139.nii -seg ${pathSeg}139.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}140.nii -seg ${pathSeg}140.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}141.nii -seg ${pathSeg}141.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}142.nii -seg ${pathSeg}142.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}143.nii -seg ${pathSeg}143.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}144.nii -seg ${pathSeg}144.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}145.nii -seg ${pathSeg}145.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}146.nii -seg ${pathSeg}146.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}147.nii -seg ${pathSeg}147.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}149.nii -seg ${pathSeg}149.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}150.nii -seg ${pathSeg}150.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}151.nii -seg ${pathSeg}151.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}152.nii -seg ${pathSeg}152.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}153.nii -seg ${pathSeg}153.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}154.nii -seg ${pathSeg}154.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}155.nii -seg ${pathSeg}155.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}156.nii -seg ${pathSeg}156.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}158.nii -seg ${pathSeg}158.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}159.nii -seg ${pathSeg}159.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}160.nii -seg ${pathSeg}160.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}161.nii -seg ${pathSeg}161.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}162.nii -seg ${pathSeg}162.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}163.nii -seg ${pathSeg}163.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}164.nii -seg ${pathSeg}164.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}165.nii -seg ${pathSeg}165.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}166.nii -seg ${pathSeg}166.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}167.nii -seg ${pathSeg}167.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}169.nii -seg ${pathSeg}169.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}170.nii -seg ${pathSeg}170.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}171.nii -seg ${pathSeg}171.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}172.nii -seg ${pathSeg}172.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}174.nii -seg ${pathSeg}174.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        python model_rand_point_skel.py -i ${path}175.nii -seg ${pathSeg}175.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
        #python model_rand_point_skel.py -i ${path}176.nii -seg ${pathSeg}176.seg.nii -str ${strSpl} -sigst ${SigSt} -cs 64
      done
  done
