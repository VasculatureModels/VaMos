
import SimpleITK as sitk
import numpy as np

s_orig = sitk.ReadImage("/home/---/Images/MRA-Dataset/_ICA_Model/14_Bif=13_Spl=1_R=3_Sed=0.0_Orig.nrrd")
s_vasc = sitk.ReadImage("/home/---/Images/MRA-Dataset/_ICA_Model/14_Bif=13_Spl=1_R=3_Sed=0.0_AGr=0.8_CleanVascu.seg.nrrd")
s_segm = sitk.ReadImage("/home/---/Images/MRA-Dataset/_ICA_Model/14_Bif=13_Spl=1_R=3_Sed=0.0_AGr=0.8_BinOrig.seg.nrrd")
s_icasegm = sitk.ReadImage("/home/---/Images/MRA-Dataset/_ICA_Model/14_Bif=13_Spl=1_R=3_Sed=0.0_ICA.seg.nrrd")
s_vamos = sitk.ReadImage("/home/---/Images/MRA-Dataset/_ICA_Model/14_Bif=13_Spl=1_SigSt=0.8_R=3_Sed=0.0_AGr=0.8_Model.nrrd")
s_labels = sitk.ReadImage("/home/---/Images/MRA-Dataset/_ICA_Model/14_Bif=13_Spl=1_R=3_Sed=0.0_AGr=0.8_ICA_Label_Model.seg.nrrd")


orig = sitk.GetArrayFromImage(s_orig)
vasc = sitk.GetArrayFromImage(s_vasc)
segm = sitk.GetArrayFromImage(s_segm)
vamos = sitk.GetArrayFromImage(s_vamos)
labels = sitk.GetArrayFromImage(s_labels)

augm_model = np.copy(orig)

augm_model[segm > 0] = vamos[segm > 0]
augm_model = np.maximum(augm_model, vamos)
augm_model[labels > 0] = vamos[labels > 0]

sitk.WriteImage(sitk.GetImageFromArray(augm_model), "/home/---/Bureau/AugmModel.nrrd")
