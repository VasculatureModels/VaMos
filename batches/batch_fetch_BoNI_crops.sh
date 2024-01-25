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

python3.9 Fetch_BoNI_crops.py -i ${path}0.nrrd -seg ${pathSeg}0.seg.nrrd -j ${path}0.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}1.nrrd -seg ${pathSeg}1.seg.nrrd -j ${path}1.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}3.nrrd -seg ${pathSeg}3.seg.nrrd -j ${path}3.seg_F.mrk.json -cs 64 # <- ICA
python3.9 Fetch_BoNI_crops.py -i ${path}4.nrrd -seg ${pathSeg}4.seg.nrrd -j ${path}4.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}5.nrrd -seg ${pathSeg}5.seg.nrrd -j ${path}5.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}6.nrrd -seg ${pathSeg}6.seg.nrrd -j ${path}6.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}7.nrrd -seg ${pathSeg}7.seg.nrrd -j ${path}7.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}8.nrrd -seg ${pathSeg}8.seg.nrrd -j ${path}8.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}9.nrrd -seg ${pathSeg}9.seg.nrrd -j ${path}9.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}10.nrrd -seg ${pathSeg}10.seg.nrrd -j ${path}10.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}11.nrrd -seg ${pathSeg}11.seg.nrrd -j ${path}11.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}12.nrrd -seg ${pathSeg}12.seg.nrrd -j ${path}12.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}13.nrrd -seg ${pathSeg}13.seg.nrrd -j ${path}13.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}14.nrrd -seg ${pathSeg}14.seg.nrrd -j ${path}14.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}15.nrrd -seg ${pathSeg}15.seg.nrrd -j ${path}15.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}16.nrrd -seg ${pathSeg}16.seg.nrrd -j ${path}16.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}17.nrrd -seg ${pathSeg}17.seg.nrrd -j ${path}17.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}18.nrrd -seg ${pathSeg}18.seg.nrrd -j ${path}18.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}19.nrrd -seg ${pathSeg}19.seg.nrrd -j ${path}19.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}20.nrrd -seg ${pathSeg}20.seg.nrrd -j ${path}20.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}21.nrrd -seg ${pathSeg}21.seg.nrrd -j ${path}21.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}22.nrrd -seg ${pathSeg}22.seg.nrrd -j ${path}22.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}23.nrrd -seg ${pathSeg}23.seg.nrrd -j ${path}23.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}24.nrrd -seg ${pathSeg}24.seg.nrrd -j ${path}24.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}25.nrrd -seg ${pathSeg}25.seg.nrrd -j ${path}25.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}26.nrrd -seg ${pathSeg}26.seg.nrrd -j ${path}26.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}27.nrrd -seg ${pathSeg}27.seg.nrrd -j ${path}27.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}28.nrrd -seg ${pathSeg}28.seg.nrrd -j ${path}28.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}29.nrrd -seg ${pathSeg}29.seg.nrrd -j ${path}29.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}30.nrrd -seg ${pathSeg}30.seg.nrrd -j ${path}30.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}31.nrrd -seg ${pathSeg}31.seg.nrrd -j ${path}31.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}32.nrrd -seg ${pathSeg}32.seg.nrrd -j ${path}32.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}33.nrrd -seg ${pathSeg}33.seg.nrrd -j ${path}33.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}35.nrrd -seg ${pathSeg}35.seg.nrrd -j ${path}35.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}36.nrrd -seg ${pathSeg}36.seg.nrrd -j ${path}36.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}37.nrrd -seg ${pathSeg}37.seg.nrrd -j ${path}37.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}38.nrrd -seg ${pathSeg}38.seg.nrrd -j ${path}38.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}39.nrrd -seg ${pathSeg}39.seg.nrrd -j ${path}39.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}40.nrrd -seg ${pathSeg}40.seg.nrrd -j ${path}40.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}41.nrrd -seg ${pathSeg}41.seg.nrrd -j ${path}41.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}42.nrrd -seg ${pathSeg}42.seg.nrrd -j ${path}42.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}43.nrrd -seg ${pathSeg}43.seg.nrrd -j ${path}43.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}45.nrrd -seg ${pathSeg}45.seg.nrrd -j ${path}45.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}46.nrrd -seg ${pathSeg}46.seg.nrrd -j ${path}46.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}47.nrrd -seg ${pathSeg}47.seg.nrrd -j ${path}47.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}48.nrrd -seg ${pathSeg}48.seg.nrrd -j ${path}48.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}49.nrrd -seg ${pathSeg}49.seg.nrrd -j ${path}49.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}53.nrrd -seg ${pathSeg}53.seg.nrrd -j ${path}53.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}55.nrrd -seg ${pathSeg}55.seg.nrrd -j ${path}55.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}56.nrrd -seg ${pathSeg}56.seg.nrrd -j ${path}56.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}57.nrrd -seg ${pathSeg}57.seg.nrrd -j ${path}57.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}58.nrrd -seg ${pathSeg}58.seg.nrrd -j ${path}58.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}59.nrrd -seg ${pathSeg}59.seg.nrrd -j ${path}59.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}60.nrrd -seg ${pathSeg}60.seg.nrrd -j ${path}60.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}61.nrrd -seg ${pathSeg}61.seg.nrrd -j ${path}61.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}62.nrrd -seg ${pathSeg}62.seg.nrrd -j ${path}62.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}63.nrrd -seg ${pathSeg}63.seg.nrrd -j ${path}63.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}64.nrrd -seg ${pathSeg}64.seg.nrrd -j ${path}64.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}65.nrrd -seg ${pathSeg}65.seg.nrrd -j ${path}65.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}66.nrrd -seg ${pathSeg}66.seg.nrrd -j ${path}66.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}67.nrrd -seg ${pathSeg}67.seg.nrrd -j ${path}67.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}69.nrrd -seg ${pathSeg}69.seg.nrrd -j ${path}69.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}70.nrrd -seg ${pathSeg}70.seg.nrrd -j ${path}70.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}71.nrrd -seg ${pathSeg}71.seg.nrrd -j ${path}71.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}73.nrrd -seg ${pathSeg}73.seg.nrrd -j ${path}73.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}74.nrrd -seg ${pathSeg}74.seg.nrrd -j ${path}74.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}75.nrrd -seg ${pathSeg}75.seg.nrrd -j ${path}75.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}76.nrrd -seg ${pathSeg}76.seg.nrrd -j ${path}76.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}77.nrrd -seg ${pathSeg}77.seg.nrrd -j ${path}77.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}79.nrrd -seg ${pathSeg}79.seg.nrrd -j ${path}79.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}80.nrrd -seg ${pathSeg}80.seg.nrrd -j ${path}80.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}81.nrrd -seg ${pathSeg}81.seg.nrrd -j ${path}81.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}82.nrrd -seg ${pathSeg}82.seg.nrrd -j ${path}82.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}100.nrrd -seg ${pathSeg}100.seg.nrrd -j ${path}100.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}101.nrrd -seg ${pathSeg}101.seg.nrrd -j ${path}101.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}102.nrrd -seg ${pathSeg}102.seg.nrrd -j ${path}102.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}103.nrrd -seg ${pathSeg}103.seg.nrrd -j ${path}103.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}104.nrrd -seg ${pathSeg}104.seg.nrrd -j ${path}104.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}105.nrrd -seg ${pathSeg}105.seg.nrrd -j ${path}105.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}106.nrrd -seg ${pathSeg}106.seg.nrrd -j ${path}106.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}107.nrrd -seg ${pathSeg}107.seg.nrrd -j ${path}107.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}108.nrrd -seg ${pathSeg}108.seg.nrrd -j ${path}108.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}109.nrrd -seg ${pathSeg}109.seg.nrrd -j ${path}109.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}110.nrrd -seg ${pathSeg}110.seg.nrrd -j ${path}110.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}111.nrrd -seg ${pathSeg}111.seg.nrrd -j ${path}111.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}112.nrrd -seg ${pathSeg}112.seg.nrrd -j ${path}112.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}113.nrrd -seg ${pathSeg}113.seg.nrrd -j ${path}113.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}114.nrrd -seg ${pathSeg}114.seg.nrrd -j ${path}114.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}115.nrrd -seg ${pathSeg}115.seg.nrrd -j ${path}115.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}116.nrrd -seg ${pathSeg}116.seg.nrrd -j ${path}116.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}117.nrrd -seg ${pathSeg}117.seg.nrrd -j ${path}117.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}118.nrrd -seg ${pathSeg}118.seg.nrrd -j ${path}118.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}119.nrrd -seg ${pathSeg}119.seg.nrrd -j ${path}119.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}120.nrrd -seg ${pathSeg}120.seg.nrrd -j ${path}120.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}121.nrrd -seg ${pathSeg}121.seg.nrrd -j ${path}121.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}122.nrrd -seg ${pathSeg}122.seg.nrrd -j ${path}122.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}123.nrrd -seg ${pathSeg}123.seg.nrrd -j ${path}123.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}124.nrrd -seg ${pathSeg}124.seg.nrrd -j ${path}124.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}125.nrrd -seg ${pathSeg}125.seg.nrrd -j ${path}125.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}126.nrrd -seg ${pathSeg}126.seg.nrrd -j ${path}126.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}127.nrrd -seg ${pathSeg}127.seg.nrrd -j ${path}127.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}128.nrrd -seg ${pathSeg}128.seg.nrrd -j ${path}128.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}129.nrrd -seg ${pathSeg}129.seg.nrrd -j ${path}129.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}130.nrrd -seg ${pathSeg}130.seg.nrrd -j ${path}130.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}131.nrrd -seg ${pathSeg}131.seg.nrrd -j ${path}131.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}132.nrrd -seg ${pathSeg}132.seg.nrrd -j ${path}132.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}133.nrrd -seg ${pathSeg}133.seg.nrrd -j ${path}133.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}134.nrrd -seg ${pathSeg}134.seg.nrrd -j ${path}134.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}135.nrrd -seg ${pathSeg}135.seg.nrrd -j ${path}135.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}136.nrrd -seg ${pathSeg}136.seg.nrrd -j ${path}136.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}137.nrrd -seg ${pathSeg}137.seg.nrrd -j ${path}137.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}138.nrrd -seg ${pathSeg}138.seg.nrrd -j ${path}138.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}139.nrrd -seg ${pathSeg}139.seg.nrrd -j ${path}139.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}140.nrrd -seg ${pathSeg}140.seg.nrrd -j ${path}140.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}141.nrrd -seg ${pathSeg}141.seg.nrrd -j ${path}141.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}142.nrrd -seg ${pathSeg}142.seg.nrrd -j ${path}142.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}143.nrrd -seg ${pathSeg}143.seg.nrrd -j ${path}143.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}144.nrrd -seg ${pathSeg}144.seg.nrrd -j ${path}144.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}145.nrrd -seg ${pathSeg}145.seg.nrrd -j ${path}145.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}146.nrrd -seg ${pathSeg}146.seg.nrrd -j ${path}146.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}147.nrrd -seg ${pathSeg}147.seg.nrrd -j ${path}147.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}149.nrrd -seg ${pathSeg}149.seg.nrrd -j ${path}149.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}150.nrrd -seg ${pathSeg}150.seg.nrrd -j ${path}150.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}151.nrrd -seg ${pathSeg}151.seg.nrrd -j ${path}151.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}152.nrrd -seg ${pathSeg}152.seg.nrrd -j ${path}152.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}153.nrrd -seg ${pathSeg}153.seg.nrrd -j ${path}153.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}154.nrrd -seg ${pathSeg}154.seg.nrrd -j ${path}154.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}155.nrrd -seg ${pathSeg}155.seg.nrrd -j ${path}155.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}156.nrrd -seg ${pathSeg}156.seg.nrrd -j ${path}156.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}158.nrrd -seg ${pathSeg}158.seg.nrrd -j ${path}158.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}159.nrrd -seg ${pathSeg}159.seg.nrrd -j ${path}159.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}160.nrrd -seg ${pathSeg}160.seg.nrrd -j ${path}160.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}161.nrrd -seg ${pathSeg}161.seg.nrrd -j ${path}161.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}162.nrrd -seg ${pathSeg}162.seg.nrrd -j ${path}162.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}163.nrrd -seg ${pathSeg}163.seg.nrrd -j ${path}163.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}164.nrrd -seg ${pathSeg}164.seg.nrrd -j ${path}164.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}165.nrrd -seg ${pathSeg}165.seg.nrrd -j ${path}165.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}166.nrrd -seg ${pathSeg}166.seg.nrrd -j ${path}166.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}167.nrrd -seg ${pathSeg}167.seg.nrrd -j ${path}167.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}169.nrrd -seg ${pathSeg}169.seg.nrrd -j ${path}169.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}170.nrrd -seg ${pathSeg}170.seg.nrrd -j ${path}170.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}171.nrrd -seg ${pathSeg}171.seg.nrrd -j ${path}171.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}172.nrrd -seg ${pathSeg}172.seg.nrrd -j ${path}172.seg_F.mrk.json -cs 64
python3.9 Fetch_BoNI_crops.py -i ${path}174.nrrd -seg ${pathSeg}174.seg.nrrd -j ${path}174.seg_F.mrk.json -cs 64

