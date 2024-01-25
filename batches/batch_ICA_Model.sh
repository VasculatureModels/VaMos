#!/bin/bash

#ComputerName=`scutil --get ComputerName | tr a-z A-Z`
ComputerName=$(echo $HOSTNAME)
if [[ "$ComputerName" == "<---->.local" ]]
then
    echo 'Using Laptop'
    export path=/Users/----/ownCloud/NeuroVascu/TOF_Dataset_Spacing_0.4/
    export pathSeg=/Users/----/ownCloud/NeuroVascu/TOF_Dataset_Spacing_0.4/
elif [[ "$ComputerName" == "<---->" ]]
then
    echo "Using MacPro"
    export path=/Users/----/Desktop/New_dataset_Spacing_0.4/tofs/
    export pathSeg=/Users/----/Desktop/New_dataset_Spacing_0.4/tofs/
else
    echo "Linux (?)"
    export path=/home/data/Datasets/New_dataset_Spacing_0.4/tofs/
    export pathSeg=/home/data/Datasets/New_dataset_Spacing_0.4/tofs/
fi

alias python=python3.9
export SigSt=4
#export radius=4
#export elasticStDev=2.0
export d3D=0

for radius in 2 3 4 5
  do
    for elasticStDev in 1.0 2.0 3.0
    #for strSpl in 2 4 6 8 10 12
      do
        for AGrowth in 0.75 1.0
          do
          python model_add_ICA.py -i ${path}0.nrrd -seg ${pathSeg}0.seg.nrrd -str 2 -sigst ${SigSt} -bn 73 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}0.nrrd -seg ${pathSeg}0.seg.nrrd -str 2 -sigst ${SigSt} -bn 77 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}0.nrrd -seg ${pathSeg}0.seg.nrrd -str 2 -sigst ${SigSt} -bn 85 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}0.nrrd -seg ${pathSeg}0.seg.nrrd -str 2 -sigst ${SigSt} -bn 80 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}0.nrrd -seg ${pathSeg}0.seg.nrrd -str 2 -sigst ${SigSt} -bn 88 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}0.nrrd -seg ${pathSeg}0.seg.nrrd -str 2 -sigst ${SigSt} -bn 24 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}1.nrrd -seg ${pathSeg}1.seg.nrrd -str 2 -sigst ${SigSt} -bn 98 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}1.nrrd -seg ${pathSeg}1.seg.nrrd -str 2 -sigst ${SigSt} -bn 97 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}1.nrrd -seg ${pathSeg}1.seg.nrrd -str 2 -sigst ${SigSt} -bn 152 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}1.nrrd -seg ${pathSeg}1.seg.nrrd -str 2 -sigst ${SigSt} -bn 60 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}1.nrrd -seg ${pathSeg}1.seg.nrrd -str 2 -sigst ${SigSt} -bn 96 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}1.nrrd -seg ${pathSeg}1.seg.nrrd -str 2 -sigst ${SigSt} -bn 120 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}1.nrrd -seg ${pathSeg}1.seg.nrrd -str 2 -sigst ${SigSt} -bn 85 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}1.nrrd -seg ${pathSeg}1.seg.nrrd -str 2 -sigst ${SigSt} -bn 44 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}1.nrrd -seg ${pathSeg}1.seg.nrrd -str 2 -sigst ${SigSt} -bn 93 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

        #python model_add_ICA.py -i ${path}3.nrrd -seg ${pathSeg}3.seg.nrrd -str 2 -sigst ${SigSt} -bn 119 -fid 1 -cs 32 # <- ICA
          python model_add_ICA.py -i ${path}3.nrrd -seg ${pathSeg}3.seg.nrrd -str 2 -sigst ${SigSt} -bn 111 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}3.nrrd -seg ${pathSeg}3.seg.nrrd -str 2 -sigst ${SigSt} -bn 100 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}3.nrrd -seg ${pathSeg}3.seg.nrrd -str 2 -sigst ${SigSt} -bn 57 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}3.nrrd -seg ${pathSeg}3.seg.nrrd -str 2 -sigst ${SigSt} -bn 63 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}4.nrrd -seg ${pathSeg}4.seg.nrrd -str 2 -sigst ${SigSt} -bn 121 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}4.nrrd -seg ${pathSeg}4.seg.nrrd -str 2 -sigst ${SigSt} -bn 122 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}4.nrrd -seg ${pathSeg}4.seg.nrrd -str 2 -sigst ${SigSt} -bn 113 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}4.nrrd -seg ${pathSeg}4.seg.nrrd -str 2 -sigst ${SigSt} -bn 116 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}4.nrrd -seg ${pathSeg}4.seg.nrrd -str 2 -sigst ${SigSt} -bn 90 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}4.nrrd -seg ${pathSeg}4.seg.nrrd -str 2 -sigst ${SigSt} -bn 78 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}4.nrrd -seg ${pathSeg}4.seg.nrrd -str 2 -sigst ${SigSt} -bn 93 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}4.nrrd -seg ${pathSeg}4.seg.nrrd -str 2 -sigst ${SigSt} -bn 18 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}5.nrrd -seg ${pathSeg}5.seg.nrrd -str 2 -sigst ${SigSt} -bn 102 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}5.nrrd -seg ${pathSeg}5.seg.nrrd -str 2 -sigst ${SigSt} -bn 90 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
        #python model_add_ICA.py -i ${path}5.nrrd -seg ${pathSeg}5.seg.nrrd -str 2 -sigst ${SigSt} -bn 83 -fid 8 -cs 32 # <- ICA ?
          python model_add_ICA.py -i ${path}5.nrrd -seg ${pathSeg}5.seg.nrrd -str 2 -sigst ${SigSt} -bn 73 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}5.nrrd -seg ${pathSeg}5.seg.nrrd -str 2 -sigst ${SigSt} -bn 59 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}5.nrrd -seg ${pathSeg}5.seg.nrrd -str 2 -sigst ${SigSt} -bn 48 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}5.nrrd -seg ${pathSeg}5.seg.nrrd -str 2 -sigst ${SigSt} -bn 61 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}6.nrrd -seg ${pathSeg}6.seg.nrrd -str 2 -sigst ${SigSt} -bn 95 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}6.nrrd -seg ${pathSeg}6.seg.nrrd -str 2 -sigst ${SigSt} -bn 81 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}6.nrrd -seg ${pathSeg}6.seg.nrrd -str 2 -sigst ${SigSt} -bn 104 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}6.nrrd -seg ${pathSeg}6.seg.nrrd -str 2 -sigst ${SigSt} -bn 88 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}6.nrrd -seg ${pathSeg}6.seg.nrrd -str 2 -sigst ${SigSt} -bn 136 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}6.nrrd -seg ${pathSeg}6.seg.nrrd -str 2 -sigst ${SigSt} -bn 46 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}6.nrrd -seg ${pathSeg}6.seg.nrrd -str 2 -sigst ${SigSt} -bn 80 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
        #python model_add_ICA.py -i ${path}6.nrrd -seg ${pathSeg}6.seg.nrrd -str 2 -sigst ${SigSt} -bn 48 -fid 11 -cs 32 # <- ICA
          python model_add_ICA.py -i ${path}6.nrrd -seg ${pathSeg}6.seg.nrrd -str 2 -sigst ${SigSt} -bn 53 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}6.nrrd -seg ${pathSeg}6.seg.nrrd -str 2 -sigst ${SigSt} -bn 93 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}7.nrrd -seg ${pathSeg}7.seg.nrrd -str 2 -sigst ${SigSt} -bn 231 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}7.nrrd -seg ${pathSeg}7.seg.nrrd -str 2 -sigst ${SigSt} -bn 216 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}7.nrrd -seg ${pathSeg}7.seg.nrrd -str 2 -sigst ${SigSt} -bn 213 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}7.nrrd -seg ${pathSeg}7.seg.nrrd -str 2 -sigst ${SigSt} -bn 181 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}7.nrrd -seg ${pathSeg}7.seg.nrrd -str 2 -sigst ${SigSt} -bn 160 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}7.nrrd -seg ${pathSeg}7.seg.nrrd -str 2 -sigst ${SigSt} -bn 173 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}7.nrrd -seg ${pathSeg}7.seg.nrrd -str 2 -sigst ${SigSt} -bn 150 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}8.nrrd -seg ${pathSeg}8.seg.nrrd -str 2 -sigst ${SigSt} -bn 47 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}8.nrrd -seg ${pathSeg}8.seg.nrrd -str 2 -sigst ${SigSt} -bn 41 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}8.nrrd -seg ${pathSeg}8.seg.nrrd -str 2 -sigst ${SigSt} -bn 42 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}8.nrrd -seg ${pathSeg}8.seg.nrrd -str 2 -sigst ${SigSt} -bn 51 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}8.nrrd -seg ${pathSeg}8.seg.nrrd -str 2 -sigst ${SigSt} -bn 35 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}8.nrrd -seg ${pathSeg}8.seg.nrrd -str 2 -sigst ${SigSt} -bn 36 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}8.nrrd -seg ${pathSeg}8.seg.nrrd -str 2 -sigst ${SigSt} -bn 33 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}8.nrrd -seg ${pathSeg}8.seg.nrrd -str 2 -sigst ${SigSt} -bn 19 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}8.nrrd -seg ${pathSeg}8.seg.nrrd -str 2 -sigst ${SigSt} -bn 20 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}9.nrrd -seg ${pathSeg}9.seg.nrrd -str 2 -sigst ${SigSt} -bn 58 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}9.nrrd -seg ${pathSeg}9.seg.nrrd -str 2 -sigst ${SigSt} -bn 68 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}9.nrrd -seg ${pathSeg}9.seg.nrrd -str 2 -sigst ${SigSt} -bn 42 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}9.nrrd -seg ${pathSeg}9.seg.nrrd -str 2 -sigst ${SigSt} -bn 57 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}9.nrrd -seg ${pathSeg}9.seg.nrrd -str 2 -sigst ${SigSt} -bn 49 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}9.nrrd -seg ${pathSeg}9.seg.nrrd -str 2 -sigst ${SigSt} -bn 43 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}9.nrrd -seg ${pathSeg}9.seg.nrrd -str 2 -sigst ${SigSt} -bn 38 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}9.nrrd -seg ${pathSeg}9.seg.nrrd -str 2 -sigst ${SigSt} -bn 24 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}9.nrrd -seg ${pathSeg}9.seg.nrrd -str 2 -sigst ${SigSt} -bn 23 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}9.nrrd -seg ${pathSeg}9.seg.nrrd -str 2 -sigst ${SigSt} -bn 35 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}10.nrrd -seg ${pathSeg}10.seg.nrrd -str 2 -sigst ${SigSt} -bn 43 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}10.nrrd -seg ${pathSeg}10.seg.nrrd -str 2 -sigst ${SigSt} -bn 28 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}10.nrrd -seg ${pathSeg}10.seg.nrrd -str 2 -sigst ${SigSt} -bn 40 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}10.nrrd -seg ${pathSeg}10.seg.nrrd -str 2 -sigst ${SigSt} -bn 37 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}10.nrrd -seg ${pathSeg}10.seg.nrrd -str 2 -sigst ${SigSt} -bn 38 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}10.nrrd -seg ${pathSeg}10.seg.nrrd -str 2 -sigst ${SigSt} -bn 7 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}10.nrrd -seg ${pathSeg}10.seg.nrrd -str 2 -sigst ${SigSt} -bn 8 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}11.nrrd -seg ${pathSeg}11.seg.nrrd -str 2 -sigst ${SigSt} -bn 127 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}11.nrrd -seg ${pathSeg}11.seg.nrrd -str 2 -sigst ${SigSt} -bn 81 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}11.nrrd -seg ${pathSeg}11.seg.nrrd -str 2 -sigst ${SigSt} -bn 67 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}11.nrrd -seg ${pathSeg}11.seg.nrrd -str 2 -sigst ${SigSt} -bn 40 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}11.nrrd -seg ${pathSeg}11.seg.nrrd -str 2 -sigst ${SigSt} -bn 44 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}11.nrrd -seg ${pathSeg}11.seg.nrrd -str 2 -sigst ${SigSt} -bn 35 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}12.nrrd -seg ${pathSeg}12.seg.nrrd -str 2 -sigst ${SigSt} -bn 201 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}12.nrrd -seg ${pathSeg}12.seg.nrrd -str 2 -sigst ${SigSt} -bn 142 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}12.nrrd -seg ${pathSeg}12.seg.nrrd -str 2 -sigst ${SigSt} -bn 113 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}12.nrrd -seg ${pathSeg}12.seg.nrrd -str 2 -sigst ${SigSt} -bn 174 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}12.nrrd -seg ${pathSeg}12.seg.nrrd -str 2 -sigst ${SigSt} -bn 215 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}12.nrrd -seg ${pathSeg}12.seg.nrrd -str 2 -sigst ${SigSt} -bn 73 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}12.nrrd -seg ${pathSeg}12.seg.nrrd -str 2 -sigst ${SigSt} -bn 93 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}12.nrrd -seg ${pathSeg}12.seg.nrrd -str 2 -sigst ${SigSt} -bn 41 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}12.nrrd -seg ${pathSeg}12.seg.nrrd -str 2 -sigst ${SigSt} -bn 53 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}12.nrrd -seg ${pathSeg}12.seg.nrrd -str 2 -sigst ${SigSt} -bn 132 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}13.nrrd -seg ${pathSeg}13.seg.nrrd -str 2 -sigst ${SigSt} -bn 252 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}13.nrrd -seg ${pathSeg}13.seg.nrrd -str 2 -sigst ${SigSt} -bn 249 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}13.nrrd -seg ${pathSeg}13.seg.nrrd -str 2 -sigst ${SigSt} -bn 191 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}13.nrrd -seg ${pathSeg}13.seg.nrrd -str 2 -sigst ${SigSt} -bn 220 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}13.nrrd -seg ${pathSeg}13.seg.nrrd -str 2 -sigst ${SigSt} -bn 219 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}13.nrrd -seg ${pathSeg}13.seg.nrrd -str 2 -sigst ${SigSt} -bn 181 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}13.nrrd -seg ${pathSeg}13.seg.nrrd -str 2 -sigst ${SigSt} -bn 218 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}13.nrrd -seg ${pathSeg}13.seg.nrrd -str 2 -sigst ${SigSt} -bn 179 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}13.nrrd -seg ${pathSeg}13.seg.nrrd -str 2 -sigst ${SigSt} -bn 199 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}14.nrrd -seg ${pathSeg}14.seg.nrrd -str 2 -sigst ${SigSt} -bn 194 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}14.nrrd -seg ${pathSeg}14.seg.nrrd -str 2 -sigst ${SigSt} -bn 206 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}14.nrrd -seg ${pathSeg}14.seg.nrrd -str 2 -sigst ${SigSt} -bn 183 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}14.nrrd -seg ${pathSeg}14.seg.nrrd -str 2 -sigst ${SigSt} -bn 195 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}14.nrrd -seg ${pathSeg}14.seg.nrrd -str 2 -sigst ${SigSt} -bn 213 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}14.nrrd -seg ${pathSeg}14.seg.nrrd -str 2 -sigst ${SigSt} -bn 160 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}14.nrrd -seg ${pathSeg}14.seg.nrrd -str 2 -sigst ${SigSt} -bn 165 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}14.nrrd -seg ${pathSeg}14.seg.nrrd -str 2 -sigst ${SigSt} -bn 107 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}14.nrrd -seg ${pathSeg}14.seg.nrrd -str 2 -sigst ${SigSt} -bn 75 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}14.nrrd -seg ${pathSeg}14.seg.nrrd -str 2 -sigst ${SigSt} -bn 35 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}15.nrrd -seg ${pathSeg}15.seg.nrrd -str 2 -sigst ${SigSt} -bn 38 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}15.nrrd -seg ${pathSeg}15.seg.nrrd -str 2 -sigst ${SigSt} -bn 40 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}15.nrrd -seg ${pathSeg}15.seg.nrrd -str 2 -sigst ${SigSt} -bn 39 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}15.nrrd -seg ${pathSeg}15.seg.nrrd -str 2 -sigst ${SigSt} -bn 33 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}15.nrrd -seg ${pathSeg}15.seg.nrrd -str 2 -sigst ${SigSt} -bn 36 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}15.nrrd -seg ${pathSeg}15.seg.nrrd -str 2 -sigst ${SigSt} -bn 25 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}15.nrrd -seg ${pathSeg}15.seg.nrrd -str 2 -sigst ${SigSt} -bn 21 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}15.nrrd -seg ${pathSeg}15.seg.nrrd -str 2 -sigst ${SigSt} -bn 16 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}15.nrrd -seg ${pathSeg}15.seg.nrrd -str 2 -sigst ${SigSt} -bn 27 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}16.nrrd -seg ${pathSeg}16.seg.nrrd -str 2 -sigst ${SigSt} -bn 90 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}16.nrrd -seg ${pathSeg}16.seg.nrrd -str 2 -sigst ${SigSt} -bn 105 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}16.nrrd -seg ${pathSeg}16.seg.nrrd -str 2 -sigst ${SigSt} -bn 64 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}16.nrrd -seg ${pathSeg}16.seg.nrrd -str 2 -sigst ${SigSt} -bn 73 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}16.nrrd -seg ${pathSeg}16.seg.nrrd -str 2 -sigst ${SigSt} -bn 110 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}16.nrrd -seg ${pathSeg}16.seg.nrrd -str 2 -sigst ${SigSt} -bn 117 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}16.nrrd -seg ${pathSeg}16.seg.nrrd -str 2 -sigst ${SigSt} -bn 54 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}16.nrrd -seg ${pathSeg}16.seg.nrrd -str 2 -sigst ${SigSt} -bn 75 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}17.nrrd -seg ${pathSeg}17.seg.nrrd -str 2 -sigst ${SigSt} -bn 47 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}17.nrrd -seg ${pathSeg}17.seg.nrrd -str 2 -sigst ${SigSt} -bn 53 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}17.nrrd -seg ${pathSeg}17.seg.nrrd -str 2 -sigst ${SigSt} -bn 43 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}17.nrrd -seg ${pathSeg}17.seg.nrrd -str 2 -sigst ${SigSt} -bn 54 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}17.nrrd -seg ${pathSeg}17.seg.nrrd -str 2 -sigst ${SigSt} -bn 40 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}17.nrrd -seg ${pathSeg}17.seg.nrrd -str 2 -sigst ${SigSt} -bn 30 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}17.nrrd -seg ${pathSeg}17.seg.nrrd -str 2 -sigst ${SigSt} -bn 33 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}17.nrrd -seg ${pathSeg}17.seg.nrrd -str 2 -sigst ${SigSt} -bn 6 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}18.nrrd -seg ${pathSeg}18.seg.nrrd -str 2 -sigst ${SigSt} -bn 385 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}18.nrrd -seg ${pathSeg}18.seg.nrrd -str 2 -sigst ${SigSt} -bn 352 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}18.nrrd -seg ${pathSeg}18.seg.nrrd -str 2 -sigst ${SigSt} -bn 341 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}18.nrrd -seg ${pathSeg}18.seg.nrrd -str 2 -sigst ${SigSt} -bn 372 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D} ## <-- PB !
          python model_add_ICA.py -i ${path}18.nrrd -seg ${pathSeg}18.seg.nrrd -str 2 -sigst ${SigSt} -bn 324 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}18.nrrd -seg ${pathSeg}18.seg.nrrd -str 2 -sigst ${SigSt} -bn 304 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}18.nrrd -seg ${pathSeg}18.seg.nrrd -str 2 -sigst ${SigSt} -bn 313 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}18.nrrd -seg ${pathSeg}18.seg.nrrd -str 2 -sigst ${SigSt} -bn 305 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}18.nrrd -seg ${pathSeg}18.seg.nrrd -str 2 -sigst ${SigSt} -bn 200 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}18.nrrd -seg ${pathSeg}18.seg.nrrd -str 2 -sigst ${SigSt} -bn 201 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}19.nrrd -seg ${pathSeg}19.seg.nrrd -str 2 -sigst ${SigSt} -bn 76 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}19.nrrd -seg ${pathSeg}19.seg.nrrd -str 2 -sigst ${SigSt} -bn 69 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}19.nrrd -seg ${pathSeg}19.seg.nrrd -str 2 -sigst ${SigSt} -bn 67 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}19.nrrd -seg ${pathSeg}19.seg.nrrd -str 2 -sigst ${SigSt} -bn 61 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}19.nrrd -seg ${pathSeg}19.seg.nrrd -str 2 -sigst ${SigSt} -bn 43 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}19.nrrd -seg ${pathSeg}19.seg.nrrd -str 2 -sigst ${SigSt} -bn 19 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}20.nrrd -seg ${pathSeg}20.seg.nrrd -str 2 -sigst ${SigSt} -bn 71 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}20.nrrd -seg ${pathSeg}20.seg.nrrd -str 2 -sigst ${SigSt} -bn 52 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}20.nrrd -seg ${pathSeg}20.seg.nrrd -str 2 -sigst ${SigSt} -bn 58 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}20.nrrd -seg ${pathSeg}20.seg.nrrd -str 2 -sigst ${SigSt} -bn 70 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}20.nrrd -seg ${pathSeg}20.seg.nrrd -str 2 -sigst ${SigSt} -bn 51 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}20.nrrd -seg ${pathSeg}20.seg.nrrd -str 2 -sigst ${SigSt} -bn 37 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}20.nrrd -seg ${pathSeg}20.seg.nrrd -str 2 -sigst ${SigSt} -bn 38 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}20.nrrd -seg ${pathSeg}20.seg.nrrd -str 2 -sigst ${SigSt} -bn 47 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}20.nrrd -seg ${pathSeg}20.seg.nrrd -str 2 -sigst ${SigSt} -bn 22 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}21.nrrd -seg ${pathSeg}21.seg.nrrd -str 2 -sigst ${SigSt} -bn 196 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}21.nrrd -seg ${pathSeg}21.seg.nrrd -str 2 -sigst ${SigSt} -bn 154 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}21.nrrd -seg ${pathSeg}21.seg.nrrd -str 2 -sigst ${SigSt} -bn 172 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}21.nrrd -seg ${pathSeg}21.seg.nrrd -str 2 -sigst ${SigSt} -bn 190 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}21.nrrd -seg ${pathSeg}21.seg.nrrd -str 2 -sigst ${SigSt} -bn 182 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}21.nrrd -seg ${pathSeg}21.seg.nrrd -str 2 -sigst ${SigSt} -bn 122 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}21.nrrd -seg ${pathSeg}21.seg.nrrd -str 2 -sigst ${SigSt} -bn 131 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}21.nrrd -seg ${pathSeg}21.seg.nrrd -str 2 -sigst ${SigSt} -bn 103 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}21.nrrd -seg ${pathSeg}21.seg.nrrd -str 2 -sigst ${SigSt} -bn 160 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}21.nrrd -seg ${pathSeg}21.seg.nrrd -str 2 -sigst ${SigSt} -bn 69 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}21.nrrd -seg ${pathSeg}21.seg.nrrd -str 2 -sigst ${SigSt} -bn 68 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}22.nrrd -seg ${pathSeg}22.seg.nrrd -str 2 -sigst ${SigSt} -bn 81 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}22.nrrd -seg ${pathSeg}22.seg.nrrd -str 2 -sigst ${SigSt} -bn 47 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}22.nrrd -seg ${pathSeg}22.seg.nrrd -str 2 -sigst ${SigSt} -bn 76 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}22.nrrd -seg ${pathSeg}22.seg.nrrd -str 2 -sigst ${SigSt} -bn 64 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}22.nrrd -seg ${pathSeg}22.seg.nrrd -str 2 -sigst ${SigSt} -bn 41 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}22.nrrd -seg ${pathSeg}22.seg.nrrd -str 2 -sigst ${SigSt} -bn 55 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}22.nrrd -seg ${pathSeg}22.seg.nrrd -str 2 -sigst ${SigSt} -bn 15 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}22.nrrd -seg ${pathSeg}22.seg.nrrd -str 2 -sigst ${SigSt} -bn 20 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}23.nrrd -seg ${pathSeg}23.seg.nrrd -str 2 -sigst ${SigSt} -bn 101 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}23.nrrd -seg ${pathSeg}23.seg.nrrd -str 2 -sigst ${SigSt} -bn 109 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}23.nrrd -seg ${pathSeg}23.seg.nrrd -str 2 -sigst ${SigSt} -bn 97 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}23.nrrd -seg ${pathSeg}23.seg.nrrd -str 2 -sigst ${SigSt} -bn 80 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}23.nrrd -seg ${pathSeg}23.seg.nrrd -str 2 -sigst ${SigSt} -bn 71 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}23.nrrd -seg ${pathSeg}23.seg.nrrd -str 2 -sigst ${SigSt} -bn 88 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}23.nrrd -seg ${pathSeg}23.seg.nrrd -str 2 -sigst ${SigSt} -bn 69 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}23.nrrd -seg ${pathSeg}23.seg.nrrd -str 2 -sigst ${SigSt} -bn 67 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}23.nrrd -seg ${pathSeg}23.seg.nrrd -str 2 -sigst ${SigSt} -bn 98 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}23.nrrd -seg ${pathSeg}23.seg.nrrd -str 2 -sigst ${SigSt} -bn 46 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}24.nrrd -seg ${pathSeg}24.seg.nrrd -str 2 -sigst ${SigSt} -bn 80 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}24.nrrd -seg ${pathSeg}24.seg.nrrd -str 2 -sigst ${SigSt} -bn 85 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}24.nrrd -seg ${pathSeg}24.seg.nrrd -str 2 -sigst ${SigSt} -bn 81 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}24.nrrd -seg ${pathSeg}24.seg.nrrd -str 2 -sigst ${SigSt} -bn 87 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}24.nrrd -seg ${pathSeg}24.seg.nrrd -str 2 -sigst ${SigSt} -bn 61 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}24.nrrd -seg ${pathSeg}24.seg.nrrd -str 2 -sigst ${SigSt} -bn 49 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}24.nrrd -seg ${pathSeg}24.seg.nrrd -str 2 -sigst ${SigSt} -bn 47 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}24.nrrd -seg ${pathSeg}24.seg.nrrd -str 2 -sigst ${SigSt} -bn 36 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}25.nrrd -seg ${pathSeg}25.seg.nrrd -str 2 -sigst ${SigSt} -bn 85 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}25.nrrd -seg ${pathSeg}25.seg.nrrd -str 2 -sigst ${SigSt} -bn 92 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}25.nrrd -seg ${pathSeg}25.seg.nrrd -str 2 -sigst ${SigSt} -bn 100 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}25.nrrd -seg ${pathSeg}25.seg.nrrd -str 2 -sigst ${SigSt} -bn 89 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}25.nrrd -seg ${pathSeg}25.seg.nrrd -str 2 -sigst ${SigSt} -bn 107 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}25.nrrd -seg ${pathSeg}25.seg.nrrd -str 2 -sigst ${SigSt} -bn 68 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}25.nrrd -seg ${pathSeg}25.seg.nrrd -str 2 -sigst ${SigSt} -bn 59 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}25.nrrd -seg ${pathSeg}25.seg.nrrd -str 2 -sigst ${SigSt} -bn 62 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}25.nrrd -seg ${pathSeg}25.seg.nrrd -str 2 -sigst ${SigSt} -bn 44 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}25.nrrd -seg ${pathSeg}25.seg.nrrd -str 2 -sigst ${SigSt} -bn 50 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}25.nrrd -seg ${pathSeg}25.seg.nrrd -str 2 -sigst ${SigSt} -bn 14 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}26.nrrd -seg ${pathSeg}26.seg.nrrd -str 2 -sigst ${SigSt} -bn 71 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}26.nrrd -seg ${pathSeg}26.seg.nrrd -str 2 -sigst ${SigSt} -bn 67 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}26.nrrd -seg ${pathSeg}26.seg.nrrd -str 2 -sigst ${SigSt} -bn 72 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}26.nrrd -seg ${pathSeg}26.seg.nrrd -str 2 -sigst ${SigSt} -bn 69 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}26.nrrd -seg ${pathSeg}26.seg.nrrd -str 2 -sigst ${SigSt} -bn 59 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}26.nrrd -seg ${pathSeg}26.seg.nrrd -str 2 -sigst ${SigSt} -bn 42 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}26.nrrd -seg ${pathSeg}26.seg.nrrd -str 2 -sigst ${SigSt} -bn 34 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}26.nrrd -seg ${pathSeg}26.seg.nrrd -str 2 -sigst ${SigSt} -bn 40 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}26.nrrd -seg ${pathSeg}26.seg.nrrd -str 2 -sigst ${SigSt} -bn 24 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}27.nrrd -seg ${pathSeg}27.seg.nrrd -str 2 -sigst ${SigSt} -bn 61 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}27.nrrd -seg ${pathSeg}27.seg.nrrd -str 2 -sigst ${SigSt} -bn 50 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}27.nrrd -seg ${pathSeg}27.seg.nrrd -str 2 -sigst ${SigSt} -bn 79 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}27.nrrd -seg ${pathSeg}27.seg.nrrd -str 2 -sigst ${SigSt} -bn 58 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}27.nrrd -seg ${pathSeg}27.seg.nrrd -str 2 -sigst ${SigSt} -bn 86 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}27.nrrd -seg ${pathSeg}27.seg.nrrd -str 2 -sigst ${SigSt} -bn 30 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}28.nrrd -seg ${pathSeg}28.seg.nrrd -str 2 -sigst ${SigSt} -bn 144 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}28.nrrd -seg ${pathSeg}28.seg.nrrd -str 2 -sigst ${SigSt} -bn 143 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}28.nrrd -seg ${pathSeg}28.seg.nrrd -str 2 -sigst ${SigSt} -bn 75 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}28.nrrd -seg ${pathSeg}28.seg.nrrd -str 2 -sigst ${SigSt} -bn 67 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
        #python model_add_ICA.py -i ${path}28.nrrd -seg ${pathSeg}28.seg.nrrd -str 2 -sigst ${SigSt} -bn 108 -fid 7 -cs 32 # <- ICA ?
          python model_add_ICA.py -i ${path}28.nrrd -seg ${pathSeg}28.seg.nrrd -str 2 -sigst ${SigSt} -bn 96 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}28.nrrd -seg ${pathSeg}28.seg.nrrd -str 2 -sigst ${SigSt} -bn 54 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}28.nrrd -seg ${pathSeg}28.seg.nrrd -str 2 -sigst ${SigSt} -bn 33 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}28.nrrd -seg ${pathSeg}28.seg.nrrd -str 2 -sigst ${SigSt} -bn 28 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}28.nrrd -seg ${pathSeg}28.seg.nrrd -str 2 -sigst ${SigSt} -bn 23 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}28.nrrd -seg ${pathSeg}28.seg.nrrd -str 2 -sigst ${SigSt} -bn 34 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}29.nrrd -seg ${pathSeg}29.seg.nrrd -str 2 -sigst ${SigSt} -bn 101 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}29.nrrd -seg ${pathSeg}29.seg.nrrd -str 2 -sigst ${SigSt} -bn 96 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}29.nrrd -seg ${pathSeg}29.seg.nrrd -str 2 -sigst ${SigSt} -bn 62 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}29.nrrd -seg ${pathSeg}29.seg.nrrd -str 2 -sigst ${SigSt} -bn 59 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}29.nrrd -seg ${pathSeg}29.seg.nrrd -str 2 -sigst ${SigSt} -bn 51 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}29.nrrd -seg ${pathSeg}29.seg.nrrd -str 2 -sigst ${SigSt} -bn 36 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}29.nrrd -seg ${pathSeg}29.seg.nrrd -str 2 -sigst ${SigSt} -bn 55 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}30.nrrd -seg ${pathSeg}30.seg.nrrd -str 2 -sigst ${SigSt} -bn 91 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}30.nrrd -seg ${pathSeg}30.seg.nrrd -str 2 -sigst ${SigSt} -bn 96 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}30.nrrd -seg ${pathSeg}30.seg.nrrd -str 2 -sigst ${SigSt} -bn 79 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}30.nrrd -seg ${pathSeg}30.seg.nrrd -str 2 -sigst ${SigSt} -bn 59 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}30.nrrd -seg ${pathSeg}30.seg.nrrd -str 2 -sigst ${SigSt} -bn 112 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}30.nrrd -seg ${pathSeg}30.seg.nrrd -str 2 -sigst ${SigSt} -bn 47 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}30.nrrd -seg ${pathSeg}30.seg.nrrd -str 2 -sigst ${SigSt} -bn 70 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}31.nrrd -seg ${pathSeg}31.seg.nrrd -str 2 -sigst ${SigSt} -bn 122 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}31.nrrd -seg ${pathSeg}31.seg.nrrd -str 2 -sigst ${SigSt} -bn 103 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}31.nrrd -seg ${pathSeg}31.seg.nrrd -str 2 -sigst ${SigSt} -bn 99 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}31.nrrd -seg ${pathSeg}31.seg.nrrd -str 2 -sigst ${SigSt} -bn 60 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}31.nrrd -seg ${pathSeg}31.seg.nrrd -str 2 -sigst ${SigSt} -bn 89 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}31.nrrd -seg ${pathSeg}31.seg.nrrd -str 2 -sigst ${SigSt} -bn 65 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}31.nrrd -seg ${pathSeg}31.seg.nrrd -str 2 -sigst ${SigSt} -bn 40 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}31.nrrd -seg ${pathSeg}31.seg.nrrd -str 2 -sigst ${SigSt} -bn 62 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}32.nrrd -seg ${pathSeg}32.seg.nrrd -str 2 -sigst ${SigSt} -bn 74 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}32.nrrd -seg ${pathSeg}32.seg.nrrd -str 2 -sigst ${SigSt} -bn 81 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}32.nrrd -seg ${pathSeg}32.seg.nrrd -str 2 -sigst ${SigSt} -bn 78 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}32.nrrd -seg ${pathSeg}32.seg.nrrd -str 2 -sigst ${SigSt} -bn 60 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}32.nrrd -seg ${pathSeg}32.seg.nrrd -str 2 -sigst ${SigSt} -bn 55 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}32.nrrd -seg ${pathSeg}32.seg.nrrd -str 2 -sigst ${SigSt} -bn 44 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}32.nrrd -seg ${pathSeg}32.seg.nrrd -str 2 -sigst ${SigSt} -bn 117 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}32.nrrd -seg ${pathSeg}32.seg.nrrd -str 2 -sigst ${SigSt} -bn 5 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}33.nrrd -seg ${pathSeg}33.seg.nrrd -str 2 -sigst ${SigSt} -bn 92 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}33.nrrd -seg ${pathSeg}33.seg.nrrd -str 2 -sigst ${SigSt} -bn 86 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}33.nrrd -seg ${pathSeg}33.seg.nrrd -str 2 -sigst ${SigSt} -bn 96 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}33.nrrd -seg ${pathSeg}33.seg.nrrd -str 2 -sigst ${SigSt} -bn 75 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}33.nrrd -seg ${pathSeg}33.seg.nrrd -str 2 -sigst ${SigSt} -bn 58 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}33.nrrd -seg ${pathSeg}33.seg.nrrd -str 2 -sigst ${SigSt} -bn 80 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}35.nrrd -seg ${pathSeg}35.seg.nrrd -str 2 -sigst ${SigSt} -bn 106 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}35.nrrd -seg ${pathSeg}35.seg.nrrd -str 2 -sigst ${SigSt} -bn 91 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}35.nrrd -seg ${pathSeg}35.seg.nrrd -str 2 -sigst ${SigSt} -bn 98 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}35.nrrd -seg ${pathSeg}35.seg.nrrd -str 2 -sigst ${SigSt} -bn 90 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}35.nrrd -seg ${pathSeg}35.seg.nrrd -str 2 -sigst ${SigSt} -bn 62 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}35.nrrd -seg ${pathSeg}35.seg.nrrd -str 2 -sigst ${SigSt} -bn 69 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}35.nrrd -seg ${pathSeg}35.seg.nrrd -str 2 -sigst ${SigSt} -bn 70 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}35.nrrd -seg ${pathSeg}35.seg.nrrd -str 2 -sigst ${SigSt} -bn 31 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}36.nrrd -seg ${pathSeg}36.seg.nrrd -str 2 -sigst ${SigSt} -bn 92 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}36.nrrd -seg ${pathSeg}36.seg.nrrd -str 2 -sigst ${SigSt} -bn 105 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}36.nrrd -seg ${pathSeg}36.seg.nrrd -str 2 -sigst ${SigSt} -bn 68 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}36.nrrd -seg ${pathSeg}36.seg.nrrd -str 2 -sigst ${SigSt} -bn 66 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}36.nrrd -seg ${pathSeg}36.seg.nrrd -str 2 -sigst ${SigSt} -bn 64 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}36.nrrd -seg ${pathSeg}36.seg.nrrd -str 2 -sigst ${SigSt} -bn 45 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}37.nrrd -seg ${pathSeg}37.seg.nrrd -str 2 -sigst ${SigSt} -bn 95 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}37.nrrd -seg ${pathSeg}37.seg.nrrd -str 2 -sigst ${SigSt} -bn 97 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}37.nrrd -seg ${pathSeg}37.seg.nrrd -str 2 -sigst ${SigSt} -bn 129 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}37.nrrd -seg ${pathSeg}37.seg.nrrd -str 2 -sigst ${SigSt} -bn 101 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}37.nrrd -seg ${pathSeg}37.seg.nrrd -str 2 -sigst ${SigSt} -bn 84 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}37.nrrd -seg ${pathSeg}37.seg.nrrd -str 2 -sigst ${SigSt} -bn 122 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}37.nrrd -seg ${pathSeg}37.seg.nrrd -str 2 -sigst ${SigSt} -bn 58 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}38.nrrd -seg ${pathSeg}38.seg.nrrd -str 2 -sigst ${SigSt} -bn 73 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}38.nrrd -seg ${pathSeg}38.seg.nrrd -str 2 -sigst ${SigSt} -bn 80 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}38.nrrd -seg ${pathSeg}38.seg.nrrd -str 2 -sigst ${SigSt} -bn 68 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}38.nrrd -seg ${pathSeg}38.seg.nrrd -str 2 -sigst ${SigSt} -bn 58 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}38.nrrd -seg ${pathSeg}38.seg.nrrd -str 2 -sigst ${SigSt} -bn 84 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}38.nrrd -seg ${pathSeg}38.seg.nrrd -str 2 -sigst ${SigSt} -bn 61 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}38.nrrd -seg ${pathSeg}38.seg.nrrd -str 2 -sigst ${SigSt} -bn 42 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}38.nrrd -seg ${pathSeg}38.seg.nrrd -str 2 -sigst ${SigSt} -bn 40 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}38.nrrd -seg ${pathSeg}38.seg.nrrd -str 2 -sigst ${SigSt} -bn 37 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}38.nrrd -seg ${pathSeg}38.seg.nrrd -str 2 -sigst ${SigSt} -bn 39 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}38.nrrd -seg ${pathSeg}38.seg.nrrd -str 2 -sigst ${SigSt} -bn 17 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}38.nrrd -seg ${pathSeg}38.seg.nrrd -str 2 -sigst ${SigSt} -bn 13 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}39.nrrd -seg ${pathSeg}39.seg.nrrd -str 2 -sigst ${SigSt} -bn 63 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}39.nrrd -seg ${pathSeg}39.seg.nrrd -str 2 -sigst ${SigSt} -bn 71 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}39.nrrd -seg ${pathSeg}39.seg.nrrd -str 2 -sigst ${SigSt} -bn 57 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}39.nrrd -seg ${pathSeg}39.seg.nrrd -str 2 -sigst ${SigSt} -bn 73 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}39.nrrd -seg ${pathSeg}39.seg.nrrd -str 2 -sigst ${SigSt} -bn 49 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}39.nrrd -seg ${pathSeg}39.seg.nrrd -str 2 -sigst ${SigSt} -bn 47 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}39.nrrd -seg ${pathSeg}39.seg.nrrd -str 2 -sigst ${SigSt} -bn 52 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}39.nrrd -seg ${pathSeg}39.seg.nrrd -str 2 -sigst ${SigSt} -bn 41 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}39.nrrd -seg ${pathSeg}39.seg.nrrd -str 2 -sigst ${SigSt} -bn 39 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}40.nrrd -seg ${pathSeg}40.seg.nrrd -str 2 -sigst ${SigSt} -bn 57 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}40.nrrd -seg ${pathSeg}40.seg.nrrd -str 2 -sigst ${SigSt} -bn 46 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}40.nrrd -seg ${pathSeg}40.seg.nrrd -str 2 -sigst ${SigSt} -bn 48 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}40.nrrd -seg ${pathSeg}40.seg.nrrd -str 2 -sigst ${SigSt} -bn 40 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}40.nrrd -seg ${pathSeg}40.seg.nrrd -str 2 -sigst ${SigSt} -bn 60 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}40.nrrd -seg ${pathSeg}40.seg.nrrd -str 2 -sigst ${SigSt} -bn 34 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}41.nrrd -seg ${pathSeg}41.seg.nrrd -str 2 -sigst ${SigSt} -bn 89 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}41.nrrd -seg ${pathSeg}41.seg.nrrd -str 2 -sigst ${SigSt} -bn 102 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}41.nrrd -seg ${pathSeg}41.seg.nrrd -str 2 -sigst ${SigSt} -bn 80 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}41.nrrd -seg ${pathSeg}41.seg.nrrd -str 2 -sigst ${SigSt} -bn 83 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}41.nrrd -seg ${pathSeg}41.seg.nrrd -str 2 -sigst ${SigSt} -bn 53 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}41.nrrd -seg ${pathSeg}41.seg.nrrd -str 2 -sigst ${SigSt} -bn 74 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}41.nrrd -seg ${pathSeg}41.seg.nrrd -str 2 -sigst ${SigSt} -bn 26 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}41.nrrd -seg ${pathSeg}41.seg.nrrd -str 2 -sigst ${SigSt} -bn 18 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}42.nrrd -seg ${pathSeg}42.seg.nrrd -str 2 -sigst ${SigSt} -bn 136 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}42.nrrd -seg ${pathSeg}42.seg.nrrd -str 2 -sigst ${SigSt} -bn 137 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}42.nrrd -seg ${pathSeg}42.seg.nrrd -str 2 -sigst ${SigSt} -bn 109 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}42.nrrd -seg ${pathSeg}42.seg.nrrd -str 2 -sigst ${SigSt} -bn 142 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}42.nrrd -seg ${pathSeg}42.seg.nrrd -str 2 -sigst ${SigSt} -bn 120 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}42.nrrd -seg ${pathSeg}42.seg.nrrd -str 2 -sigst ${SigSt} -bn 92 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}42.nrrd -seg ${pathSeg}42.seg.nrrd -str 2 -sigst ${SigSt} -bn 95 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}42.nrrd -seg ${pathSeg}42.seg.nrrd -str 2 -sigst ${SigSt} -bn 18 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}43.nrrd -seg ${pathSeg}43.seg.nrrd -str 2 -sigst ${SigSt} -bn 182 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}43.nrrd -seg ${pathSeg}43.seg.nrrd -str 2 -sigst ${SigSt} -bn 199 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}43.nrrd -seg ${pathSeg}43.seg.nrrd -str 2 -sigst ${SigSt} -bn 186 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}43.nrrd -seg ${pathSeg}43.seg.nrrd -str 2 -sigst ${SigSt} -bn 188 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}43.nrrd -seg ${pathSeg}43.seg.nrrd -str 2 -sigst ${SigSt} -bn 181 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}43.nrrd -seg ${pathSeg}43.seg.nrrd -str 2 -sigst ${SigSt} -bn 161 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}43.nrrd -seg ${pathSeg}43.seg.nrrd -str 2 -sigst ${SigSt} -bn 170 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}43.nrrd -seg ${pathSeg}43.seg.nrrd -str 2 -sigst ${SigSt} -bn 134 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}43.nrrd -seg ${pathSeg}43.seg.nrrd -str 2 -sigst ${SigSt} -bn 124 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}43.nrrd -seg ${pathSeg}43.seg.nrrd -str 2 -sigst ${SigSt} -bn 164 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}43.nrrd -seg ${pathSeg}43.seg.nrrd -str 2 -sigst ${SigSt} -bn 65 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}45.nrrd -seg ${pathSeg}45.seg.nrrd -str 2 -sigst ${SigSt} -bn 109 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}45.nrrd -seg ${pathSeg}45.seg.nrrd -str 2 -sigst ${SigSt} -bn 91 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}45.nrrd -seg ${pathSeg}45.seg.nrrd -str 2 -sigst ${SigSt} -bn 116 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}45.nrrd -seg ${pathSeg}45.seg.nrrd -str 2 -sigst ${SigSt} -bn 71 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}45.nrrd -seg ${pathSeg}45.seg.nrrd -str 2 -sigst ${SigSt} -bn 58 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}45.nrrd -seg ${pathSeg}45.seg.nrrd -str 2 -sigst ${SigSt} -bn 59 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}45.nrrd -seg ${pathSeg}45.seg.nrrd -str 2 -sigst ${SigSt} -bn 43 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}46.nrrd -seg ${pathSeg}46.seg.nrrd -str 2 -sigst ${SigSt} -bn 54 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}46.nrrd -seg ${pathSeg}46.seg.nrrd -str 2 -sigst ${SigSt} -bn 55 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}46.nrrd -seg ${pathSeg}46.seg.nrrd -str 2 -sigst ${SigSt} -bn 65 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}46.nrrd -seg ${pathSeg}46.seg.nrrd -str 2 -sigst ${SigSt} -bn 59 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}46.nrrd -seg ${pathSeg}46.seg.nrrd -str 2 -sigst ${SigSt} -bn 18 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}47.nrrd -seg ${pathSeg}47.seg.nrrd -str 2 -sigst ${SigSt} -bn 95 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}47.nrrd -seg ${pathSeg}47.seg.nrrd -str 2 -sigst ${SigSt} -bn 92 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}47.nrrd -seg ${pathSeg}47.seg.nrrd -str 2 -sigst ${SigSt} -bn 50 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}47.nrrd -seg ${pathSeg}47.seg.nrrd -str 2 -sigst ${SigSt} -bn 56 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}47.nrrd -seg ${pathSeg}47.seg.nrrd -str 2 -sigst ${SigSt} -bn 57 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}47.nrrd -seg ${pathSeg}47.seg.nrrd -str 2 -sigst ${SigSt} -bn 55 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}47.nrrd -seg ${pathSeg}47.seg.nrrd -str 2 -sigst ${SigSt} -bn 31 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}47.nrrd -seg ${pathSeg}47.seg.nrrd -str 2 -sigst ${SigSt} -bn 73 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}48.nrrd -seg ${pathSeg}48.seg.nrrd -str 2 -sigst ${SigSt} -bn 105 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}48.nrrd -seg ${pathSeg}48.seg.nrrd -str 2 -sigst ${SigSt} -bn 84 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}48.nrrd -seg ${pathSeg}48.seg.nrrd -str 2 -sigst ${SigSt} -bn 74 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}48.nrrd -seg ${pathSeg}48.seg.nrrd -str 2 -sigst ${SigSt} -bn 88 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}48.nrrd -seg ${pathSeg}48.seg.nrrd -str 2 -sigst ${SigSt} -bn 58 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}48.nrrd -seg ${pathSeg}48.seg.nrrd -str 2 -sigst ${SigSt} -bn 68 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}48.nrrd -seg ${pathSeg}48.seg.nrrd -str 2 -sigst ${SigSt} -bn 110 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}49.nrrd -seg ${pathSeg}49.seg.nrrd -str 2 -sigst ${SigSt} -bn 197 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}49.nrrd -seg ${pathSeg}49.seg.nrrd -str 2 -sigst ${SigSt} -bn 202 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}49.nrrd -seg ${pathSeg}49.seg.nrrd -str 2 -sigst ${SigSt} -bn 171 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}49.nrrd -seg ${pathSeg}49.seg.nrrd -str 2 -sigst ${SigSt} -bn 178 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}49.nrrd -seg ${pathSeg}49.seg.nrrd -str 2 -sigst ${SigSt} -bn 229 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}49.nrrd -seg ${pathSeg}49.seg.nrrd -str 2 -sigst ${SigSt} -bn 115 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}49.nrrd -seg ${pathSeg}49.seg.nrrd -str 2 -sigst ${SigSt} -bn 121 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}49.nrrd -seg ${pathSeg}49.seg.nrrd -str 2 -sigst ${SigSt} -bn 129 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}49.nrrd -seg ${pathSeg}49.seg.nrrd -str 2 -sigst ${SigSt} -bn 95 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}49.nrrd -seg ${pathSeg}49.seg.nrrd -str 2 -sigst ${SigSt} -bn 93 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}49.nrrd -seg ${pathSeg}49.seg.nrrd -str 2 -sigst ${SigSt} -bn 53 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}53.nrrd -seg ${pathSeg}53.seg.nrrd -str 2 -sigst ${SigSt} -bn 111 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}53.nrrd -seg ${pathSeg}53.seg.nrrd -str 2 -sigst ${SigSt} -bn 80 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}53.nrrd -seg ${pathSeg}53.seg.nrrd -str 2 -sigst ${SigSt} -bn 85 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}53.nrrd -seg ${pathSeg}53.seg.nrrd -str 2 -sigst ${SigSt} -bn 84 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}53.nrrd -seg ${pathSeg}53.seg.nrrd -str 2 -sigst ${SigSt} -bn 75 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}53.nrrd -seg ${pathSeg}53.seg.nrrd -str 2 -sigst ${SigSt} -bn 56 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}53.nrrd -seg ${pathSeg}53.seg.nrrd -str 2 -sigst ${SigSt} -bn 52 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}53.nrrd -seg ${pathSeg}53.seg.nrrd -str 2 -sigst ${SigSt} -bn 47 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}53.nrrd -seg ${pathSeg}53.seg.nrrd -str 2 -sigst ${SigSt} -bn 45 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}53.nrrd -seg ${pathSeg}53.seg.nrrd -str 2 -sigst ${SigSt} -bn 49 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}55.nrrd -seg ${pathSeg}55.seg.nrrd -str 2 -sigst ${SigSt} -bn 134 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}55.nrrd -seg ${pathSeg}55.seg.nrrd -str 2 -sigst ${SigSt} -bn 136 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}55.nrrd -seg ${pathSeg}55.seg.nrrd -str 2 -sigst ${SigSt} -bn 115 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}55.nrrd -seg ${pathSeg}55.seg.nrrd -str 2 -sigst ${SigSt} -bn 118 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}55.nrrd -seg ${pathSeg}55.seg.nrrd -str 2 -sigst ${SigSt} -bn 112 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}55.nrrd -seg ${pathSeg}55.seg.nrrd -str 2 -sigst ${SigSt} -bn 110 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}55.nrrd -seg ${pathSeg}55.seg.nrrd -str 2 -sigst ${SigSt} -bn 102 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}55.nrrd -seg ${pathSeg}55.seg.nrrd -str 2 -sigst ${SigSt} -bn 85 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}55.nrrd -seg ${pathSeg}55.seg.nrrd -str 2 -sigst ${SigSt} -bn 91 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}55.nrrd -seg ${pathSeg}55.seg.nrrd -str 2 -sigst ${SigSt} -bn 98 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}56.nrrd -seg ${pathSeg}56.seg.nrrd -str 2 -sigst ${SigSt} -bn 76 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}56.nrrd -seg ${pathSeg}56.seg.nrrd -str 2 -sigst ${SigSt} -bn 66 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}56.nrrd -seg ${pathSeg}56.seg.nrrd -str 2 -sigst ${SigSt} -bn 67 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}56.nrrd -seg ${pathSeg}56.seg.nrrd -str 2 -sigst ${SigSt} -bn 73 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}56.nrrd -seg ${pathSeg}56.seg.nrrd -str 2 -sigst ${SigSt} -bn 60 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}56.nrrd -seg ${pathSeg}56.seg.nrrd -str 2 -sigst ${SigSt} -bn 58 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}56.nrrd -seg ${pathSeg}56.seg.nrrd -str 2 -sigst ${SigSt} -bn 59 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}56.nrrd -seg ${pathSeg}56.seg.nrrd -str 2 -sigst ${SigSt} -bn 24 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}57.nrrd -seg ${pathSeg}57.seg.nrrd -str 2 -sigst ${SigSt} -bn 146 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}57.nrrd -seg ${pathSeg}57.seg.nrrd -str 2 -sigst ${SigSt} -bn 168 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}57.nrrd -seg ${pathSeg}57.seg.nrrd -str 2 -sigst ${SigSt} -bn 119 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}57.nrrd -seg ${pathSeg}57.seg.nrrd -str 2 -sigst ${SigSt} -bn 161 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}57.nrrd -seg ${pathSeg}57.seg.nrrd -str 2 -sigst ${SigSt} -bn 118 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}57.nrrd -seg ${pathSeg}57.seg.nrrd -str 2 -sigst ${SigSt} -bn 111 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}57.nrrd -seg ${pathSeg}57.seg.nrrd -str 2 -sigst ${SigSt} -bn 97 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}57.nrrd -seg ${pathSeg}57.seg.nrrd -str 2 -sigst ${SigSt} -bn 108 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}57.nrrd -seg ${pathSeg}57.seg.nrrd -str 2 -sigst ${SigSt} -bn 82 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}57.nrrd -seg ${pathSeg}57.seg.nrrd -str 2 -sigst ${SigSt} -bn 85 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}57.nrrd -seg ${pathSeg}57.seg.nrrd -str 2 -sigst ${SigSt} -bn 52 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}57.nrrd -seg ${pathSeg}57.seg.nrrd -str 2 -sigst ${SigSt} -bn 14 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}58.nrrd -seg ${pathSeg}58.seg.nrrd -str 2 -sigst ${SigSt} -bn 44 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}58.nrrd -seg ${pathSeg}58.seg.nrrd -str 2 -sigst ${SigSt} -bn 56 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}58.nrrd -seg ${pathSeg}58.seg.nrrd -str 2 -sigst ${SigSt} -bn 49 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}58.nrrd -seg ${pathSeg}58.seg.nrrd -str 2 -sigst ${SigSt} -bn 52 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}58.nrrd -seg ${pathSeg}58.seg.nrrd -str 2 -sigst ${SigSt} -bn 46 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}58.nrrd -seg ${pathSeg}58.seg.nrrd -str 2 -sigst ${SigSt} -bn 51 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}58.nrrd -seg ${pathSeg}58.seg.nrrd -str 2 -sigst ${SigSt} -bn 22 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}58.nrrd -seg ${pathSeg}58.seg.nrrd -str 2 -sigst ${SigSt} -bn 19 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}58.nrrd -seg ${pathSeg}58.seg.nrrd -str 2 -sigst ${SigSt} -bn 43 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}58.nrrd -seg ${pathSeg}58.seg.nrrd -str 2 -sigst ${SigSt} -bn 5 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}59.nrrd -seg ${pathSeg}59.seg.nrrd -str 2 -sigst ${SigSt} -bn 79 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}59.nrrd -seg ${pathSeg}59.seg.nrrd -str 2 -sigst ${SigSt} -bn 72 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}59.nrrd -seg ${pathSeg}59.seg.nrrd -str 2 -sigst ${SigSt} -bn 85 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}59.nrrd -seg ${pathSeg}59.seg.nrrd -str 2 -sigst ${SigSt} -bn 71 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}59.nrrd -seg ${pathSeg}59.seg.nrrd -str 2 -sigst ${SigSt} -bn 32 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}59.nrrd -seg ${pathSeg}59.seg.nrrd -str 2 -sigst ${SigSt} -bn 28 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}59.nrrd -seg ${pathSeg}59.seg.nrrd -str 2 -sigst ${SigSt} -bn 21 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}59.nrrd -seg ${pathSeg}59.seg.nrrd -str 2 -sigst ${SigSt} -bn 18 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}59.nrrd -seg ${pathSeg}59.seg.nrrd -str 2 -sigst ${SigSt} -bn 7 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}60.nrrd -seg ${pathSeg}60.seg.nrrd -str 2 -sigst ${SigSt} -bn 79 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}60.nrrd -seg ${pathSeg}60.seg.nrrd -str 2 -sigst ${SigSt} -bn 81 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}60.nrrd -seg ${pathSeg}60.seg.nrrd -str 2 -sigst ${SigSt} -bn 76 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}60.nrrd -seg ${pathSeg}60.seg.nrrd -str 2 -sigst ${SigSt} -bn 72 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}60.nrrd -seg ${pathSeg}60.seg.nrrd -str 2 -sigst ${SigSt} -bn 87 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}60.nrrd -seg ${pathSeg}60.seg.nrrd -str 2 -sigst ${SigSt} -bn 65 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}60.nrrd -seg ${pathSeg}60.seg.nrrd -str 2 -sigst ${SigSt} -bn 63 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}60.nrrd -seg ${pathSeg}60.seg.nrrd -str 2 -sigst ${SigSt} -bn 54 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}60.nrrd -seg ${pathSeg}60.seg.nrrd -str 2 -sigst ${SigSt} -bn 47 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}60.nrrd -seg ${pathSeg}60.seg.nrrd -str 2 -sigst ${SigSt} -bn 42 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}60.nrrd -seg ${pathSeg}60.seg.nrrd -str 2 -sigst ${SigSt} -bn 50 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}61.nrrd -seg ${pathSeg}61.seg.nrrd -str 2 -sigst ${SigSt} -bn 48 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}61.nrrd -seg ${pathSeg}61.seg.nrrd -str 2 -sigst ${SigSt} -bn 66 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}61.nrrd -seg ${pathSeg}61.seg.nrrd -str 2 -sigst ${SigSt} -bn 71 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}61.nrrd -seg ${pathSeg}61.seg.nrrd -str 2 -sigst ${SigSt} -bn 114 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}61.nrrd -seg ${pathSeg}61.seg.nrrd -str 2 -sigst ${SigSt} -bn 67 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}61.nrrd -seg ${pathSeg}61.seg.nrrd -str 2 -sigst ${SigSt} -bn 51 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}61.nrrd -seg ${pathSeg}61.seg.nrrd -str 2 -sigst ${SigSt} -bn 24 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}62.nrrd -seg ${pathSeg}62.seg.nrrd -str 2 -sigst ${SigSt} -bn 91 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}62.nrrd -seg ${pathSeg}62.seg.nrrd -str 2 -sigst ${SigSt} -bn 93 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}62.nrrd -seg ${pathSeg}62.seg.nrrd -str 2 -sigst ${SigSt} -bn 80 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}62.nrrd -seg ${pathSeg}62.seg.nrrd -str 2 -sigst ${SigSt} -bn 89 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}62.nrrd -seg ${pathSeg}62.seg.nrrd -str 2 -sigst ${SigSt} -bn 76 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}62.nrrd -seg ${pathSeg}62.seg.nrrd -str 2 -sigst ${SigSt} -bn 66 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}62.nrrd -seg ${pathSeg}62.seg.nrrd -str 2 -sigst ${SigSt} -bn 51 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}62.nrrd -seg ${pathSeg}62.seg.nrrd -str 2 -sigst ${SigSt} -bn 26 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}63.nrrd -seg ${pathSeg}63.seg.nrrd -str 2 -sigst ${SigSt} -bn 123 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}63.nrrd -seg ${pathSeg}63.seg.nrrd -str 2 -sigst ${SigSt} -bn 137 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}63.nrrd -seg ${pathSeg}63.seg.nrrd -str 2 -sigst ${SigSt} -bn 108 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}63.nrrd -seg ${pathSeg}63.seg.nrrd -str 2 -sigst ${SigSt} -bn 140 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}63.nrrd -seg ${pathSeg}63.seg.nrrd -str 2 -sigst ${SigSt} -bn 68 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}63.nrrd -seg ${pathSeg}63.seg.nrrd -str 2 -sigst ${SigSt} -bn 83 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}63.nrrd -seg ${pathSeg}63.seg.nrrd -str 2 -sigst ${SigSt} -bn 119 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}64.nrrd -seg ${pathSeg}64.seg.nrrd -str 2 -sigst ${SigSt} -bn 93 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}64.nrrd -seg ${pathSeg}64.seg.nrrd -str 2 -sigst ${SigSt} -bn 77 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}64.nrrd -seg ${pathSeg}64.seg.nrrd -str 2 -sigst ${SigSt} -bn 51 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}64.nrrd -seg ${pathSeg}64.seg.nrrd -str 2 -sigst ${SigSt} -bn 83 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}64.nrrd -seg ${pathSeg}64.seg.nrrd -str 2 -sigst ${SigSt} -bn 42 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}64.nrrd -seg ${pathSeg}64.seg.nrrd -str 2 -sigst ${SigSt} -bn 43 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}64.nrrd -seg ${pathSeg}64.seg.nrrd -str 2 -sigst ${SigSt} -bn 27 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}64.nrrd -seg ${pathSeg}64.seg.nrrd -str 2 -sigst ${SigSt} -bn 30 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}64.nrrd -seg ${pathSeg}64.seg.nrrd -str 2 -sigst ${SigSt} -bn 24 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}65.nrrd -seg ${pathSeg}65.seg.nrrd -str 2 -sigst ${SigSt} -bn 81 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}65.nrrd -seg ${pathSeg}65.seg.nrrd -str 2 -sigst ${SigSt} -bn 73 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}65.nrrd -seg ${pathSeg}65.seg.nrrd -str 2 -sigst ${SigSt} -bn 75 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}65.nrrd -seg ${pathSeg}65.seg.nrrd -str 2 -sigst ${SigSt} -bn 91 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}65.nrrd -seg ${pathSeg}65.seg.nrrd -str 2 -sigst ${SigSt} -bn 59 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}65.nrrd -seg ${pathSeg}65.seg.nrrd -str 2 -sigst ${SigSt} -bn 80 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}65.nrrd -seg ${pathSeg}65.seg.nrrd -str 2 -sigst ${SigSt} -bn 43 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}65.nrrd -seg ${pathSeg}65.seg.nrrd -str 2 -sigst ${SigSt} -bn 69 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}65.nrrd -seg ${pathSeg}65.seg.nrrd -str 2 -sigst ${SigSt} -bn 40 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}65.nrrd -seg ${pathSeg}65.seg.nrrd -str 2 -sigst ${SigSt} -bn 42 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}65.nrrd -seg ${pathSeg}65.seg.nrrd -str 2 -sigst ${SigSt} -bn 36 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}66.nrrd -seg ${pathSeg}66.seg.nrrd -str 2 -sigst ${SigSt} -bn 52 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}66.nrrd -seg ${pathSeg}66.seg.nrrd -str 2 -sigst ${SigSt} -bn 45 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}66.nrrd -seg ${pathSeg}66.seg.nrrd -str 2 -sigst ${SigSt} -bn 44 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}66.nrrd -seg ${pathSeg}66.seg.nrrd -str 2 -sigst ${SigSt} -bn 49 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}66.nrrd -seg ${pathSeg}66.seg.nrrd -str 2 -sigst ${SigSt} -bn 50 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}66.nrrd -seg ${pathSeg}66.seg.nrrd -str 2 -sigst ${SigSt} -bn 41 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}66.nrrd -seg ${pathSeg}66.seg.nrrd -str 2 -sigst ${SigSt} -bn 40 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}66.nrrd -seg ${pathSeg}66.seg.nrrd -str 2 -sigst ${SigSt} -bn 37 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}66.nrrd -seg ${pathSeg}66.seg.nrrd -str 2 -sigst ${SigSt} -bn 32 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}67.nrrd -seg ${pathSeg}67.seg.nrrd -str 2 -sigst ${SigSt} -bn 91 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}67.nrrd -seg ${pathSeg}67.seg.nrrd -str 2 -sigst ${SigSt} -bn 63 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}67.nrrd -seg ${pathSeg}67.seg.nrrd -str 2 -sigst ${SigSt} -bn 64 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}67.nrrd -seg ${pathSeg}67.seg.nrrd -str 2 -sigst ${SigSt} -bn 48 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}67.nrrd -seg ${pathSeg}67.seg.nrrd -str 2 -sigst ${SigSt} -bn 34 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}67.nrrd -seg ${pathSeg}67.seg.nrrd -str 2 -sigst ${SigSt} -bn 31 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}67.nrrd -seg ${pathSeg}67.seg.nrrd -str 2 -sigst ${SigSt} -bn 38 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}68.nrrd -seg ${pathSeg}68.seg.nrrd -str 2 -sigst ${SigSt} -bn 86 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}68.nrrd -seg ${pathSeg}68.seg.nrrd -str 2 -sigst ${SigSt} -bn 87 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}68.nrrd -seg ${pathSeg}68.seg.nrrd -str 2 -sigst ${SigSt} -bn 81 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}68.nrrd -seg ${pathSeg}68.seg.nrrd -str 2 -sigst ${SigSt} -bn 83 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}68.nrrd -seg ${pathSeg}68.seg.nrrd -str 2 -sigst ${SigSt} -bn 84 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}68.nrrd -seg ${pathSeg}68.seg.nrrd -str 2 -sigst ${SigSt} -bn 85 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}68.nrrd -seg ${pathSeg}68.seg.nrrd -str 2 -sigst ${SigSt} -bn 79 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}68.nrrd -seg ${pathSeg}68.seg.nrrd -str 2 -sigst ${SigSt} -bn 80 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}68.nrrd -seg ${pathSeg}68.seg.nrrd -str 2 -sigst ${SigSt} -bn 73 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}68.nrrd -seg ${pathSeg}68.seg.nrrd -str 2 -sigst ${SigSt} -bn 14 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}69.nrrd -seg ${pathSeg}69.seg.nrrd -str 2 -sigst ${SigSt} -bn 35 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}69.nrrd -seg ${pathSeg}69.seg.nrrd -str 2 -sigst ${SigSt} -bn 22 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}69.nrrd -seg ${pathSeg}69.seg.nrrd -str 2 -sigst ${SigSt} -bn 31 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}69.nrrd -seg ${pathSeg}69.seg.nrrd -str 2 -sigst ${SigSt} -bn 25 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}69.nrrd -seg ${pathSeg}69.seg.nrrd -str 2 -sigst ${SigSt} -bn 27 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}69.nrrd -seg ${pathSeg}69.seg.nrrd -str 2 -sigst ${SigSt} -bn 12 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}69.nrrd -seg ${pathSeg}69.seg.nrrd -str 2 -sigst ${SigSt} -bn 17 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}69.nrrd -seg ${pathSeg}69.seg.nrrd -str 2 -sigst ${SigSt} -bn 13 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}70.nrrd -seg ${pathSeg}70.seg.nrrd -str 2 -sigst ${SigSt} -bn 63 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}70.nrrd -seg ${pathSeg}70.seg.nrrd -str 2 -sigst ${SigSt} -bn 70 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}70.nrrd -seg ${pathSeg}70.seg.nrrd -str 2 -sigst ${SigSt} -bn 48 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}70.nrrd -seg ${pathSeg}70.seg.nrrd -str 2 -sigst ${SigSt} -bn 56 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}70.nrrd -seg ${pathSeg}70.seg.nrrd -str 2 -sigst ${SigSt} -bn 27 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}70.nrrd -seg ${pathSeg}70.seg.nrrd -str 2 -sigst ${SigSt} -bn 32 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}71.nrrd -seg ${pathSeg}71.seg.nrrd -str 2 -sigst ${SigSt} -bn 40 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}71.nrrd -seg ${pathSeg}71.seg.nrrd -str 2 -sigst ${SigSt} -bn 37 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}71.nrrd -seg ${pathSeg}71.seg.nrrd -str 2 -sigst ${SigSt} -bn 33 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}71.nrrd -seg ${pathSeg}71.seg.nrrd -str 2 -sigst ${SigSt} -bn 51 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}71.nrrd -seg ${pathSeg}71.seg.nrrd -str 2 -sigst ${SigSt} -bn 44 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}71.nrrd -seg ${pathSeg}71.seg.nrrd -str 2 -sigst ${SigSt} -bn 22 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}71.nrrd -seg ${pathSeg}71.seg.nrrd -str 2 -sigst ${SigSt} -bn 21 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}71.nrrd -seg ${pathSeg}71.seg.nrrd -str 2 -sigst ${SigSt} -bn 29 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}73.nrrd -seg ${pathSeg}73.seg.nrrd -str 2 -sigst ${SigSt} -bn 80 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}73.nrrd -seg ${pathSeg}73.seg.nrrd -str 2 -sigst ${SigSt} -bn 50 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}73.nrrd -seg ${pathSeg}73.seg.nrrd -str 2 -sigst ${SigSt} -bn 47 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}73.nrrd -seg ${pathSeg}73.seg.nrrd -str 2 -sigst ${SigSt} -bn 63 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}73.nrrd -seg ${pathSeg}73.seg.nrrd -str 2 -sigst ${SigSt} -bn 44 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}73.nrrd -seg ${pathSeg}73.seg.nrrd -str 2 -sigst ${SigSt} -bn 43 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}73.nrrd -seg ${pathSeg}73.seg.nrrd -str 2 -sigst ${SigSt} -bn 39 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}73.nrrd -seg ${pathSeg}73.seg.nrrd -str 2 -sigst ${SigSt} -bn 20 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}73.nrrd -seg ${pathSeg}73.seg.nrrd -str 2 -sigst ${SigSt} -bn 7 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}73.nrrd -seg ${pathSeg}73.seg.nrrd -str 2 -sigst ${SigSt} -bn 11 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}74.nrrd -seg ${pathSeg}74.seg.nrrd -str 2 -sigst ${SigSt} -bn 65 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}74.nrrd -seg ${pathSeg}74.seg.nrrd -str 2 -sigst ${SigSt} -bn 64 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}74.nrrd -seg ${pathSeg}74.seg.nrrd -str 2 -sigst ${SigSt} -bn 76 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}74.nrrd -seg ${pathSeg}74.seg.nrrd -str 2 -sigst ${SigSt} -bn 53 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}74.nrrd -seg ${pathSeg}74.seg.nrrd -str 2 -sigst ${SigSt} -bn 28 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}74.nrrd -seg ${pathSeg}74.seg.nrrd -str 2 -sigst ${SigSt} -bn 29 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}74.nrrd -seg ${pathSeg}74.seg.nrrd -str 2 -sigst ${SigSt} -bn 44 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}74.nrrd -seg ${pathSeg}74.seg.nrrd -str 2 -sigst ${SigSt} -bn 48 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}75.nrrd -seg ${pathSeg}75.seg.nrrd -str 2 -sigst ${SigSt} -bn 74 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}75.nrrd -seg ${pathSeg}75.seg.nrrd -str 2 -sigst ${SigSt} -bn 55 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}75.nrrd -seg ${pathSeg}75.seg.nrrd -str 2 -sigst ${SigSt} -bn 54 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}75.nrrd -seg ${pathSeg}75.seg.nrrd -str 2 -sigst ${SigSt} -bn 62 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}75.nrrd -seg ${pathSeg}75.seg.nrrd -str 2 -sigst ${SigSt} -bn 60 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}75.nrrd -seg ${pathSeg}75.seg.nrrd -str 2 -sigst ${SigSt} -bn 45 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}75.nrrd -seg ${pathSeg}75.seg.nrrd -str 2 -sigst ${SigSt} -bn 37 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}76.nrrd -seg ${pathSeg}76.seg.nrrd -str 2 -sigst ${SigSt} -bn 74 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}76.nrrd -seg ${pathSeg}76.seg.nrrd -str 2 -sigst ${SigSt} -bn 80 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}76.nrrd -seg ${pathSeg}76.seg.nrrd -str 2 -sigst ${SigSt} -bn 57 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}76.nrrd -seg ${pathSeg}76.seg.nrrd -str 2 -sigst ${SigSt} -bn 81 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}76.nrrd -seg ${pathSeg}76.seg.nrrd -str 2 -sigst ${SigSt} -bn 43 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}76.nrrd -seg ${pathSeg}76.seg.nrrd -str 2 -sigst ${SigSt} -bn 65 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}76.nrrd -seg ${pathSeg}76.seg.nrrd -str 2 -sigst ${SigSt} -bn 42 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}76.nrrd -seg ${pathSeg}76.seg.nrrd -str 2 -sigst ${SigSt} -bn 58 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}76.nrrd -seg ${pathSeg}76.seg.nrrd -str 2 -sigst ${SigSt} -bn 41 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}76.nrrd -seg ${pathSeg}76.seg.nrrd -str 2 -sigst ${SigSt} -bn 34 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}77.nrrd -seg ${pathSeg}77.seg.nrrd -str 2 -sigst ${SigSt} -bn 132 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}77.nrrd -seg ${pathSeg}77.seg.nrrd -str 2 -sigst ${SigSt} -bn 142 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}77.nrrd -seg ${pathSeg}77.seg.nrrd -str 2 -sigst ${SigSt} -bn 140 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}77.nrrd -seg ${pathSeg}77.seg.nrrd -str 2 -sigst ${SigSt} -bn 93 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}77.nrrd -seg ${pathSeg}77.seg.nrrd -str 2 -sigst ${SigSt} -bn 115 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}77.nrrd -seg ${pathSeg}77.seg.nrrd -str 2 -sigst ${SigSt} -bn 83 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}77.nrrd -seg ${pathSeg}77.seg.nrrd -str 2 -sigst ${SigSt} -bn 85 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}77.nrrd -seg ${pathSeg}77.seg.nrrd -str 2 -sigst ${SigSt} -bn 81 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}77.nrrd -seg ${pathSeg}77.seg.nrrd -str 2 -sigst ${SigSt} -bn 31 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}79.nrrd -seg ${pathSeg}79.seg.nrrd -str 2 -sigst ${SigSt} -bn 190 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}79.nrrd -seg ${pathSeg}79.seg.nrrd -str 2 -sigst ${SigSt} -bn 167 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}79.nrrd -seg ${pathSeg}79.seg.nrrd -str 2 -sigst ${SigSt} -bn 181 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}79.nrrd -seg ${pathSeg}79.seg.nrrd -str 2 -sigst ${SigSt} -bn 155 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}79.nrrd -seg ${pathSeg}79.seg.nrrd -str 2 -sigst ${SigSt} -bn 191 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}79.nrrd -seg ${pathSeg}79.seg.nrrd -str 2 -sigst ${SigSt} -bn 153 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}79.nrrd -seg ${pathSeg}79.seg.nrrd -str 2 -sigst ${SigSt} -bn 107 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}79.nrrd -seg ${pathSeg}79.seg.nrrd -str 2 -sigst ${SigSt} -bn 116 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}79.nrrd -seg ${pathSeg}79.seg.nrrd -str 2 -sigst ${SigSt} -bn 71 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}79.nrrd -seg ${pathSeg}79.seg.nrrd -str 2 -sigst ${SigSt} -bn 84 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}79.nrrd -seg ${pathSeg}79.seg.nrrd -str 2 -sigst ${SigSt} -bn 10 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}80.nrrd -seg ${pathSeg}80.seg.nrrd -str 2 -sigst ${SigSt} -bn 58 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}80.nrrd -seg ${pathSeg}80.seg.nrrd -str 2 -sigst ${SigSt} -bn 59 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}80.nrrd -seg ${pathSeg}80.seg.nrrd -str 2 -sigst ${SigSt} -bn 51 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}80.nrrd -seg ${pathSeg}80.seg.nrrd -str 2 -sigst ${SigSt} -bn 57 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}80.nrrd -seg ${pathSeg}80.seg.nrrd -str 2 -sigst ${SigSt} -bn 48 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}80.nrrd -seg ${pathSeg}80.seg.nrrd -str 2 -sigst ${SigSt} -bn 35 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}   ## <-- FAIL !
          python model_add_ICA.py -i ${path}80.nrrd -seg ${pathSeg}80.seg.nrrd -str 2 -sigst ${SigSt} -bn 61 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}81.nrrd -seg ${pathSeg}81.seg.nrrd -str 2 -sigst ${SigSt} -bn 167 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}81.nrrd -seg ${pathSeg}81.seg.nrrd -str 2 -sigst ${SigSt} -bn 155 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}81.nrrd -seg ${pathSeg}81.seg.nrrd -str 2 -sigst ${SigSt} -bn 111 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}81.nrrd -seg ${pathSeg}81.seg.nrrd -str 2 -sigst ${SigSt} -bn 141 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}81.nrrd -seg ${pathSeg}81.seg.nrrd -str 2 -sigst ${SigSt} -bn 134 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}81.nrrd -seg ${pathSeg}81.seg.nrrd -str 2 -sigst ${SigSt} -bn 104 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}81.nrrd -seg ${pathSeg}81.seg.nrrd -str 2 -sigst ${SigSt} -bn 98 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}81.nrrd -seg ${pathSeg}81.seg.nrrd -str 2 -sigst ${SigSt} -bn 95 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}81.nrrd -seg ${pathSeg}81.seg.nrrd -str 2 -sigst ${SigSt} -bn 173 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}81.nrrd -seg ${pathSeg}81.seg.nrrd -str 2 -sigst ${SigSt} -bn 39 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}82.nrrd -seg ${pathSeg}82.seg.nrrd -str 2 -sigst ${SigSt} -bn 77 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}82.nrrd -seg ${pathSeg}82.seg.nrrd -str 2 -sigst ${SigSt} -bn 58 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}82.nrrd -seg ${pathSeg}82.seg.nrrd -str 2 -sigst ${SigSt} -bn 54 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}82.nrrd -seg ${pathSeg}82.seg.nrrd -str 2 -sigst ${SigSt} -bn 46 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}82.nrrd -seg ${pathSeg}82.seg.nrrd -str 2 -sigst ${SigSt} -bn 43 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}82.nrrd -seg ${pathSeg}82.seg.nrrd -str 2 -sigst ${SigSt} -bn 42 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}82.nrrd -seg ${pathSeg}82.seg.nrrd -str 2 -sigst ${SigSt} -bn 40 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}82.nrrd -seg ${pathSeg}82.seg.nrrd -str 2 -sigst ${SigSt} -bn 33 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}82.nrrd -seg ${pathSeg}82.seg.nrrd -str 2 -sigst ${SigSt} -bn 26 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}83.nrrd -seg ${pathSeg}83.seg.nrrd -str 2 -sigst ${SigSt} -bn 63 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}83.nrrd -seg ${pathSeg}83.seg.nrrd -str 2 -sigst ${SigSt} -bn 53 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}85.nrrd -seg ${pathSeg}85.seg.nrrd -str 2 -sigst ${SigSt} -bn 80 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}85.nrrd -seg ${pathSeg}85.seg.nrrd -str 2 -sigst ${SigSt} -bn 97 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}85.nrrd -seg ${pathSeg}85.seg.nrrd -str 2 -sigst ${SigSt} -bn 101 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}85.nrrd -seg ${pathSeg}85.seg.nrrd -str 2 -sigst ${SigSt} -bn 70 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}85.nrrd -seg ${pathSeg}85.seg.nrrd -str 2 -sigst ${SigSt} -bn 43 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}85.nrrd -seg ${pathSeg}85.seg.nrrd -str 2 -sigst ${SigSt} -bn 46 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}85.nrrd -seg ${pathSeg}85.seg.nrrd -str 2 -sigst ${SigSt} -bn 71 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}86.nrrd -seg ${pathSeg}86.seg.nrrd -str 2 -sigst ${SigSt} -bn 99 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}86.nrrd -seg ${pathSeg}86.seg.nrrd -str 2 -sigst ${SigSt} -bn 79 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}86.nrrd -seg ${pathSeg}86.seg.nrrd -str 2 -sigst ${SigSt} -bn 84 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}86.nrrd -seg ${pathSeg}86.seg.nrrd -str 2 -sigst ${SigSt} -bn 118 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
        #python model_add_ICA.py -i ${path}86.nrrd -seg ${pathSeg}86.seg.nrrd -str 2 -sigst ${SigSt} -bn 88 -fid 8 -cs 32 # <- ICA
          python model_add_ICA.py -i ${path}86.nrrd -seg ${pathSeg}86.seg.nrrd -str 2 -sigst ${SigSt} -bn 66 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}86.nrrd -seg ${pathSeg}86.seg.nrrd -str 2 -sigst ${SigSt} -bn 73 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}86.nrrd -seg ${pathSeg}86.seg.nrrd -str 2 -sigst ${SigSt} -bn 62 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}86.nrrd -seg ${pathSeg}86.seg.nrrd -str 2 -sigst ${SigSt} -bn 65 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}86.nrrd -seg ${pathSeg}86.seg.nrrd -str 2 -sigst ${SigSt} -bn 63 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}100.nrrd -seg ${pathSeg}100.seg.nrrd -str 2 -sigst ${SigSt} -bn 72 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}100.nrrd -seg ${pathSeg}100.seg.nrrd -str 2 -sigst ${SigSt} -bn 97 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}100.nrrd -seg ${pathSeg}100.seg.nrrd -str 2 -sigst ${SigSt} -bn 80 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}100.nrrd -seg ${pathSeg}100.seg.nrrd -str 2 -sigst ${SigSt} -bn 65 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}100.nrrd -seg ${pathSeg}100.seg.nrrd -str 2 -sigst ${SigSt} -bn 59 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}100.nrrd -seg ${pathSeg}100.seg.nrrd -str 2 -sigst ${SigSt} -bn 47 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}100.nrrd -seg ${pathSeg}100.seg.nrrd -str 2 -sigst ${SigSt} -bn 46 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}100.nrrd -seg ${pathSeg}100.seg.nrrd -str 2 -sigst ${SigSt} -bn 45 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}100.nrrd -seg ${pathSeg}100.seg.nrrd -str 2 -sigst ${SigSt} -bn 29 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}100.nrrd -seg ${pathSeg}100.seg.nrrd -str 2 -sigst ${SigSt} -bn 21 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}101.nrrd -seg ${pathSeg}101.seg.nrrd -str 2 -sigst ${SigSt} -bn 61 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}101.nrrd -seg ${pathSeg}101.seg.nrrd -str 2 -sigst ${SigSt} -bn 55 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}101.nrrd -seg ${pathSeg}101.seg.nrrd -str 2 -sigst ${SigSt} -bn 62 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}101.nrrd -seg ${pathSeg}101.seg.nrrd -str 2 -sigst ${SigSt} -bn 57 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}101.nrrd -seg ${pathSeg}101.seg.nrrd -str 2 -sigst ${SigSt} -bn 45 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}101.nrrd -seg ${pathSeg}101.seg.nrrd -str 2 -sigst ${SigSt} -bn 38 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}101.nrrd -seg ${pathSeg}101.seg.nrrd -str 2 -sigst ${SigSt} -bn 28 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}101.nrrd -seg ${pathSeg}101.seg.nrrd -str 2 -sigst ${SigSt} -bn 51 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}102.nrrd -seg ${pathSeg}102.seg.nrrd -str 2 -sigst ${SigSt} -bn 40 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}102.nrrd -seg ${pathSeg}102.seg.nrrd -str 2 -sigst ${SigSt} -bn 53 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}102.nrrd -seg ${pathSeg}102.seg.nrrd -str 2 -sigst ${SigSt} -bn 41 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}102.nrrd -seg ${pathSeg}102.seg.nrrd -str 2 -sigst ${SigSt} -bn 63 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}102.nrrd -seg ${pathSeg}102.seg.nrrd -str 2 -sigst ${SigSt} -bn 35 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}102.nrrd -seg ${pathSeg}102.seg.nrrd -str 2 -sigst ${SigSt} -bn 77 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}102.nrrd -seg ${pathSeg}102.seg.nrrd -str 2 -sigst ${SigSt} -bn 37 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}102.nrrd -seg ${pathSeg}102.seg.nrrd -str 2 -sigst ${SigSt} -bn 17 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}102.nrrd -seg ${pathSeg}102.seg.nrrd -str 2 -sigst ${SigSt} -bn 16 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}102.nrrd -seg ${pathSeg}102.seg.nrrd -str 2 -sigst ${SigSt} -bn 29 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}103.nrrd -seg ${pathSeg}103.seg.nrrd -str 2 -sigst ${SigSt} -bn 141 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}103.nrrd -seg ${pathSeg}103.seg.nrrd -str 2 -sigst ${SigSt} -bn 136 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}103.nrrd -seg ${pathSeg}103.seg.nrrd -str 2 -sigst ${SigSt} -bn 107 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}103.nrrd -seg ${pathSeg}103.seg.nrrd -str 2 -sigst ${SigSt} -bn 116 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}103.nrrd -seg ${pathSeg}103.seg.nrrd -str 2 -sigst ${SigSt} -bn 102 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}103.nrrd -seg ${pathSeg}103.seg.nrrd -str 2 -sigst ${SigSt} -bn 138 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}103.nrrd -seg ${pathSeg}103.seg.nrrd -str 2 -sigst ${SigSt} -bn 109 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}103.nrrd -seg ${pathSeg}103.seg.nrrd -str 2 -sigst ${SigSt} -bn 105 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}103.nrrd -seg ${pathSeg}103.seg.nrrd -str 2 -sigst ${SigSt} -bn 126 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}103.nrrd -seg ${pathSeg}103.seg.nrrd -str 2 -sigst ${SigSt} -bn 55 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}104.nrrd -seg ${pathSeg}104.seg.nrrd -str 2 -sigst ${SigSt} -bn 114 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}104.nrrd -seg ${pathSeg}104.seg.nrrd -str 2 -sigst ${SigSt} -bn 78 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}104.nrrd -seg ${pathSeg}104.seg.nrrd -str 2 -sigst ${SigSt} -bn 80 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}104.nrrd -seg ${pathSeg}104.seg.nrrd -str 2 -sigst ${SigSt} -bn 104 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}104.nrrd -seg ${pathSeg}104.seg.nrrd -str 2 -sigst ${SigSt} -bn 76 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}104.nrrd -seg ${pathSeg}104.seg.nrrd -str 2 -sigst ${SigSt} -bn 56 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}104.nrrd -seg ${pathSeg}104.seg.nrrd -str 2 -sigst ${SigSt} -bn 72 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}104.nrrd -seg ${pathSeg}104.seg.nrrd -str 2 -sigst ${SigSt} -bn 53 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}104.nrrd -seg ${pathSeg}104.seg.nrrd -str 2 -sigst ${SigSt} -bn 58 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}104.nrrd -seg ${pathSeg}104.seg.nrrd -str 2 -sigst ${SigSt} -bn 77 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}104.nrrd -seg ${pathSeg}104.seg.nrrd -str 2 -sigst ${SigSt} -bn 25 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}105.nrrd -seg ${pathSeg}105.seg.nrrd -str 2 -sigst ${SigSt} -bn 66 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}105.nrrd -seg ${pathSeg}105.seg.nrrd -str 2 -sigst ${SigSt} -bn 80 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}105.nrrd -seg ${pathSeg}105.seg.nrrd -str 2 -sigst ${SigSt} -bn 71 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}105.nrrd -seg ${pathSeg}105.seg.nrrd -str 2 -sigst ${SigSt} -bn 55 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}105.nrrd -seg ${pathSeg}105.seg.nrrd -str 2 -sigst ${SigSt} -bn 36 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}105.nrrd -seg ${pathSeg}105.seg.nrrd -str 2 -sigst ${SigSt} -bn 40 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}106.nrrd -seg ${pathSeg}106.seg.nrrd -str 2 -sigst ${SigSt} -bn 54 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}106.nrrd -seg ${pathSeg}106.seg.nrrd -str 2 -sigst ${SigSt} -bn 56 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}106.nrrd -seg ${pathSeg}106.seg.nrrd -str 2 -sigst ${SigSt} -bn 81 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}106.nrrd -seg ${pathSeg}106.seg.nrrd -str 2 -sigst ${SigSt} -bn 67 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}106.nrrd -seg ${pathSeg}106.seg.nrrd -str 2 -sigst ${SigSt} -bn 59 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
        #python model_add_ICA.py -i ${path}106.nrrd -seg ${pathSeg}106.seg.nrrd -str 2 -sigst ${SigSt} -bn 63 -fid 8 -cs 32 # <- ICA ?
          python model_add_ICA.py -i ${path}106.nrrd -seg ${pathSeg}106.seg.nrrd -str 2 -sigst ${SigSt} -bn 64 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}106.nrrd -seg ${pathSeg}106.seg.nrrd -str 2 -sigst ${SigSt} -bn 21 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}106.nrrd -seg ${pathSeg}106.seg.nrrd -str 2 -sigst ${SigSt} -bn 22 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}106.nrrd -seg ${pathSeg}106.seg.nrrd -str 2 -sigst ${SigSt} -bn 34 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}106.nrrd -seg ${pathSeg}106.seg.nrrd -str 2 -sigst ${SigSt} -bn 8 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}106.nrrd -seg ${pathSeg}106.seg.nrrd -str 2 -sigst ${SigSt} -bn 9 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}107.nrrd -seg ${pathSeg}107.seg.nrrd -str 2 -sigst ${SigSt} -bn 42 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}107.nrrd -seg ${pathSeg}107.seg.nrrd -str 2 -sigst ${SigSt} -bn 45 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}107.nrrd -seg ${pathSeg}107.seg.nrrd -str 2 -sigst ${SigSt} -bn 29 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}107.nrrd -seg ${pathSeg}107.seg.nrrd -str 2 -sigst ${SigSt} -bn 50 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}107.nrrd -seg ${pathSeg}107.seg.nrrd -str 2 -sigst ${SigSt} -bn 31 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}107.nrrd -seg ${pathSeg}107.seg.nrrd -str 2 -sigst ${SigSt} -bn 48 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}107.nrrd -seg ${pathSeg}107.seg.nrrd -str 2 -sigst ${SigSt} -bn 32 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}107.nrrd -seg ${pathSeg}107.seg.nrrd -str 2 -sigst ${SigSt} -bn 30 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}107.nrrd -seg ${pathSeg}107.seg.nrrd -str 2 -sigst ${SigSt} -bn 12 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}108.nrrd -seg ${pathSeg}108.seg.nrrd -str 2 -sigst ${SigSt} -bn 64 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}108.nrrd -seg ${pathSeg}108.seg.nrrd -str 2 -sigst ${SigSt} -bn 58 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}108.nrrd -seg ${pathSeg}108.seg.nrrd -str 2 -sigst ${SigSt} -bn 69 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}108.nrrd -seg ${pathSeg}108.seg.nrrd -str 2 -sigst ${SigSt} -bn 65 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}108.nrrd -seg ${pathSeg}108.seg.nrrd -str 2 -sigst ${SigSt} -bn 54 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}108.nrrd -seg ${pathSeg}108.seg.nrrd -str 2 -sigst ${SigSt} -bn 44 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}108.nrrd -seg ${pathSeg}108.seg.nrrd -str 2 -sigst ${SigSt} -bn 35 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}108.nrrd -seg ${pathSeg}108.seg.nrrd -str 2 -sigst ${SigSt} -bn 38 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}108.nrrd -seg ${pathSeg}108.seg.nrrd -str 2 -sigst ${SigSt} -bn 39 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}108.nrrd -seg ${pathSeg}108.seg.nrrd -str 2 -sigst ${SigSt} -bn 6 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}109.nrrd -seg ${pathSeg}109.seg.nrrd -str 2 -sigst ${SigSt} -bn 51 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}109.nrrd -seg ${pathSeg}109.seg.nrrd -str 2 -sigst ${SigSt} -bn 48 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}109.nrrd -seg ${pathSeg}109.seg.nrrd -str 2 -sigst ${SigSt} -bn 47 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}109.nrrd -seg ${pathSeg}109.seg.nrrd -str 2 -sigst ${SigSt} -bn 32 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}109.nrrd -seg ${pathSeg}109.seg.nrrd -str 2 -sigst ${SigSt} -bn 34 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}109.nrrd -seg ${pathSeg}109.seg.nrrd -str 2 -sigst ${SigSt} -bn 37 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}109.nrrd -seg ${pathSeg}109.seg.nrrd -str 2 -sigst ${SigSt} -bn 29 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}109.nrrd -seg ${pathSeg}109.seg.nrrd -str 2 -sigst ${SigSt} -bn 23 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}109.nrrd -seg ${pathSeg}109.seg.nrrd -str 2 -sigst ${SigSt} -bn 8 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}110.nrrd -seg ${pathSeg}110.seg.nrrd -str 2 -sigst ${SigSt} -bn 57 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}110.nrrd -seg ${pathSeg}110.seg.nrrd -str 2 -sigst ${SigSt} -bn 40 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}110.nrrd -seg ${pathSeg}110.seg.nrrd -str 2 -sigst ${SigSt} -bn 39 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}110.nrrd -seg ${pathSeg}110.seg.nrrd -str 2 -sigst ${SigSt} -bn 52 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}110.nrrd -seg ${pathSeg}110.seg.nrrd -str 2 -sigst ${SigSt} -bn 50 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}110.nrrd -seg ${pathSeg}110.seg.nrrd -str 2 -sigst ${SigSt} -bn 36 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}110.nrrd -seg ${pathSeg}110.seg.nrrd -str 2 -sigst ${SigSt} -bn 31 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}110.nrrd -seg ${pathSeg}110.seg.nrrd -str 2 -sigst ${SigSt} -bn 28 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}110.nrrd -seg ${pathSeg}110.seg.nrrd -str 2 -sigst ${SigSt} -bn 11 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}111.nrrd -seg ${pathSeg}111.seg.nrrd -str 2 -sigst ${SigSt} -bn 312 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}111.nrrd -seg ${pathSeg}111.seg.nrrd -str 2 -sigst ${SigSt} -bn 320 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}111.nrrd -seg ${pathSeg}111.seg.nrrd -str 2 -sigst ${SigSt} -bn 300 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}111.nrrd -seg ${pathSeg}111.seg.nrrd -str 2 -sigst ${SigSt} -bn 314 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}111.nrrd -seg ${pathSeg}111.seg.nrrd -str 2 -sigst ${SigSt} -bn 214 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}111.nrrd -seg ${pathSeg}111.seg.nrrd -str 2 -sigst ${SigSt} -bn 184 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}112.nrrd -seg ${pathSeg}112.seg.nrrd -str 2 -sigst ${SigSt} -bn 126 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}112.nrrd -seg ${pathSeg}112.seg.nrrd -str 2 -sigst ${SigSt} -bn 87 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}112.nrrd -seg ${pathSeg}112.seg.nrrd -str 2 -sigst ${SigSt} -bn 120 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}112.nrrd -seg ${pathSeg}112.seg.nrrd -str 2 -sigst ${SigSt} -bn 135 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}112.nrrd -seg ${pathSeg}112.seg.nrrd -str 2 -sigst ${SigSt} -bn 106 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}112.nrrd -seg ${pathSeg}112.seg.nrrd -str 2 -sigst ${SigSt} -bn 45 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}112.nrrd -seg ${pathSeg}112.seg.nrrd -str 2 -sigst ${SigSt} -bn 69 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}112.nrrd -seg ${pathSeg}112.seg.nrrd -str 2 -sigst ${SigSt} -bn 31 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}112.nrrd -seg ${pathSeg}112.seg.nrrd -str 2 -sigst ${SigSt} -bn 54 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}113.nrrd -seg ${pathSeg}113.seg.nrrd -str 2 -sigst ${SigSt} -bn 78 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}113.nrrd -seg ${pathSeg}113.seg.nrrd -str 2 -sigst ${SigSt} -bn 52 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}113.nrrd -seg ${pathSeg}113.seg.nrrd -str 2 -sigst ${SigSt} -bn 79 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}113.nrrd -seg ${pathSeg}113.seg.nrrd -str 2 -sigst ${SigSt} -bn 67 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}113.nrrd -seg ${pathSeg}113.seg.nrrd -str 2 -sigst ${SigSt} -bn 25 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}113.nrrd -seg ${pathSeg}113.seg.nrrd -str 2 -sigst ${SigSt} -bn 34 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}113.nrrd -seg ${pathSeg}113.seg.nrrd -str 2 -sigst ${SigSt} -bn 26 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}113.nrrd -seg ${pathSeg}113.seg.nrrd -str 2 -sigst ${SigSt} -bn 56 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}113.nrrd -seg ${pathSeg}113.seg.nrrd -str 2 -sigst ${SigSt} -bn 4 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}114.nrrd -seg ${pathSeg}114.seg.nrrd -str 2 -sigst ${SigSt} -bn 76 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}114.nrrd -seg ${pathSeg}114.seg.nrrd -str 2 -sigst ${SigSt} -bn 71 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}114.nrrd -seg ${pathSeg}114.seg.nrrd -str 2 -sigst ${SigSt} -bn 41 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}114.nrrd -seg ${pathSeg}114.seg.nrrd -str 2 -sigst ${SigSt} -bn 59 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}114.nrrd -seg ${pathSeg}114.seg.nrrd -str 2 -sigst ${SigSt} -bn 73 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}114.nrrd -seg ${pathSeg}114.seg.nrrd -str 2 -sigst ${SigSt} -bn 28 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}114.nrrd -seg ${pathSeg}114.seg.nrrd -str 2 -sigst ${SigSt} -bn 32 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}114.nrrd -seg ${pathSeg}114.seg.nrrd -str 2 -sigst ${SigSt} -bn 24 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}114.nrrd -seg ${pathSeg}114.seg.nrrd -str 2 -sigst ${SigSt} -bn 21 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}115.nrrd -seg ${pathSeg}115.seg.nrrd -str 2 -sigst ${SigSt} -bn 66 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}115.nrrd -seg ${pathSeg}115.seg.nrrd -str 2 -sigst ${SigSt} -bn 48 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}115.nrrd -seg ${pathSeg}115.seg.nrrd -str 2 -sigst ${SigSt} -bn 90 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}115.nrrd -seg ${pathSeg}115.seg.nrrd -str 2 -sigst ${SigSt} -bn 45 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}115.nrrd -seg ${pathSeg}115.seg.nrrd -str 2 -sigst ${SigSt} -bn 42 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}115.nrrd -seg ${pathSeg}115.seg.nrrd -str 2 -sigst ${SigSt} -bn 29 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}115.nrrd -seg ${pathSeg}115.seg.nrrd -str 2 -sigst ${SigSt} -bn 17 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}115.nrrd -seg ${pathSeg}115.seg.nrrd -str 2 -sigst ${SigSt} -bn 12 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}115.nrrd -seg ${pathSeg}115.seg.nrrd -str 2 -sigst ${SigSt} -bn 25 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}116.nrrd -seg ${pathSeg}116.seg.nrrd -str 2 -sigst ${SigSt} -bn 79 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}116.nrrd -seg ${pathSeg}116.seg.nrrd -str 2 -sigst ${SigSt} -bn 77 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}116.nrrd -seg ${pathSeg}116.seg.nrrd -str 2 -sigst ${SigSt} -bn 49 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}116.nrrd -seg ${pathSeg}116.seg.nrrd -str 2 -sigst ${SigSt} -bn 64 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}116.nrrd -seg ${pathSeg}116.seg.nrrd -str 2 -sigst ${SigSt} -bn 48 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}116.nrrd -seg ${pathSeg}116.seg.nrrd -str 2 -sigst ${SigSt} -bn 58 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}116.nrrd -seg ${pathSeg}116.seg.nrrd -str 2 -sigst ${SigSt} -bn 31 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}116.nrrd -seg ${pathSeg}116.seg.nrrd -str 2 -sigst ${SigSt} -bn 23 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}116.nrrd -seg ${pathSeg}116.seg.nrrd -str 2 -sigst ${SigSt} -bn 25 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}117.nrrd -seg ${pathSeg}117.seg.nrrd -str 2 -sigst ${SigSt} -bn 167 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}117.nrrd -seg ${pathSeg}117.seg.nrrd -str 2 -sigst ${SigSt} -bn 121 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}117.nrrd -seg ${pathSeg}117.seg.nrrd -str 2 -sigst ${SigSt} -bn 106 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}117.nrrd -seg ${pathSeg}117.seg.nrrd -str 2 -sigst ${SigSt} -bn 104 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}117.nrrd -seg ${pathSeg}117.seg.nrrd -str 2 -sigst ${SigSt} -bn 110 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}117.nrrd -seg ${pathSeg}117.seg.nrrd -str 2 -sigst ${SigSt} -bn 97 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}117.nrrd -seg ${pathSeg}117.seg.nrrd -str 2 -sigst ${SigSt} -bn 71 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}117.nrrd -seg ${pathSeg}117.seg.nrrd -str 2 -sigst ${SigSt} -bn 77 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}117.nrrd -seg ${pathSeg}117.seg.nrrd -str 2 -sigst ${SigSt} -bn 40 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}118.nrrd -seg ${pathSeg}118.seg.nrrd -str 2 -sigst ${SigSt} -bn 54 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}118.nrrd -seg ${pathSeg}118.seg.nrrd -str 2 -sigst ${SigSt} -bn 53 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}118.nrrd -seg ${pathSeg}118.seg.nrrd -str 2 -sigst ${SigSt} -bn 59 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}118.nrrd -seg ${pathSeg}118.seg.nrrd -str 2 -sigst ${SigSt} -bn 47 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}118.nrrd -seg ${pathSeg}118.seg.nrrd -str 2 -sigst ${SigSt} -bn 74 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}118.nrrd -seg ${pathSeg}118.seg.nrrd -str 2 -sigst ${SigSt} -bn 40 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}118.nrrd -seg ${pathSeg}118.seg.nrrd -str 2 -sigst ${SigSt} -bn 39 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}118.nrrd -seg ${pathSeg}118.seg.nrrd -str 2 -sigst ${SigSt} -bn 26 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}118.nrrd -seg ${pathSeg}118.seg.nrrd -str 2 -sigst ${SigSt} -bn 27 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}118.nrrd -seg ${pathSeg}118.seg.nrrd -str 2 -sigst ${SigSt} -bn 18 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}118.nrrd -seg ${pathSeg}118.seg.nrrd -str 2 -sigst ${SigSt} -bn 49 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}118.nrrd -seg ${pathSeg}118.seg.nrrd -str 2 -sigst ${SigSt} -bn 5 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}119.nrrd -seg ${pathSeg}119.seg.nrrd -str 2 -sigst ${SigSt} -bn 99 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}119.nrrd -seg ${pathSeg}119.seg.nrrd -str 2 -sigst ${SigSt} -bn 118 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}119.nrrd -seg ${pathSeg}119.seg.nrrd -str 2 -sigst ${SigSt} -bn 107 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}119.nrrd -seg ${pathSeg}119.seg.nrrd -str 2 -sigst ${SigSt} -bn 65 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}119.nrrd -seg ${pathSeg}119.seg.nrrd -str 2 -sigst ${SigSt} -bn 77 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}119.nrrd -seg ${pathSeg}119.seg.nrrd -str 2 -sigst ${SigSt} -bn 3 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}120.nrrd -seg ${pathSeg}120.seg.nrrd -str 2 -sigst ${SigSt} -bn 62 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}120.nrrd -seg ${pathSeg}120.seg.nrrd -str 2 -sigst ${SigSt} -bn 77 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D} # Problem ?
          python model_add_ICA.py -i ${path}120.nrrd -seg ${pathSeg}120.seg.nrrd -str 2 -sigst ${SigSt} -bn 95 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}120.nrrd -seg ${pathSeg}120.seg.nrrd -str 2 -sigst ${SigSt} -bn 67 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}120.nrrd -seg ${pathSeg}120.seg.nrrd -str 2 -sigst ${SigSt} -bn 58 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}120.nrrd -seg ${pathSeg}120.seg.nrrd -str 2 -sigst ${SigSt} -bn 41 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}120.nrrd -seg ${pathSeg}120.seg.nrrd -str 2 -sigst ${SigSt} -bn 37 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}120.nrrd -seg ${pathSeg}120.seg.nrrd -str 2 -sigst ${SigSt} -bn 60 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}121.nrrd -seg ${pathSeg}121.seg.nrrd -str 2 -sigst ${SigSt} -bn 54 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}121.nrrd -seg ${pathSeg}121.seg.nrrd -str 2 -sigst ${SigSt} -bn 47 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}121.nrrd -seg ${pathSeg}121.seg.nrrd -str 2 -sigst ${SigSt} -bn 36 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}121.nrrd -seg ${pathSeg}121.seg.nrrd -str 2 -sigst ${SigSt} -bn 33 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}121.nrrd -seg ${pathSeg}121.seg.nrrd -str 2 -sigst ${SigSt} -bn 38 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}121.nrrd -seg ${pathSeg}121.seg.nrrd -str 2 -sigst ${SigSt} -bn 49 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}121.nrrd -seg ${pathSeg}121.seg.nrrd -str 2 -sigst ${SigSt} -bn 28 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}121.nrrd -seg ${pathSeg}121.seg.nrrd -str 2 -sigst ${SigSt} -bn 26 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}121.nrrd -seg ${pathSeg}121.seg.nrrd -str 2 -sigst ${SigSt} -bn 27 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}121.nrrd -seg ${pathSeg}121.seg.nrrd -str 2 -sigst ${SigSt} -bn 25 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}121.nrrd -seg ${pathSeg}121.seg.nrrd -str 2 -sigst ${SigSt} -bn 20 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}122.nrrd -seg ${pathSeg}122.seg.nrrd -str 2 -sigst ${SigSt} -bn 97 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}122.nrrd -seg ${pathSeg}122.seg.nrrd -str 2 -sigst ${SigSt} -bn 87 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}122.nrrd -seg ${pathSeg}122.seg.nrrd -str 2 -sigst ${SigSt} -bn 59 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}122.nrrd -seg ${pathSeg}122.seg.nrrd -str 2 -sigst ${SigSt} -bn 77 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}122.nrrd -seg ${pathSeg}122.seg.nrrd -str 2 -sigst ${SigSt} -bn 73 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}122.nrrd -seg ${pathSeg}122.seg.nrrd -str 2 -sigst ${SigSt} -bn 82 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}122.nrrd -seg ${pathSeg}122.seg.nrrd -str 2 -sigst ${SigSt} -bn 39 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}122.nrrd -seg ${pathSeg}122.seg.nrrd -str 2 -sigst ${SigSt} -bn 40 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}122.nrrd -seg ${pathSeg}122.seg.nrrd -str 2 -sigst ${SigSt} -bn 79 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}123.nrrd -seg ${pathSeg}123.seg.nrrd -str 2 -sigst ${SigSt} -bn 62 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}123.nrrd -seg ${pathSeg}123.seg.nrrd -str 2 -sigst ${SigSt} -bn 68 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}123.nrrd -seg ${pathSeg}123.seg.nrrd -str 2 -sigst ${SigSt} -bn 61 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}123.nrrd -seg ${pathSeg}123.seg.nrrd -str 2 -sigst ${SigSt} -bn 50 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}123.nrrd -seg ${pathSeg}123.seg.nrrd -str 2 -sigst ${SigSt} -bn 54 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}123.nrrd -seg ${pathSeg}123.seg.nrrd -str 2 -sigst ${SigSt} -bn 29 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}123.nrrd -seg ${pathSeg}123.seg.nrrd -str 2 -sigst ${SigSt} -bn 39 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

        #python model_add_ICA.py -i ${path}124.nrrd -seg ${pathSeg}124.seg.nrrd -str 2 -sigst ${SigSt} -bn 246 -fid 1 -cs 32 ## -> Noisy Segmentation
        #python model_add_ICA.py -i ${path}124.nrrd -seg ${pathSeg}124.seg.nrrd -str 2 -sigst ${SigSt} -bn 286 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
        #python model_add_ICA.py -i ${path}124.nrrd -seg ${pathSeg}124.seg.nrrd -str 2 -sigst ${SigSt} -bn 248 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
        #python model_add_ICA.py -i ${path}124.nrrd -seg ${pathSeg}124.seg.nrrd -str 2 -sigst ${SigSt} -bn 247 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
        #python model_add_ICA.py -i ${path}124.nrrd -seg ${pathSeg}124.seg.nrrd -str 2 -sigst ${SigSt} -bn 265 -fid 8 -cs 32 # <- ICA ?
        #python model_add_ICA.py -i ${path}124.nrrd -seg ${pathSeg}124.seg.nrrd -str 2 -sigst ${SigSt} -bn 203 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
        #python model_add_ICA.py -i ${path}124.nrrd -seg ${pathSeg}124.seg.nrrd -str 2 -sigst ${SigSt} -bn 148 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
        #python model_add_ICA.py -i ${path}124.nrrd -seg ${pathSeg}124.seg.nrrd -str 2 -sigst ${SigSt} -bn 165 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

        #python model_add_ICA.py -i ${path}125.nrrd -seg ${pathSeg}125.seg.nrrd -str 2 -sigst ${SigSt} -bn 186 -fid 1 -cs 32 ## -> Noisy Segmentation
        #python model_add_ICA.py -i ${path}125.nrrd -seg ${pathSeg}125.seg.nrrd -str 2 -sigst ${SigSt} -bn 193 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
        #python model_add_ICA.py -i ${path}125.nrrd -seg ${pathSeg}125.seg.nrrd -str 2 -sigst ${SigSt} -bn 114 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
        #python model_add_ICA.py -i ${path}125.nrrd -seg ${pathSeg}125.seg.nrrd -str 2 -sigst ${SigSt} -bn 152 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
        #python model_add_ICA.py -i ${path}125.nrrd -seg ${pathSeg}125.seg.nrrd -str 2 -sigst ${SigSt} -bn 163 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
        #python model_add_ICA.py -i ${path}125.nrrd -seg ${pathSeg}125.seg.nrrd -str 2 -sigst ${SigSt} -bn 168 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
        #python model_add_ICA.py -i ${path}125.nrrd -seg ${pathSeg}125.seg.nrrd -str 2 -sigst ${SigSt} -bn 109 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
        #python model_add_ICA.py -i ${path}125.nrrd -seg ${pathSeg}125.seg.nrrd -str 2 -sigst ${SigSt} -bn 151 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
        #python model_add_ICA.py -i ${path}125.nrrd -seg ${pathSeg}125.seg.nrrd -str 2 -sigst ${SigSt} -bn 150 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
        #python model_add_ICA.py -i ${path}125.nrrd -seg ${pathSeg}125.seg.nrrd -str 2 -sigst ${SigSt} -bn 170 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}126.nrrd -seg ${pathSeg}126.seg.nrrd -str 2 -sigst ${SigSt} -bn 212 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}126.nrrd -seg ${pathSeg}126.seg.nrrd -str 2 -sigst ${SigSt} -bn 225 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}126.nrrd -seg ${pathSeg}126.seg.nrrd -str 2 -sigst ${SigSt} -bn 214 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}126.nrrd -seg ${pathSeg}126.seg.nrrd -str 2 -sigst ${SigSt} -bn 204 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}126.nrrd -seg ${pathSeg}126.seg.nrrd -str 2 -sigst ${SigSt} -bn 230 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}126.nrrd -seg ${pathSeg}126.seg.nrrd -str 2 -sigst ${SigSt} -bn 223 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}126.nrrd -seg ${pathSeg}126.seg.nrrd -str 2 -sigst ${SigSt} -bn 164 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}126.nrrd -seg ${pathSeg}126.seg.nrrd -str 2 -sigst ${SigSt} -bn 96 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}126.nrrd -seg ${pathSeg}126.seg.nrrd -str 2 -sigst ${SigSt} -bn 113 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}126.nrrd -seg ${pathSeg}126.seg.nrrd -str 2 -sigst ${SigSt} -bn 98 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}126.nrrd -seg ${pathSeg}126.seg.nrrd -str 2 -sigst ${SigSt} -bn 18 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}127.nrrd -seg ${pathSeg}127.seg.nrrd -str 2 -sigst ${SigSt} -bn 65 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}127.nrrd -seg ${pathSeg}127.seg.nrrd -str 2 -sigst ${SigSt} -bn 58 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}127.nrrd -seg ${pathSeg}127.seg.nrrd -str 2 -sigst ${SigSt} -bn 64 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}127.nrrd -seg ${pathSeg}127.seg.nrrd -str 2 -sigst ${SigSt} -bn 34 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}127.nrrd -seg ${pathSeg}127.seg.nrrd -str 2 -sigst ${SigSt} -bn 62 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}127.nrrd -seg ${pathSeg}127.seg.nrrd -str 2 -sigst ${SigSt} -bn 33 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}127.nrrd -seg ${pathSeg}127.seg.nrrd -str 2 -sigst ${SigSt} -bn 32 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}127.nrrd -seg ${pathSeg}127.seg.nrrd -str 2 -sigst ${SigSt} -bn 21 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}128.nrrd -seg ${pathSeg}128.seg.nrrd -str 2 -sigst ${SigSt} -bn 83 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}128.nrrd -seg ${pathSeg}128.seg.nrrd -str 2 -sigst ${SigSt} -bn 81 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}128.nrrd -seg ${pathSeg}128.seg.nrrd -str 2 -sigst ${SigSt} -bn 80 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}128.nrrd -seg ${pathSeg}128.seg.nrrd -str 2 -sigst ${SigSt} -bn 78 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}128.nrrd -seg ${pathSeg}128.seg.nrrd -str 2 -sigst ${SigSt} -bn 73 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}128.nrrd -seg ${pathSeg}128.seg.nrrd -str 2 -sigst ${SigSt} -bn 61 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}128.nrrd -seg ${pathSeg}128.seg.nrrd -str 2 -sigst ${SigSt} -bn 62 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}128.nrrd -seg ${pathSeg}128.seg.nrrd -str 2 -sigst ${SigSt} -bn 72 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}128.nrrd -seg ${pathSeg}128.seg.nrrd -str 2 -sigst ${SigSt} -bn 27 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}129.nrrd -seg ${pathSeg}129.seg.nrrd -str 2 -sigst ${SigSt} -bn 98 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}129.nrrd -seg ${pathSeg}129.seg.nrrd -str 2 -sigst ${SigSt} -bn 107 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}129.nrrd -seg ${pathSeg}129.seg.nrrd -str 2 -sigst ${SigSt} -bn 90 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}129.nrrd -seg ${pathSeg}129.seg.nrrd -str 2 -sigst ${SigSt} -bn 76 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}129.nrrd -seg ${pathSeg}129.seg.nrrd -str 2 -sigst ${SigSt} -bn 62 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}129.nrrd -seg ${pathSeg}129.seg.nrrd -str 2 -sigst ${SigSt} -bn 68 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}129.nrrd -seg ${pathSeg}129.seg.nrrd -str 2 -sigst ${SigSt} -bn 48 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}129.nrrd -seg ${pathSeg}129.seg.nrrd -str 2 -sigst ${SigSt} -bn 88 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}129.nrrd -seg ${pathSeg}129.seg.nrrd -str 2 -sigst ${SigSt} -bn 10 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}130.nrrd -seg ${pathSeg}130.seg.nrrd -str 2 -sigst ${SigSt} -bn 51 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}130.nrrd -seg ${pathSeg}130.seg.nrrd -str 2 -sigst ${SigSt} -bn 52 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}130.nrrd -seg ${pathSeg}130.seg.nrrd -str 2 -sigst ${SigSt} -bn 46 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}130.nrrd -seg ${pathSeg}130.seg.nrrd -str 2 -sigst ${SigSt} -bn 49 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}130.nrrd -seg ${pathSeg}130.seg.nrrd -str 2 -sigst ${SigSt} -bn 44 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}130.nrrd -seg ${pathSeg}130.seg.nrrd -str 2 -sigst ${SigSt} -bn 57 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}130.nrrd -seg ${pathSeg}130.seg.nrrd -str 2 -sigst ${SigSt} -bn 43 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}130.nrrd -seg ${pathSeg}130.seg.nrrd -str 2 -sigst ${SigSt} -bn 30 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}130.nrrd -seg ${pathSeg}130.seg.nrrd -str 2 -sigst ${SigSt} -bn 32 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}130.nrrd -seg ${pathSeg}130.seg.nrrd -str 2 -sigst ${SigSt} -bn 17 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}130.nrrd -seg ${pathSeg}130.seg.nrrd -str 2 -sigst ${SigSt} -bn 14 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}131.nrrd -seg ${pathSeg}131.seg.nrrd -str 2 -sigst ${SigSt} -bn 162 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}131.nrrd -seg ${pathSeg}131.seg.nrrd -str 2 -sigst ${SigSt} -bn 157 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}131.nrrd -seg ${pathSeg}131.seg.nrrd -str 2 -sigst ${SigSt} -bn 158 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}131.nrrd -seg ${pathSeg}131.seg.nrrd -str 2 -sigst ${SigSt} -bn 166 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}131.nrrd -seg ${pathSeg}131.seg.nrrd -str 2 -sigst ${SigSt} -bn 146 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}132.nrrd -seg ${pathSeg}132.seg.nrrd -str 2 -sigst ${SigSt} -bn 50 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}132.nrrd -seg ${pathSeg}132.seg.nrrd -str 2 -sigst ${SigSt} -bn 56 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}132.nrrd -seg ${pathSeg}132.seg.nrrd -str 2 -sigst ${SigSt} -bn 47 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}132.nrrd -seg ${pathSeg}132.seg.nrrd -str 2 -sigst ${SigSt} -bn 46 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}133.nrrd -seg ${pathSeg}133.seg.nrrd -str 2 -sigst ${SigSt} -bn 98 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}133.nrrd -seg ${pathSeg}133.seg.nrrd -str 2 -sigst ${SigSt} -bn 95 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}133.nrrd -seg ${pathSeg}133.seg.nrrd -str 2 -sigst ${SigSt} -bn 88 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}133.nrrd -seg ${pathSeg}133.seg.nrrd -str 2 -sigst ${SigSt} -bn 74 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}133.nrrd -seg ${pathSeg}133.seg.nrrd -str 2 -sigst ${SigSt} -bn 76 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}133.nrrd -seg ${pathSeg}133.seg.nrrd -str 2 -sigst ${SigSt} -bn 45 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}133.nrrd -seg ${pathSeg}133.seg.nrrd -str 2 -sigst ${SigSt} -bn 27 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}133.nrrd -seg ${pathSeg}133.seg.nrrd -str 2 -sigst ${SigSt} -bn 38 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}133.nrrd -seg ${pathSeg}133.seg.nrrd -str 2 -sigst ${SigSt} -bn 66 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}134.nrrd -seg ${pathSeg}134.seg.nrrd -str 2 -sigst ${SigSt} -bn 68 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}134.nrrd -seg ${pathSeg}134.seg.nrrd -str 2 -sigst ${SigSt} -bn 75 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}134.nrrd -seg ${pathSeg}134.seg.nrrd -str 2 -sigst ${SigSt} -bn 55 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}134.nrrd -seg ${pathSeg}134.seg.nrrd -str 2 -sigst ${SigSt} -bn 87 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}134.nrrd -seg ${pathSeg}134.seg.nrrd -str 2 -sigst ${SigSt} -bn 60 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}134.nrrd -seg ${pathSeg}134.seg.nrrd -str 2 -sigst ${SigSt} -bn 49 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}134.nrrd -seg ${pathSeg}134.seg.nrrd -str 2 -sigst ${SigSt} -bn 34 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}134.nrrd -seg ${pathSeg}134.seg.nrrd -str 2 -sigst ${SigSt} -bn 56 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}134.nrrd -seg ${pathSeg}134.seg.nrrd -str 2 -sigst ${SigSt} -bn 12 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}134.nrrd -seg ${pathSeg}134.seg.nrrd -str 2 -sigst ${SigSt} -bn 13 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}135.nrrd -seg ${pathSeg}135.seg.nrrd -str 2 -sigst ${SigSt} -bn 96 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}135.nrrd -seg ${pathSeg}135.seg.nrrd -str 2 -sigst ${SigSt} -bn 107 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}135.nrrd -seg ${pathSeg}135.seg.nrrd -str 2 -sigst ${SigSt} -bn 82 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}135.nrrd -seg ${pathSeg}135.seg.nrrd -str 2 -sigst ${SigSt} -bn 83 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}135.nrrd -seg ${pathSeg}135.seg.nrrd -str 2 -sigst ${SigSt} -bn 87 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}135.nrrd -seg ${pathSeg}135.seg.nrrd -str 2 -sigst ${SigSt} -bn 26 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}135.nrrd -seg ${pathSeg}135.seg.nrrd -str 2 -sigst ${SigSt} -bn 20 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}136.nrrd -seg ${pathSeg}136.seg.nrrd -str 2 -sigst ${SigSt} -bn 104 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}136.nrrd -seg ${pathSeg}136.seg.nrrd -str 2 -sigst ${SigSt} -bn 94 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}136.nrrd -seg ${pathSeg}136.seg.nrrd -str 2 -sigst ${SigSt} -bn 75 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}136.nrrd -seg ${pathSeg}136.seg.nrrd -str 2 -sigst ${SigSt} -bn 87 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
        #python model_add_ICA.py -i ${path}136.nrrd -seg ${pathSeg}136.seg.nrrd -str 2 -sigst ${SigSt} -bn 96 -fid 8 -cs 32 # <- ICA ?
          python model_add_ICA.py -i ${path}136.nrrd -seg ${pathSeg}136.seg.nrrd -str 2 -sigst ${SigSt} -bn 64 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}136.nrrd -seg ${pathSeg}136.seg.nrrd -str 2 -sigst ${SigSt} -bn 66 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}136.nrrd -seg ${pathSeg}136.seg.nrrd -str 2 -sigst ${SigSt} -bn 67 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}136.nrrd -seg ${pathSeg}136.seg.nrrd -str 2 -sigst ${SigSt} -bn 38 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}136.nrrd -seg ${pathSeg}136.seg.nrrd -str 2 -sigst ${SigSt} -bn 41 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}137.nrrd -seg ${pathSeg}137.seg.nrrd -str 2 -sigst ${SigSt} -bn 117 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}137.nrrd -seg ${pathSeg}137.seg.nrrd -str 2 -sigst ${SigSt} -bn 114 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}137.nrrd -seg ${pathSeg}137.seg.nrrd -str 2 -sigst ${SigSt} -bn 129 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}137.nrrd -seg ${pathSeg}137.seg.nrrd -str 2 -sigst ${SigSt} -bn 91 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}137.nrrd -seg ${pathSeg}137.seg.nrrd -str 2 -sigst ${SigSt} -bn 77 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}137.nrrd -seg ${pathSeg}137.seg.nrrd -str 2 -sigst ${SigSt} -bn 72 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}137.nrrd -seg ${pathSeg}137.seg.nrrd -str 2 -sigst ${SigSt} -bn 108 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}137.nrrd -seg ${pathSeg}137.seg.nrrd -str 2 -sigst ${SigSt} -bn 32 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}138.nrrd -seg ${pathSeg}138.seg.nrrd -str 2 -sigst ${SigSt} -bn 43 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}138.nrrd -seg ${pathSeg}138.seg.nrrd -str 2 -sigst ${SigSt} -bn 33 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}138.nrrd -seg ${pathSeg}138.seg.nrrd -str 2 -sigst ${SigSt} -bn 59 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}138.nrrd -seg ${pathSeg}138.seg.nrrd -str 2 -sigst ${SigSt} -bn 32 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}138.nrrd -seg ${pathSeg}138.seg.nrrd -str 2 -sigst ${SigSt} -bn 21 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}138.nrrd -seg ${pathSeg}138.seg.nrrd -str 2 -sigst ${SigSt} -bn 25 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}139.nrrd -seg ${pathSeg}139.seg.nrrd -str 2 -sigst ${SigSt} -bn 96 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}139.nrrd -seg ${pathSeg}139.seg.nrrd -str 2 -sigst ${SigSt} -bn 75 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}139.nrrd -seg ${pathSeg}139.seg.nrrd -str 2 -sigst ${SigSt} -bn 86 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}139.nrrd -seg ${pathSeg}139.seg.nrrd -str 2 -sigst ${SigSt} -bn 101 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}139.nrrd -seg ${pathSeg}139.seg.nrrd -str 2 -sigst ${SigSt} -bn 58 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}139.nrrd -seg ${pathSeg}139.seg.nrrd -str 2 -sigst ${SigSt} -bn 63 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}139.nrrd -seg ${pathSeg}139.seg.nrrd -str 2 -sigst ${SigSt} -bn 40 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}139.nrrd -seg ${pathSeg}139.seg.nrrd -str 2 -sigst ${SigSt} -bn 45 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}139.nrrd -seg ${pathSeg}139.seg.nrrd -str 2 -sigst ${SigSt} -bn 72 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}139.nrrd -seg ${pathSeg}139.seg.nrrd -str 2 -sigst ${SigSt} -bn 16 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}140.nrrd -seg ${pathSeg}140.seg.nrrd -str 2 -sigst ${SigSt} -bn 77 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}140.nrrd -seg ${pathSeg}140.seg.nrrd -str 2 -sigst ${SigSt} -bn 90 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}140.nrrd -seg ${pathSeg}140.seg.nrrd -str 2 -sigst ${SigSt} -bn 54 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}140.nrrd -seg ${pathSeg}140.seg.nrrd -str 2 -sigst ${SigSt} -bn 61 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}140.nrrd -seg ${pathSeg}140.seg.nrrd -str 2 -sigst ${SigSt} -bn 37 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}140.nrrd -seg ${pathSeg}140.seg.nrrd -str 2 -sigst ${SigSt} -bn 59 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}140.nrrd -seg ${pathSeg}140.seg.nrrd -str 2 -sigst ${SigSt} -bn 35 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}140.nrrd -seg ${pathSeg}140.seg.nrrd -str 2 -sigst ${SigSt} -bn 22 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}140.nrrd -seg ${pathSeg}140.seg.nrrd -str 2 -sigst ${SigSt} -bn 16 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}140.nrrd -seg ${pathSeg}140.seg.nrrd -str 2 -sigst ${SigSt} -bn 27 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}141.nrrd -seg ${pathSeg}141.seg.nrrd -str 2 -sigst ${SigSt} -bn 86 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}141.nrrd -seg ${pathSeg}141.seg.nrrd -str 2 -sigst ${SigSt} -bn 85 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}141.nrrd -seg ${pathSeg}141.seg.nrrd -str 2 -sigst ${SigSt} -bn 69 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}141.nrrd -seg ${pathSeg}141.seg.nrrd -str 2 -sigst ${SigSt} -bn 60 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}141.nrrd -seg ${pathSeg}141.seg.nrrd -str 2 -sigst ${SigSt} -bn 71 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}141.nrrd -seg ${pathSeg}141.seg.nrrd -str 2 -sigst ${SigSt} -bn 54 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}141.nrrd -seg ${pathSeg}141.seg.nrrd -str 2 -sigst ${SigSt} -bn 47 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}141.nrrd -seg ${pathSeg}141.seg.nrrd -str 2 -sigst ${SigSt} -bn 33 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}141.nrrd -seg ${pathSeg}141.seg.nrrd -str 2 -sigst ${SigSt} -bn 34 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}141.nrrd -seg ${pathSeg}141.seg.nrrd -str 2 -sigst ${SigSt} -bn 42 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}142.nrrd -seg ${pathSeg}142.seg.nrrd -str 2 -sigst ${SigSt} -bn 46 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}142.nrrd -seg ${pathSeg}142.seg.nrrd -str 2 -sigst ${SigSt} -bn 50 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}142.nrrd -seg ${pathSeg}142.seg.nrrd -str 2 -sigst ${SigSt} -bn 65 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}142.nrrd -seg ${pathSeg}142.seg.nrrd -str 2 -sigst ${SigSt} -bn 57 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}142.nrrd -seg ${pathSeg}142.seg.nrrd -str 2 -sigst ${SigSt} -bn 62 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}142.nrrd -seg ${pathSeg}142.seg.nrrd -str 2 -sigst ${SigSt} -bn 45 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}142.nrrd -seg ${pathSeg}142.seg.nrrd -str 2 -sigst ${SigSt} -bn 43 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}142.nrrd -seg ${pathSeg}142.seg.nrrd -str 2 -sigst ${SigSt} -bn 28 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}142.nrrd -seg ${pathSeg}142.seg.nrrd -str 2 -sigst ${SigSt} -bn 33 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}142.nrrd -seg ${pathSeg}142.seg.nrrd -str 2 -sigst ${SigSt} -bn 48 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}142.nrrd -seg ${pathSeg}142.seg.nrrd -str 2 -sigst ${SigSt} -bn 4 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}142.nrrd -seg ${pathSeg}142.seg.nrrd -str 2 -sigst ${SigSt} -bn 11 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}143.nrrd -seg ${pathSeg}143.seg.nrrd -str 2 -sigst ${SigSt} -bn 27 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}143.nrrd -seg ${pathSeg}143.seg.nrrd -str 2 -sigst ${SigSt} -bn 36 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}143.nrrd -seg ${pathSeg}143.seg.nrrd -str 2 -sigst ${SigSt} -bn 49 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}143.nrrd -seg ${pathSeg}143.seg.nrrd -str 2 -sigst ${SigSt} -bn 72 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}143.nrrd -seg ${pathSeg}143.seg.nrrd -str 2 -sigst ${SigSt} -bn 23 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}144.nrrd -seg ${pathSeg}144.seg.nrrd -str 2 -sigst ${SigSt} -bn 119 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}144.nrrd -seg ${pathSeg}144.seg.nrrd -str 2 -sigst ${SigSt} -bn 117 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}144.nrrd -seg ${pathSeg}144.seg.nrrd -str 2 -sigst ${SigSt} -bn 118 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}144.nrrd -seg ${pathSeg}144.seg.nrrd -str 2 -sigst ${SigSt} -bn 90 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}144.nrrd -seg ${pathSeg}144.seg.nrrd -str 2 -sigst ${SigSt} -bn 106 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}145.nrrd -seg ${pathSeg}145.seg.nrrd -str 2 -sigst ${SigSt} -bn 84 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}145.nrrd -seg ${pathSeg}145.seg.nrrd -str 2 -sigst ${SigSt} -bn 124 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}145.nrrd -seg ${pathSeg}145.seg.nrrd -str 2 -sigst ${SigSt} -bn 88 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}145.nrrd -seg ${pathSeg}145.seg.nrrd -str 2 -sigst ${SigSt} -bn 120 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}145.nrrd -seg ${pathSeg}145.seg.nrrd -str 2 -sigst ${SigSt} -bn 134 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}146.nrrd -seg ${pathSeg}146.seg.nrrd -str 2 -sigst ${SigSt} -bn 98 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}146.nrrd -seg ${pathSeg}146.seg.nrrd -str 2 -sigst ${SigSt} -bn 83 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}146.nrrd -seg ${pathSeg}146.seg.nrrd -str 2 -sigst ${SigSt} -bn 81 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}146.nrrd -seg ${pathSeg}146.seg.nrrd -str 2 -sigst ${SigSt} -bn 85 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}146.nrrd -seg ${pathSeg}146.seg.nrrd -str 2 -sigst ${SigSt} -bn 73 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}146.nrrd -seg ${pathSeg}146.seg.nrrd -str 2 -sigst ${SigSt} -bn 68 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}146.nrrd -seg ${pathSeg}146.seg.nrrd -str 2 -sigst ${SigSt} -bn 70 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}147.nrrd -seg ${pathSeg}147.seg.nrrd -str 2 -sigst ${SigSt} -bn 40 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}147.nrrd -seg ${pathSeg}147.seg.nrrd -str 2 -sigst ${SigSt} -bn 36 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}147.nrrd -seg ${pathSeg}147.seg.nrrd -str 2 -sigst ${SigSt} -bn 43 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}147.nrrd -seg ${pathSeg}147.seg.nrrd -str 2 -sigst ${SigSt} -bn 19 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}147.nrrd -seg ${pathSeg}147.seg.nrrd -str 2 -sigst ${SigSt} -bn 23 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}149.nrrd -seg ${pathSeg}149.seg.nrrd -str 2 -sigst ${SigSt} -bn 63 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}149.nrrd -seg ${pathSeg}149.seg.nrrd -str 2 -sigst ${SigSt} -bn 55 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}149.nrrd -seg ${pathSeg}149.seg.nrrd -str 2 -sigst ${SigSt} -bn 65 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}149.nrrd -seg ${pathSeg}149.seg.nrrd -str 2 -sigst ${SigSt} -bn 24 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}149.nrrd -seg ${pathSeg}149.seg.nrrd -str 2 -sigst ${SigSt} -bn 56 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}149.nrrd -seg ${pathSeg}149.seg.nrrd -str 2 -sigst ${SigSt} -bn 38 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}149.nrrd -seg ${pathSeg}149.seg.nrrd -str 2 -sigst ${SigSt} -bn 40 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}149.nrrd -seg ${pathSeg}149.seg.nrrd -str 2 -sigst ${SigSt} -bn 22 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}150.nrrd -seg ${pathSeg}150.seg.nrrd -str 2 -sigst ${SigSt} -bn 56 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}150.nrrd -seg ${pathSeg}150.seg.nrrd -str 2 -sigst ${SigSt} -bn 55 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}150.nrrd -seg ${pathSeg}150.seg.nrrd -str 2 -sigst ${SigSt} -bn 39 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}150.nrrd -seg ${pathSeg}150.seg.nrrd -str 2 -sigst ${SigSt} -bn 54 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}150.nrrd -seg ${pathSeg}150.seg.nrrd -str 2 -sigst ${SigSt} -bn 64 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}150.nrrd -seg ${pathSeg}150.seg.nrrd -str 2 -sigst ${SigSt} -bn 24 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}150.nrrd -seg ${pathSeg}150.seg.nrrd -str 2 -sigst ${SigSt} -bn 32 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}150.nrrd -seg ${pathSeg}150.seg.nrrd -str 2 -sigst ${SigSt} -bn 38 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}150.nrrd -seg ${pathSeg}150.seg.nrrd -str 2 -sigst ${SigSt} -bn 6 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}151.nrrd -seg ${pathSeg}151.seg.nrrd -str 2 -sigst ${SigSt} -bn 46 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}151.nrrd -seg ${pathSeg}151.seg.nrrd -str 2 -sigst ${SigSt} -bn 55 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}151.nrrd -seg ${pathSeg}151.seg.nrrd -str 2 -sigst ${SigSt} -bn 50 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}151.nrrd -seg ${pathSeg}151.seg.nrrd -str 2 -sigst ${SigSt} -bn 53 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}151.nrrd -seg ${pathSeg}151.seg.nrrd -str 2 -sigst ${SigSt} -bn 33 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}151.nrrd -seg ${pathSeg}151.seg.nrrd -str 2 -sigst ${SigSt} -bn 30 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}151.nrrd -seg ${pathSeg}151.seg.nrrd -str 2 -sigst ${SigSt} -bn 24 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}151.nrrd -seg ${pathSeg}151.seg.nrrd -str 2 -sigst ${SigSt} -bn 10 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}151.nrrd -seg ${pathSeg}151.seg.nrrd -str 2 -sigst ${SigSt} -bn 14 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}151.nrrd -seg ${pathSeg}151.seg.nrrd -str 2 -sigst ${SigSt} -bn 11 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}152.nrrd -seg ${pathSeg}152.seg.nrrd -str 2 -sigst ${SigSt} -bn 32 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}152.nrrd -seg ${pathSeg}152.seg.nrrd -str 2 -sigst ${SigSt} -bn 47 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}152.nrrd -seg ${pathSeg}152.seg.nrrd -str 2 -sigst ${SigSt} -bn 53 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}152.nrrd -seg ${pathSeg}152.seg.nrrd -str 2 -sigst ${SigSt} -bn 66 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}152.nrrd -seg ${pathSeg}152.seg.nrrd -str 2 -sigst ${SigSt} -bn 28 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}152.nrrd -seg ${pathSeg}152.seg.nrrd -str 2 -sigst ${SigSt} -bn 29 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}152.nrrd -seg ${pathSeg}152.seg.nrrd -str 2 -sigst ${SigSt} -bn 24 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}152.nrrd -seg ${pathSeg}152.seg.nrrd -str 2 -sigst ${SigSt} -bn 58 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}152.nrrd -seg ${pathSeg}152.seg.nrrd -str 2 -sigst ${SigSt} -bn 4 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}153.nrrd -seg ${pathSeg}153.seg.nrrd -str 2 -sigst ${SigSt} -bn 37 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}153.nrrd -seg ${pathSeg}153.seg.nrrd -str 2 -sigst ${SigSt} -bn 64 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}153.nrrd -seg ${pathSeg}153.seg.nrrd -str 2 -sigst ${SigSt} -bn 74 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}153.nrrd -seg ${pathSeg}153.seg.nrrd -str 2 -sigst ${SigSt} -bn 88 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}153.nrrd -seg ${pathSeg}153.seg.nrrd -str 2 -sigst ${SigSt} -bn 69 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}153.nrrd -seg ${pathSeg}153.seg.nrrd -str 2 -sigst ${SigSt} -bn 60 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}154.nrrd -seg ${pathSeg}154.seg.nrrd -str 2 -sigst ${SigSt} -bn 80 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}154.nrrd -seg ${pathSeg}154.seg.nrrd -str 2 -sigst ${SigSt} -bn 61 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}154.nrrd -seg ${pathSeg}154.seg.nrrd -str 2 -sigst ${SigSt} -bn 62 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}154.nrrd -seg ${pathSeg}154.seg.nrrd -str 2 -sigst ${SigSt} -bn 30 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}154.nrrd -seg ${pathSeg}154.seg.nrrd -str 2 -sigst ${SigSt} -bn 38 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}154.nrrd -seg ${pathSeg}154.seg.nrrd -str 2 -sigst ${SigSt} -bn 12 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}154.nrrd -seg ${pathSeg}154.seg.nrrd -str 2 -sigst ${SigSt} -bn 28 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}154.nrrd -seg ${pathSeg}154.seg.nrrd -str 2 -sigst ${SigSt} -bn 4 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}155.nrrd -seg ${pathSeg}155.seg.nrrd -str 2 -sigst ${SigSt} -bn 68 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}155.nrrd -seg ${pathSeg}155.seg.nrrd -str 2 -sigst ${SigSt} -bn 101 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}155.nrrd -seg ${pathSeg}155.seg.nrrd -str 2 -sigst ${SigSt} -bn 70 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}155.nrrd -seg ${pathSeg}155.seg.nrrd -str 2 -sigst ${SigSt} -bn 75 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}155.nrrd -seg ${pathSeg}155.seg.nrrd -str 2 -sigst ${SigSt} -bn 73 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}155.nrrd -seg ${pathSeg}155.seg.nrrd -str 2 -sigst ${SigSt} -bn 92 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}155.nrrd -seg ${pathSeg}155.seg.nrrd -str 2 -sigst ${SigSt} -bn 45 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}155.nrrd -seg ${pathSeg}155.seg.nrrd -str 2 -sigst ${SigSt} -bn 46 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}155.nrrd -seg ${pathSeg}155.seg.nrrd -str 2 -sigst ${SigSt} -bn 43 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}155.nrrd -seg ${pathSeg}155.seg.nrrd -str 2 -sigst ${SigSt} -bn 40 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}156.nrrd -seg ${pathSeg}156.seg.nrrd -str 2 -sigst ${SigSt} -bn 36 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}156.nrrd -seg ${pathSeg}156.seg.nrrd -str 2 -sigst ${SigSt} -bn 41 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}156.nrrd -seg ${pathSeg}156.seg.nrrd -str 2 -sigst ${SigSt} -bn 12 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}156.nrrd -seg ${pathSeg}156.seg.nrrd -str 2 -sigst ${SigSt} -bn 18 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}158.nrrd -seg ${pathSeg}158.seg.nrrd -str 2 -sigst ${SigSt} -bn 110 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}158.nrrd -seg ${pathSeg}158.seg.nrrd -str 2 -sigst ${SigSt} -bn 96 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}158.nrrd -seg ${pathSeg}158.seg.nrrd -str 2 -sigst ${SigSt} -bn 92 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}158.nrrd -seg ${pathSeg}158.seg.nrrd -str 2 -sigst ${SigSt} -bn 94 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}158.nrrd -seg ${pathSeg}158.seg.nrrd -str 2 -sigst ${SigSt} -bn 115 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}158.nrrd -seg ${pathSeg}158.seg.nrrd -str 2 -sigst ${SigSt} -bn 104 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}158.nrrd -seg ${pathSeg}158.seg.nrrd -str 2 -sigst ${SigSt} -bn 81 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}158.nrrd -seg ${pathSeg}158.seg.nrrd -str 2 -sigst ${SigSt} -bn 79 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}158.nrrd -seg ${pathSeg}158.seg.nrrd -str 2 -sigst ${SigSt} -bn 66 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}158.nrrd -seg ${pathSeg}158.seg.nrrd -str 2 -sigst ${SigSt} -bn 62 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}158.nrrd -seg ${pathSeg}158.seg.nrrd -str 2 -sigst ${SigSt} -bn 60 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}158.nrrd -seg ${pathSeg}158.seg.nrrd -str 2 -sigst ${SigSt} -bn 20 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}159.nrrd -seg ${pathSeg}159.seg.nrrd -str 2 -sigst ${SigSt} -bn 54 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}159.nrrd -seg ${pathSeg}159.seg.nrrd -str 2 -sigst ${SigSt} -bn 60 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}159.nrrd -seg ${pathSeg}159.seg.nrrd -str 2 -sigst ${SigSt} -bn 55 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}159.nrrd -seg ${pathSeg}159.seg.nrrd -str 2 -sigst ${SigSt} -bn 68 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}159.nrrd -seg ${pathSeg}159.seg.nrrd -str 2 -sigst ${SigSt} -bn 45 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}159.nrrd -seg ${pathSeg}159.seg.nrrd -str 2 -sigst ${SigSt} -bn 63 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}159.nrrd -seg ${pathSeg}159.seg.nrrd -str 2 -sigst ${SigSt} -bn 46 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}159.nrrd -seg ${pathSeg}159.seg.nrrd -str 2 -sigst ${SigSt} -bn 49 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}159.nrrd -seg ${pathSeg}159.seg.nrrd -str 2 -sigst ${SigSt} -bn 41 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}159.nrrd -seg ${pathSeg}159.seg.nrrd -str 2 -sigst ${SigSt} -bn 42 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}159.nrrd -seg ${pathSeg}159.seg.nrrd -str 2 -sigst ${SigSt} -bn 18 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}160.nrrd -seg ${pathSeg}160.seg.nrrd -str 2 -sigst ${SigSt} -bn 38 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}160.nrrd -seg ${pathSeg}160.seg.nrrd -str 2 -sigst ${SigSt} -bn 57 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}160.nrrd -seg ${pathSeg}160.seg.nrrd -str 2 -sigst ${SigSt} -bn 58 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}160.nrrd -seg ${pathSeg}160.seg.nrrd -str 2 -sigst ${SigSt} -bn 36 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}160.nrrd -seg ${pathSeg}160.seg.nrrd -str 2 -sigst ${SigSt} -bn 67 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}161.nrrd -seg ${pathSeg}161.seg.nrrd -str 2 -sigst ${SigSt} -bn 119 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}161.nrrd -seg ${pathSeg}161.seg.nrrd -str 2 -sigst ${SigSt} -bn 134 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}161.nrrd -seg ${pathSeg}161.seg.nrrd -str 2 -sigst ${SigSt} -bn 95 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}161.nrrd -seg ${pathSeg}161.seg.nrrd -str 2 -sigst ${SigSt} -bn 131 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
        #python model_add_ICA.py -i ${path}161.nrrd -seg ${pathSeg}161.seg.nrrd -str 2 -sigst ${SigSt} -bn 87 -fid 9 -cs 32 # <- ICA ?
          python model_add_ICA.py -i ${path}161.nrrd -seg ${pathSeg}161.seg.nrrd -str 2 -sigst ${SigSt} -bn 86 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}161.nrrd -seg ${pathSeg}161.seg.nrrd -str 2 -sigst ${SigSt} -bn 66 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}161.nrrd -seg ${pathSeg}161.seg.nrrd -str 2 -sigst ${SigSt} -bn 63 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}161.nrrd -seg ${pathSeg}161.seg.nrrd -str 2 -sigst ${SigSt} -bn 27 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}161.nrrd -seg ${pathSeg}161.seg.nrrd -str 2 -sigst ${SigSt} -bn 25 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}162.nrrd -seg ${pathSeg}162.seg.nrrd -str 2 -sigst ${SigSt} -bn 87 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}162.nrrd -seg ${pathSeg}162.seg.nrrd -str 2 -sigst ${SigSt} -bn 76 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}162.nrrd -seg ${pathSeg}162.seg.nrrd -str 2 -sigst ${SigSt} -bn 79 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}162.nrrd -seg ${pathSeg}162.seg.nrrd -str 2 -sigst ${SigSt} -bn 70 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}162.nrrd -seg ${pathSeg}162.seg.nrrd -str 2 -sigst ${SigSt} -bn 73 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}162.nrrd -seg ${pathSeg}162.seg.nrrd -str 2 -sigst ${SigSt} -bn 52 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}162.nrrd -seg ${pathSeg}162.seg.nrrd -str 2 -sigst ${SigSt} -bn 41 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}162.nrrd -seg ${pathSeg}162.seg.nrrd -str 2 -sigst ${SigSt} -bn 60 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}162.nrrd -seg ${pathSeg}162.seg.nrrd -str 2 -sigst ${SigSt} -bn 71 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}162.nrrd -seg ${pathSeg}162.seg.nrrd -str 2 -sigst ${SigSt} -bn 25 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}162.nrrd -seg ${pathSeg}162.seg.nrrd -str 2 -sigst ${SigSt} -bn 17 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}163.nrrd -seg ${pathSeg}163.seg.nrrd -str 2 -sigst ${SigSt} -bn 95 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}163.nrrd -seg ${pathSeg}163.seg.nrrd -str 2 -sigst ${SigSt} -bn 66 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}163.nrrd -seg ${pathSeg}163.seg.nrrd -str 2 -sigst ${SigSt} -bn 69 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}163.nrrd -seg ${pathSeg}163.seg.nrrd -str 2 -sigst ${SigSt} -bn 78 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}163.nrrd -seg ${pathSeg}163.seg.nrrd -str 2 -sigst ${SigSt} -bn 80 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}163.nrrd -seg ${pathSeg}163.seg.nrrd -str 2 -sigst ${SigSt} -bn 62 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}163.nrrd -seg ${pathSeg}163.seg.nrrd -str 2 -sigst ${SigSt} -bn 49 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}163.nrrd -seg ${pathSeg}163.seg.nrrd -str 2 -sigst ${SigSt} -bn 51 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}163.nrrd -seg ${pathSeg}163.seg.nrrd -str 2 -sigst ${SigSt} -bn 64 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}164.nrrd -seg ${pathSeg}164.seg.nrrd -str 2 -sigst ${SigSt} -bn 113 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}164.nrrd -seg ${pathSeg}164.seg.nrrd -str 2 -sigst ${SigSt} -bn 107 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}164.nrrd -seg ${pathSeg}164.seg.nrrd -str 2 -sigst ${SigSt} -bn 140 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}164.nrrd -seg ${pathSeg}164.seg.nrrd -str 2 -sigst ${SigSt} -bn 91 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}164.nrrd -seg ${pathSeg}164.seg.nrrd -str 2 -sigst ${SigSt} -bn 147 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}164.nrrd -seg ${pathSeg}164.seg.nrrd -str 2 -sigst ${SigSt} -bn 149 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}164.nrrd -seg ${pathSeg}164.seg.nrrd -str 2 -sigst ${SigSt} -bn 165 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}164.nrrd -seg ${pathSeg}164.seg.nrrd -str 2 -sigst ${SigSt} -bn 166 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}164.nrrd -seg ${pathSeg}164.seg.nrrd -str 2 -sigst ${SigSt} -bn 151 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}164.nrrd -seg ${pathSeg}164.seg.nrrd -str 2 -sigst ${SigSt} -bn 297 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}165.nrrd -seg ${pathSeg}165.seg.nrrd -str 2 -sigst ${SigSt} -bn 30 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}165.nrrd -seg ${pathSeg}165.seg.nrrd -str 2 -sigst ${SigSt} -bn 42 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}165.nrrd -seg ${pathSeg}165.seg.nrrd -str 2 -sigst ${SigSt} -bn 40 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}165.nrrd -seg ${pathSeg}165.seg.nrrd -str 2 -sigst ${SigSt} -bn 61 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}165.nrrd -seg ${pathSeg}165.seg.nrrd -str 2 -sigst ${SigSt} -bn 76 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}165.nrrd -seg ${pathSeg}165.seg.nrrd -str 2 -sigst ${SigSt} -bn 103 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}165.nrrd -seg ${pathSeg}165.seg.nrrd -str 2 -sigst ${SigSt} -bn 83 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}165.nrrd -seg ${pathSeg}165.seg.nrrd -str 2 -sigst ${SigSt} -bn 99 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}165.nrrd -seg ${pathSeg}165.seg.nrrd -str 2 -sigst ${SigSt} -bn 323 -fid 14 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}166.nrrd -seg ${pathSeg}166.seg.nrrd -str 2 -sigst ${SigSt} -bn 66 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}166.nrrd -seg ${pathSeg}166.seg.nrrd -str 2 -sigst ${SigSt} -bn 65 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}166.nrrd -seg ${pathSeg}166.seg.nrrd -str 2 -sigst ${SigSt} -bn 63 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}166.nrrd -seg ${pathSeg}166.seg.nrrd -str 2 -sigst ${SigSt} -bn 62 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}166.nrrd -seg ${pathSeg}166.seg.nrrd -str 2 -sigst ${SigSt} -bn 83 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}166.nrrd -seg ${pathSeg}166.seg.nrrd -str 2 -sigst ${SigSt} -bn 89 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}166.nrrd -seg ${pathSeg}166.seg.nrrd -str 2 -sigst ${SigSt} -bn 80 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}167.nrrd -seg ${pathSeg}167.seg.nrrd -str 2 -sigst ${SigSt} -bn 120 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}167.nrrd -seg ${pathSeg}167.seg.nrrd -str 2 -sigst ${SigSt} -bn 105 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}167.nrrd -seg ${pathSeg}167.seg.nrrd -str 2 -sigst ${SigSt} -bn 132 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}167.nrrd -seg ${pathSeg}167.seg.nrrd -str 2 -sigst ${SigSt} -bn 133 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}167.nrrd -seg ${pathSeg}167.seg.nrrd -str 2 -sigst ${SigSt} -bn 137 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}167.nrrd -seg ${pathSeg}167.seg.nrrd -str 2 -sigst ${SigSt} -bn 136 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}167.nrrd -seg ${pathSeg}167.seg.nrrd -str 2 -sigst ${SigSt} -bn 123 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}169.nrrd -seg ${pathSeg}169.seg.nrrd -str 2 -sigst ${SigSt} -bn 113 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}169.nrrd -seg ${pathSeg}169.seg.nrrd -str 2 -sigst ${SigSt} -bn 97 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}169.nrrd -seg ${pathSeg}169.seg.nrrd -str 2 -sigst ${SigSt} -bn 115 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}169.nrrd -seg ${pathSeg}169.seg.nrrd -str 2 -sigst ${SigSt} -bn 129 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}169.nrrd -seg ${pathSeg}169.seg.nrrd -str 2 -sigst ${SigSt} -bn 106 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}169.nrrd -seg ${pathSeg}169.seg.nrrd -str 2 -sigst ${SigSt} -bn 138 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}169.nrrd -seg ${pathSeg}169.seg.nrrd -str 2 -sigst ${SigSt} -bn 142 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}170.nrrd -seg ${pathSeg}170.seg.nrrd -str 2 -sigst ${SigSt} -bn 80 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}170.nrrd -seg ${pathSeg}170.seg.nrrd -str 2 -sigst ${SigSt} -bn 79 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}170.nrrd -seg ${pathSeg}170.seg.nrrd -str 2 -sigst ${SigSt} -bn 70 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}170.nrrd -seg ${pathSeg}170.seg.nrrd -str 2 -sigst ${SigSt} -bn 98 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}170.nrrd -seg ${pathSeg}170.seg.nrrd -str 2 -sigst ${SigSt} -bn 88 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}170.nrrd -seg ${pathSeg}170.seg.nrrd -str 2 -sigst ${SigSt} -bn 102 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}170.nrrd -seg ${pathSeg}170.seg.nrrd -str 2 -sigst ${SigSt} -bn 103 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}170.nrrd -seg ${pathSeg}170.seg.nrrd -str 2 -sigst ${SigSt} -bn 96 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}171.nrrd -seg ${pathSeg}171.seg.nrrd -str 2 -sigst ${SigSt} -bn 200 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}171.nrrd -seg ${pathSeg}171.seg.nrrd -str 2 -sigst ${SigSt} -bn 214 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}171.nrrd -seg ${pathSeg}171.seg.nrrd -str 2 -sigst ${SigSt} -bn 225 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}171.nrrd -seg ${pathSeg}171.seg.nrrd -str 2 -sigst ${SigSt} -bn 206 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}171.nrrd -seg ${pathSeg}171.seg.nrrd -str 2 -sigst ${SigSt} -bn 240 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}171.nrrd -seg ${pathSeg}171.seg.nrrd -str 2 -sigst ${SigSt} -bn 241 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}171.nrrd -seg ${pathSeg}171.seg.nrrd -str 2 -sigst ${SigSt} -bn 195 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}171.nrrd -seg ${pathSeg}171.seg.nrrd -str 2 -sigst ${SigSt} -bn 253 -fid 15 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}172.nrrd -seg ${pathSeg}172.seg.nrrd -str 2 -sigst ${SigSt} -bn 59 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}172.nrrd -seg ${pathSeg}172.seg.nrrd -str 2 -sigst ${SigSt} -bn 38 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}172.nrrd -seg ${pathSeg}172.seg.nrrd -str 2 -sigst ${SigSt} -bn 39 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}172.nrrd -seg ${pathSeg}172.seg.nrrd -str 2 -sigst ${SigSt} -bn 64 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}172.nrrd -seg ${pathSeg}172.seg.nrrd -str 2 -sigst ${SigSt} -bn 45 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}172.nrrd -seg ${pathSeg}172.seg.nrrd -str 2 -sigst ${SigSt} -bn 14 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}172.nrrd -seg ${pathSeg}172.seg.nrrd -str 2 -sigst ${SigSt} -bn 28 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}174.nrrd -seg ${pathSeg}174.seg.nrrd -str 2 -sigst ${SigSt} -bn 93 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}174.nrrd -seg ${pathSeg}174.seg.nrrd -str 2 -sigst ${SigSt} -bn 82 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}174.nrrd -seg ${pathSeg}174.seg.nrrd -str 2 -sigst ${SigSt} -bn 56 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}174.nrrd -seg ${pathSeg}174.seg.nrrd -str 2 -sigst ${SigSt} -bn 55 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}174.nrrd -seg ${pathSeg}174.seg.nrrd -str 2 -sigst ${SigSt} -bn 59 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}174.nrrd -seg ${pathSeg}174.seg.nrrd -str 2 -sigst ${SigSt} -bn 40 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}174.nrrd -seg ${pathSeg}174.seg.nrrd -str 2 -sigst ${SigSt} -bn 61 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}174.nrrd -seg ${pathSeg}174.seg.nrrd -str 2 -sigst ${SigSt} -bn 16 -fid 11 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}174.nrrd -seg ${pathSeg}174.seg.nrrd -str 2 -sigst ${SigSt} -bn 23 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}174.nrrd -seg ${pathSeg}174.seg.nrrd -str 2 -sigst ${SigSt} -bn 33 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}175.nrrd -seg ${pathSeg}175.seg.nrrd -str 2 -sigst ${SigSt} -bn 50 -fid 1 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}175.nrrd -seg ${pathSeg}175.seg.nrrd -str 2 -sigst ${SigSt} -bn 32 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}175.nrrd -seg ${pathSeg}175.seg.nrrd -str 2 -sigst ${SigSt} -bn 44 -fid 5 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}175.nrrd -seg ${pathSeg}175.seg.nrrd -str 2 -sigst ${SigSt} -bn 59 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}175.nrrd -seg ${pathSeg}175.seg.nrrd -str 2 -sigst ${SigSt} -bn 51 -fid 7 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}175.nrrd -seg ${pathSeg}175.seg.nrrd -str 2 -sigst ${SigSt} -bn 78 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}175.nrrd -seg ${pathSeg}175.seg.nrrd -str 2 -sigst ${SigSt} -bn 26 -fid 9 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}175.nrrd -seg ${pathSeg}175.seg.nrrd -str 2 -sigst ${SigSt} -bn 43 -fid 10 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}175.nrrd -seg ${pathSeg}175.seg.nrrd -str 2 -sigst ${SigSt} -bn 20 -fid 12 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}175.nrrd -seg ${pathSeg}175.seg.nrrd -str 2 -sigst ${SigSt} -bn 36 -fid 13 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}

          python model_add_ICA.py -i ${path}176.nrrd -seg ${pathSeg}176.seg.nrrd -str 2 -sigst ${SigSt} -bn 58 -fid 2 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}176.nrrd -seg ${pathSeg}176.seg.nrrd -str 2 -sigst ${SigSt} -bn 83 -fid 6 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          python model_add_ICA.py -i ${path}176.nrrd -seg ${pathSeg}176.seg.nrrd -str 2 -sigst ${SigSt} -bn 52 -fid 8 -cs 64 -r ${radius} -Sed ${elasticStDev} -AGr ${AGrowth} -d3D ${d3D}
          done
      done
  done
