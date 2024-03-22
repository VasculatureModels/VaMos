
import SimpleITK as sitk
import numpy as np
import argparse
import os

from MyFunctions.misc_fun import *


ap = argparse.ArgumentParser()
ap.add_argument("-s", "--seg", type=str, default='/Users/---/Code/vamos/Sample_TOFs/12/12.seg.nrrd',
	help="Input 3D binary image (stack) (.nrrd, .nii or .mha)")


args = vars(ap.parse_args())

seg= args["seg"]
print('seg=\'%s\'' %(seg))


FileDir = os.path.dirname(os.path.abspath(seg)) + '/'
FileNameStack = (os.path.basename(seg))
FileName = os.path.splitext(os.path.basename(FileNameStack))[0]
fileext = os.path.splitext(seg)[1]


sitkimgSegm = sitk.ReadImage(seg)
#resampling
sitkimgSegm = resample_image2(sitkimgSegm, is_label=False)
stackSegm = sitk.GetArrayFromImage(sitkimgSegm)


graph = GetGraph2(stackSegm.astype(np.uint8))
L = len(graph)


Nodes = []
for i in range(L):
	bifNode = 0
	if i not in Nodes :
		neighbors = list(graph.neighbors(i))
		NbNeighbors = len(neighbors)
		#for j in range(NbNeighbors):
		#	Branch = graph[i][list(graph.neighbors(i))[j]]
		if NbNeighbors == 1:
			if len(graph[i][list(graph.neighbors(i))[0]]['pts']) < 4:
				#print("nodes needing removal : " + str(i))

				EN = list(graph.neighbors(i))[0]    # <--- ExtraNode
				MN = list(graph.neighbors(EN))      #<--- MergedNeighbors

				if len(MN) > 2 :
					bifNode = 1
					MN.remove(i)

				print("linking nodes %d and %d" %(MN[0],MN[1]))

				graph.add_edge(MN[0],MN[1])

				B1 = np.array(graph[MN[0]][EN]['pts'])
				B2 = np.array(graph[EN][MN[1]]['pts'])
				L1 = list(B1)
				L2 = list(B2)

				for j in range(len(L2)):
					L1.append(L2[j])

				Arr = np.asarray(L1)

				ArrS = Arr[np.lexsort((Arr[:,0], Arr[:,1],Arr[:,2]))]

				NewBranch, count = np.unique(ArrS, axis=0, return_counts=True)

				graph[MN[0]][MN[1]]['pts'] = NewBranch

				if bifNode == 1 :
					print("removing node " + str(i))
					graph.remove_node(i)

				print("removing node " + str(EN))
				graph.remove_node(EN)
				Nodes.append(EN)
				Nodes.append(i)
