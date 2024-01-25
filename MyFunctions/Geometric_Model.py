#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Copyright - Florent Autrusseau
contributor(s) : Florent Autrusseau, Rafic Nader (February 2023)

Florent.Autrusseau@univ-nantes.fr
Rafic.Nader@univ-nantes.fr

This software is a computer program whose purpose is to detect cerebral
vascular tree bifurcations within MRA-TOF acquisitions.

This software is governed by the CeCILL  license under French law and
abiding by the rules of distribution of free software.  You can  use,
modify and/ or redistribute the software under the terms of the CeCILL
license as circulated by CEA, CNRS and INRIA at the following URL
"http://www.cecill.info".

As a counterpart to the access to the source code and  rights to copy,
modify and redistribute granted by the license, users are provided only
with a limited warranty  and the software's author,  the holder of the
economic rights,  and the successive licensors  have only  limited liability.

In this respect, the user's attention is drawn to the risks associated
with loading,  using,  modifying and/or developing or reproducing the
software by the user in light of its specific status of free software,
that may mean  that it is complicated to manipulate,  and  that  also
therefore means  that it is reserved for developers  and  experienced
professionals having in-depth computer knowledge. Users are therefore
encouraged to load and test the software's suitability as regards their
requirements in conditions enabling the security of their systems and/or
data to be ensured and,  more generally, to use and operate it in the
same conditions as regards security.

The fact that you are presently reading this means that you have had
knowledge of the CeCILL license and that you accept its terms.
"""

import sys
import random
from math import cos, sin
from copy import deepcopy
from scipy import interpolate
#from scipy.ndimage import *
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

###   Local imports :   ###
from MyFunctions.GetGraph import *
from MyFunctions.misc_fun import *
from MyFunctions.ICA_fun import *
from MyFunctions.GetBifurcDiameters import *


#########################################################################################################

def rot_3d_coords(listcoords):
    AngDeg = 4.
    alpha = random.uniform(-AngDeg * np.pi / 180., AngDeg * np.pi / 180.)  # yaw
    beta = random.uniform(-AngDeg * np.pi / 180., AngDeg * np.pi / 180.)  # pitch
    gamma = random.uniform(-AngDeg * np.pi / 180., AngDeg * np.pi / 180.)  # roll

    R = np.zeros((3, 3))

    R[0, 0] = cos(alpha) * cos(beta)
    R[0, 1] = cos(alpha) * sin(beta) * sin(gamma) - sin(alpha) * cos(gamma)
    R[0, 2] = cos(alpha) * sin(beta) * cos(gamma) + sin(alpha) * sin(gamma)

    R[1, 0] = sin(alpha) * cos(beta)
    R[1, 1] = sin(alpha) * sin(beta) * sin(gamma) + cos(alpha) * cos(gamma)
    R[1, 2] = sin(alpha) * sin(beta) * cos(gamma) - cos(alpha) * sin(gamma)

    R[2, 0] = -sin(beta)
    R[2, 1] = cos(beta) * sin(gamma)
    R[2, 2] = cos(beta) * cos(gamma)

    listcoordsArr = np.asarray(listcoords)
    rotcoordsArr = np.matmul(listcoordsArr.transpose(), R)
    rotcoords = []
    rotcoords.append(rotcoordsArr[:, 0])
    rotcoords.append(rotcoordsArr[:, 1])
    rotcoords.append(rotcoordsArr[:, 2])

    return (rotcoords)


#########################################################################################################

# def geometric_model(stackGray, stackSegm, BifNum, SplineStr, CropSize, ShowPlot, RandPoint_Or_xyz):
# def geometric_model(stackGray, stackSegm, BifNum, SplineStr, CropSize, ShowPlot, RandPoint, AddICA, Radius, SigmaED, AGrowth)
def geometric_model(*arg):
    if len(arg) == 7 or len(arg) == 8:
        stackGray = arg[0]
        stackSegm = arg[1]
        BifNum = arg[2]
        SplineStr = arg[3]
        CropSize = arg[4]
        ShowPlot = arg[5]
        RandPoint_Or_xyz = arg[6]
        AddICA = 0
    else:
        if arg[7] == 0:     #### --> Do the aneurysm !
            stackGray = arg[0]
            stackSegm = arg[1]
            BifNum = arg[2]
            SplineStr = arg[3]
            CropSize = arg[4]
            ShowPlot = arg[5]
            RandPoint_Or_xyz = arg[6]
            AddICA = arg[7]
            Radius = arg[8]
            SigmaED = arg[9]
            AGrowth = arg[10]
        else:
            if arg[6] == 1:   #### --> Get a random point along the vascular tree !
                stackGray = arg[0]
                stackSegm = arg[1]
                BifNum = arg[2]
                SplineStr = arg[3]
                CropSize = arg[4]
                ShowPlot = arg[5]
                RandPoint_Or_xyz = arg[6]
                AddICA = arg[7]
            elif arg[6] == 2:   #### --> Crop around the given (x,y,z) coordinates !
                stackGray = arg[0]
                stackSegm = arg[1]
                BifNum = arg[2]
                SplineStr = arg[3]
                CropSize = arg[4]
                ShowPlot = arg[5]
                RandPoint_Or_xyz = arg[6]
                Xcoord = arg[7]
                Ycoord = arg[8]
                Zcoord = arg[9]
                AddICA = arg[10]
            else:           #### --> Get the crop @BifNum !
                stackGray = arg[0]
                stackSegm = arg[1]
                BifNum = arg[2]
                SplineStr = arg[3]
                CropSize = arg[4]
                ShowPlot = arg[5]
                RandPoint_Or_xyz = arg[6]
                AddICA = arg[7]

    if AddICA == 1:
        Radius = arg[8]
        SigmaED = arg[9]
        AGrowth = arg[10]

    if CropSize <= 32:
        CropExt = 30
    else:
        CropExt = 0


    ### Expanding CropSize to have cleaner arteries diameters at the cube borders... ###
    CropSize = CropSize + CropExt

    if ShowPlot:
        # fig = Figure()
        fig = plt.figure(figsize=(8, 5))
        ax = Axes3D(fig, auto_add_to_figure=False)
        fig.add_axes(ax)
        fig2, ((ax1)) = plt.subplots(ncols=1, nrows=1, figsize=(8, 5))

    z, y, x = stackGray.shape

    graph = GetGraph2(stackSegm.astype(np.uint8))

    if (RandPoint_Or_xyz == 1):
        """ 
            (1) Randomly pick a bifurcation, 
            (2) Randomly pick a branch from that bifurcation, and
            (3) Randomly pick a voxel in the branch
        """
        Xc = 0; Yc = 0; Zc = 0;
        while Xc < int(CropSize / 2) or Yc < int(CropSize / 2) or Zc < int(CropSize / 2) or Xc > x - int(
                CropSize / 2) or Yc > y - int(CropSize / 2) or Zc > z - int(CropSize / 2):
            '''
            randBif = random.randint(0, len(graph))
            Nb = list(graph.neighbors(randBif))
            if len(Nb) > 1:
                randBranch = random.randint(0, len(Nb) - 1)
            else:
                randBranch = 0
            '''

            ###   Look for graph nodes that actually have at least one neighbor : ###
            Gl = []
            for i in range(len(graph)):
                Gl.append(len(graph[i]))
            G = np.asarray(Gl)
            Gnodes = np.where(G != 0)[0]
            idxg = np.random.randint(0,len(Gnodes))
            randBif = Gnodes[idxg]
            Nb = list(graph.neighbors(randBif))
            randBranch = random.randint(0, len(Nb) - 1)


            Coords_Branch = []
            Coords_Branch.append(graph[randBif][Nb[randBranch]]['pts'])
            lenBr = len(Coords_Branch[0])
            randPt = random.randint(0, lenBr - 1)
            # print(Nb)
            # print(randBranch)
            # print(randPt)
            XYZpoint = Coords_Branch[0][randPt]
            # print(XYZpoint)
            Xc = XYZpoint[2]
            Yc = XYZpoint[1]
            Zc = XYZpoint[0]

        print(XYZpoint)
    elif (RandPoint_Or_xyz == 2):
        Xc = Xcoord; Yc = Ycoord; Zc = Zcoord;
        XYZpoint = [Zc, Yc, Xc]

        print(XYZpoint)
    else:
        bifcenter = graph.nodes[BifNum]['o']
        bifcenter = bifcenter[::-1].astype(int)
        print('bifurcation center (x,y,z) : ' + str(bifcenter))
        Xc = bifcenter[0]
        Yc = bifcenter[1]
        Zc = bifcenter[2]

    Xco = Xc;  Yco = Yc; Zco = Zc
    NoShiftX =0; NoShiftY =0; NoShiftZ =0;

    hcs = int(CropSize / 2)  # Half Crop Size
    if (Xc >= hcs and Xc <= x - hcs) and (Yc >= hcs and Yc <= y - hcs) and (Zc >= hcs and Zc <= z - hcs):
        CroppedSegm = stackSegm[Zc - hcs:Zc + hcs, Yc - hcs:Yc + hcs, Xc - hcs:Xc + hcs]
        CroppedGray = stackGray[Zc - hcs:Zc + hcs, Yc - hcs:Yc + hcs, Xc - hcs:Xc + hcs]
    else:
        print("\t-----------------------------------------------------------------------------")
        print("\tWARNING : Bifurcation is too close from image border... moving the coords !")#can't crop !\n")
        print("\t-----------------------------------------------------------------------------\n")
        if Xc < hcs:
            Xc = hcs; NoShiftX = 1
        if Yc < hcs:
            Yc = hcs; NoShiftY = 1
        if Zc < hcs:
            Zc = hcs; NoShiftZ = 1
        if Xc > x-hcs:
            Xc = x-hcs
        if Yc > y-hcs:
            Yc = y-hcs
        if Zc > z-hcs:
            Zc = z-hcs
        CroppedSegm = stackSegm[Zc - hcs:Zc + hcs, Yc - hcs:Yc + hcs, Xc - hcs:Xc + hcs]
        CroppedGray = stackGray[Zc - hcs:Zc + hcs, Yc - hcs:Yc + hcs, Xc - hcs:Xc + hcs]
        #sys.exit(0)

    #print('%d - %d,\t%d - %d,\t%d - %d\n' %(Xc-hcs,Xc+hcs, Yc-hcs, Yc+hcs, Zc-hcs,Zc+hcs))
    DXc = Xc - Xco
    DYc = Yc - Yco
    DZc = Zc - Zco

    graphCrop = GetGraph2(CroppedSegm.astype(np.uint8))

    """ 
    skeO = skeletonize_3d(np.uint8(CroppedSegm)).astype(np.uint8)
    ske = np.zeros(CroppedSegm.shape)
    for i in range(len(graphCrop)):
        Neighb = list(graphCrop.neighbors(i))
        for j in range(len(Neighb)):
            branch = graphCrop[i][Neighb[j]]['pts']
            for k in range(len(branch)):
                z = branch[k][0]
                y = branch[k][1]
                x = branch[k][2]
                ske[z, y, x] = 1

    hE = int(CropExt / 2)  # Half of the Extension
    z1, y1, x1 = CroppedSegm.shape
    CroppedSegm2 = CroppedSegm[hE:z1 - hE, hE:y1 - hE, hE:x1 - hE]
    ske2 = ske[hE:z1 - hE, hE:y1 - hE, hE:x1 - hE]
    skeO2 = skeO[hE:z1 - hE, hE:y1 - hE, hE:x1 - hE]

    CroppedSegm2D = ndimage.binary_dilation(CroppedSegm2).astype(CroppedSegm2.dtype)
    sitk.WriteImage((sitk.GetImageFromArray(CroppedSegm2D * 255.)), "/Users/florent/Desktop/CroppedSegm2D.nrrd")
    ske2D = ndimage.binary_dilation(ske2).astype(ske2.dtype)
    sitk.WriteImage((sitk.GetImageFromArray(ske2D * 255.)), "/Users/florent/Desktop/ske2D.nrrd")
    skeO2D = ndimage.binary_dilation(skeO2).astype(skeO2.dtype)
    sitk.WriteImage((sitk.GetImageFromArray(skeO2D * 255.)), "/Users/florent/Desktop/skeO2D.nrrd")
    """


    if len(graphCrop) == 0:
        CroppedGray = stackGray[Zc - hcs:Zc + hcs, Yc - hcs:Yc + hcs, Xc - hcs:Xc + hcs]
        CroppedSegm = stackSegm[Zc - hcs:Zc + hcs, Yc - hcs:Yc + hcs, Xc - hcs:Xc + hcs]
        #FullStackSpline = CroppedGray
        FullStackModel = CroppedGray
    else:
        """ Looking for the Bifurcation of Interest """
        """ either centered within the 64^3 crop, """
        """ or shifted away if the bif was too close to image border : """
        BifCenters = []
        DistCenter = []
        for BifNumCrop in range(len(graphCrop)):
            BifCenters.append(graphCrop.nodes[BifNumCrop]['o'])
            DistCenter.append(np.sqrt(
                (BifCenters[BifNumCrop][0] - (hcs-DZc)) ** 2 +
                (BifCenters[BifNumCrop][1] - (hcs-DYc)) ** 2 +
                (BifCenters[BifNumCrop][2] - (hcs-DXc)) ** 2))

        if min(DistCenter) > 10:
            print("-------------------------------------------------------------------")
            print("Warning : Branch extremity is too far away from the bifurcation... ")
            print("-------------------------------------------------------------------")
            #sys.exit(0)

        ''' Bifurcation of Interest : '''
        BoI = DistCenter.index(min(DistCenter))
        DistCenter2 = DistCenter.copy()

        DistCenter2[BoI] = 100
        altBoI = DistCenter2.index(min(DistCenter2))    ## <-- alternative BoI (in case BoI is a graph end node...)
        DistCenter3 = DistCenter2.copy()

        DistCenter3[altBoI] = 100
        altBoI2 = DistCenter3.index(min(DistCenter3))    ## <-- alternative to altBoI (in case altBoI is a graph end node...)

        # NbBranches = len(graphCrop.nodes())
        NbBranches = len(graphCrop)

        #FullStackSpline = np.zeros(CroppedSegm.shape)
        FullStackModel = np.zeros(CroppedSegm.shape)
        FullStackModelNoTh = np.zeros(CroppedSegm.shape)
        Coords_Branches = []
        link = []
        inc = 0
        for idx in range(NbBranches):

            # graphCrop[idx]
            Nb = list(graphCrop.neighbors(idx))  # [0]

            for idx2 in Nb:
                link.append([idx, idx2])
                if [idx2, idx] not in link:
                    Coords_Branches.append(graphCrop[idx][idx2]['pts'])
                    Coords_BranchN = Coords_Branches[inc]
                    inc += 1
                    #current_bif_center = graphCrop.nodes[idx2]['o']

                    #if len(Coords_BranchN) > 3: ###   <-- if we want to discard the smaller branches (probably skeleton errors)
                    S1 = np.zeros(CroppedSegm.shape)
                    S2 = np.zeros(CroppedSegm.shape)

                    (diam_branch, stackDiam, MaxBranch, Pctile75) = GetChunkDiam_v2(Coords_BranchN, CroppedSegm, CroppedGray)
                    # (diam_min, diam_max) = get_area_diam(Coords_BranchN, CroppedSegm)
                    # diam_branch = np.uint8((diam_min + diam_max)/2)
                    print('Branch #%d, \tdiameter : %d, \tlength : %d, \tmax grey  : %d, \t75th Percentile : %d' % (
                        idx, diam_branch, len(Coords_BranchN), MaxBranch, Pctile75))

                    Coords_BranchZ = Coords_BranchN[:, 0]
                    Coords_BranchY = Coords_BranchN[:, 1]
                    Coords_BranchX = Coords_BranchN[:, 2]

                    #for i in range(len(Coords_BranchX)): ### <---  Useless loop (removed in v8 !)
                    S1[Coords_BranchZ, Coords_BranchY, Coords_BranchX] = 1

                    Coords = np.zeros((len(Coords_BranchZ), 3))
                    Coords[:, 0] = Coords_BranchX
                    Coords[:, 1] = Coords_BranchY
                    Coords[:, 2] = Coords_BranchZ

                    if AddICA != 1 :
                        ''' 
                            Arbitrarily rotate the XYZ Coordinates using the Rodrigues Matrix
                            (along a random angle - within range [-pi/4, pi/4])
                            NOTE : Only launch the branch rotation when no ICA is embedded !
                        '''
                        """ """
                        #axis = (np.random.uniform(0, 1), np.random.uniform(0, 1), np.random.uniform(0, 1))
                        #axis = (S1.shape[2]/2, S1.shape[1]/2, S1.shape[0]/2)
                        axis = (0.5, 0.5, 0.5)
                        theta = np.random.uniform(-np.pi/4., np.pi/4.)
                        RodMat = getRodriguesMatrix(axis, theta)
                        CoordsRot = np.matmul(Coords, RodMat)
                        """ """
                        Coords = CoordsRot.transpose()
                    else:
                        Coords = Coords.transpose()


                    if len(Coords_BranchN) > 5:
                        tck, u = interpolate.splprep(Coords, k=5)
                    elif len(Coords_BranchN) > 3 and len(Coords_BranchN) < 5:
                        tck, u = interpolate.splprep(Coords, k=3)
                    else:
                        tck, u = interpolate.splprep(Coords, k=1)
                    # here we generate the new interpolated dataset,
                    # increase the resolution by increasing the spacing, 500 in this example
                    new = interpolate.splev(np.linspace(0, 1, 200), tck, der=0)
                    #new = interpolate.splev(u, tck, der=0)

                    # print(tck[1])
                    tck2 = deepcopy(tck)

                    if len(Coords_BranchN) > 10:
                        """ 
                            Spline Strengths applied in Dataset v_8, v_9, ... : 
                        """
                        SplineMod = np.random.uniform(-SplineStr, SplineStr, len(tck2[1][0]))
                        for i in range(1, len(tck2[1][0]) - 1, 1):
                            tck2[1][0][i] = tck2[1][0][i] + SplineMod[i] * tck2[1][0][i] / 100.  # <-- starting from v9
                            tck2[1][1][i] = tck2[1][1][i] + SplineMod[i] * tck2[1][1][i] / 100.
                            tck2[1][2][i] = tck2[1][2][i] + SplineMod[i] * tck2[1][2][i] / 100.

                        new2 = interpolate.splev(np.linspace(0, 1, 200), tck2, der=0)

                        newR = deepcopy(new2)
                    else:
                        new2 = interpolate.splev(np.linspace(0, 1, 200), tck2, der=0)
                        newR = deepcopy(new2)

                    """ """
                    ''' Look for branches' extremities : '''
                    xyz_ext = []
                    xyz_ext.append(np.asarray([int(newR[0][0]), int(newR[1][0]), int(newR[2][0])]))
                    xyz_ext.append(np.asarray([int(newR[0][-1]), int(newR[1][-1]), int(newR[2][-1])]))
                    ''' Compute distance from branch nodes : '''
                    dist = []
                    dist.append(np.sqrt(
                        (xyz_ext[0][0] - Coords_BranchX[0]) ** 2 + (xyz_ext[0][1] - Coords_BranchY[0]) ** 2 + (
                                xyz_ext[0][2] - Coords_BranchZ[0]) ** 2))
                    dist.append(np.sqrt(
                        (xyz_ext[1][0] - Coords_BranchX[-1]) ** 2 + (xyz_ext[1][1] - Coords_BranchY[-1]) ** 2 + (
                                xyz_ext[1][2] - Coords_BranchZ[-1]) ** 2))
                    ''' Compute distance from bifurc center : '''
                    distC = []
                    distC.append(
                        np.sqrt((xyz_ext[0][0] - hcs) ** 2 + (xyz_ext[0][1] - hcs) ** 2 + (xyz_ext[0][2] - hcs) ** 2))
                    distC.append(
                        np.sqrt((xyz_ext[1][0] - hcs) ** 2 + (xyz_ext[1][1] - hcs) ** 2 + (xyz_ext[1][2] - hcs) ** 2))
                    ''' shift whole branch if too far away from the bif center : '''
                    ext = np.where(dist == min(dist))[0][0]
                    if int(min(dist)) >= 2:
                        newR[0] = newR[0] - (xyz_ext[ext][0] - Coords_BranchX[0])
                        newR[1] = newR[1] - (xyz_ext[ext][1] - Coords_BranchY[0])
                        newR[2] = newR[2] - (xyz_ext[ext][2] - Coords_BranchZ[0])
                    """ """

                    newZ = newR[0].astype(int)
                    newY = newR[1].astype(int)
                    newX = newR[2].astype(int)

                    newX[newX >= CropSize] = CropSize - 1
                    newY[newY >= CropSize] = CropSize - 1
                    newZ[newZ >= CropSize] = CropSize - 1
                    S2[newX, newY, newZ] = 1

                    #########################################
                    ##### 			3D PLOTS			#####
                    #########################################
                    if ShowPlot:
                        distCenterA = np.sqrt((Coords[0][0] - hcs) ** 2 + (Coords[1][0] - hcs) ** 2 + (Coords[2][0] - hcs) ** 2)
                        distCenterB = np.sqrt((Coords[0][-1] - hcs) ** 2 + (Coords[1][-1] - hcs) ** 2 + (Coords[2][-1] - hcs) ** 2)
                        if distCenterA < 2 or distCenterB < 2:

                            ax.plot(Coords[0], Coords[1], Coords[2], label='centerline', lw=2, c='Dodgerblue')
                            ax.plot(new[0], new[1], new[2], label='fit', lw=2, c='red')
                            ax.plot(newR[0], newR[1], newR[2], label='modified', lw=2, c='green')

                            # fig2 = plt.figure()
                            #if idx == 0:
                            #    # ax1 = fig2.add_subplot(1,3,1)
                            #    ax1.bar(np.arange(len(tck[1][idx - 1])), tck[1][idx - 1])
                            #    ax1.scatter(np.arange(len(tck2[1][idx - 1])), tck2[1][idx - 1])
                            #    ax1.set_ylim(min(tck[1][idx - 1]) - 20 * min(tck[1][idx - 1]) / 100,
                            #                 max(tck[1][idx - 1]) + 20 * max(tck[1][idx - 1]) / 100)
                    #########################################
                    #########################################
                    """ """
                    ### Modify the arteries diameters by +/-20% depending on the actual TOF artery thickness :
                    if diam_branch > 6:
                        RandDiamMod = 20 * random.uniform(-1, 0)   ## --> Modify the diameters (~ in [-20, 0] %) : ##
                    elif diam_branch < 2:
                        RandDiamMod = 10 * random.uniform(0, 1)   ## -->  Modify the diameters (~ in [0, +10] %) : ##
                    else :
                        RandDiamMod = 10 * random.uniform(-1, 1)   ## -->  Modify the diameters (~ in [-10, +10] %) : ##
                    diam_branch = np.uint8(np.round(diam_branch + RandDiamMod * diam_branch / 100.))
                    ## -------------------------------- ##
                    """ """

                    #k1 = Make_Sphere_1(diam_branch, diam_branch, diam_branch)
                    #k1 = Make_Sphere_2(diam_branch, diam_branch, diam_branch)
                    k1 = Make_Sphere_3(np.uint8(diam_branch))
                    #k1 = Make_Sphere_4(np.uint8(diam_branch))

                    # k1 = k1 * MaxBranch
                    # k1 = k1 * (MaxBranch + (random.uniform(-10.0, 10.0) * MaxBranch) / 100)

                    # k1 = elasticdeform.deform_random_grid(k1, sigma=0.1, points=1)
                    # k1 = elastic_transform(k1, k1.shape[1] * 0.01, k1.shape[1] * 0.01, k1.shape[1] * 0.01)

                    #Branch = ndimage.convolve(S1, k1, mode='reflect', cval=0.0)
                    # Branch[Branch>0] = 255

                    NBranch = ndimage.convolve(S2, k1, mode='reflect', cval=0.0)
                    NBranchNoTh = np.copy(NBranch)
                    NBranchNoTh[NBranch > 0] = Pctile75
                    FullStackModelNoTh = np.maximum(FullStackModelNoTh, NBranchNoTh)
                    #sitk.WriteImage(sitk.GetImageFromArray(NBranchNoTh),"/Users/florent/Desktop/NBranchNoTh_" + str(idx) + ".nrrd")

                    ### Mimic a thrombosed artery (darker centerline) :
                    if diam_branch >= 5 :  ## <<-- '= 4' in v12
                        if np.random.uniform(0, 1) > 0.7 :  ## <<-- '= 0.5' in v12
                            BNBranch = np.copy(NBranch)
                            BNBranch[BNBranch>0] = 1
                            skel = skeletonize_3d(np.uint8(BNBranch)).astype(np.uint8)
                            skel = ndimage.binary_dilation(skel).astype(skel.dtype)
                            if np.random.uniform(0, 1) > 0.7:  ## <<-- '= 0.5' in v12
                                skel = ndimage.binary_dilation(skel).astype(skel.dtype)
                            NBranch[skel>0] = 0

                    NBranch[NBranch > 0] = Pctile75  # MaxBranch
                    FullStackModel = np.maximum(FullStackModel, NBranch)

                    ### TODO : Add Thrombosis here and there onto the binary vascular tree  -
                    ### TODO : Generate a rather low frequency noise, to be used as a mask for the thrombosed areas.

        if ShowPlot:
            ax.legend()
            plt.show()

    if AddICA == 1:

        FullStackModel = FullStackModelNoTh

        BifCoords = np.uint8(graphCrop.nodes[BoI]['o'])
        NN = list(graphCrop.neighbors(BoI))

        #if NN == [0]:
        if len(NN) == 1:
            BifCoords = np.uint8(graphCrop.nodes[altBoI]['o'])
            NN = list(graphCrop.neighbors(altBoI))
            BoI = altBoI

        if len(NN) == 1:
            BifCoords = np.uint8(graphCrop.nodes[altBoI2]['o'])
            NN = list(graphCrop.neighbors(altBoI2))
            BoI = altBoI2
            if DistCenter3[altBoI] > 32:
                print("\n---- WARNING : The selected Bifurcation might be quite far away from the actual Bifurcation of Interest ! ----\n")

        Coords_Branch1 = graphCrop[BoI][NN[0]]['pts']
        Coords_Branch2 = graphCrop[BoI][NN[1]]['pts']
        Coords_Branch3 = graphCrop[BoI][NN[2]]['pts']

        '''	Collect the branches' diameters :	'''
        (diam_branch1, stackDiam1) = GetChunkDiam(Coords_Branch1, CroppedSegm)
        (diam_branch2, stackDiam2) = GetChunkDiam(Coords_Branch2, CroppedSegm)
        (diam_branch3, stackDiam3) = GetChunkDiam(Coords_Branch3, CroppedSegm)

        print('Thickness_1 : {0}'.format(str(diam_branch1)))
        print('Thickness_2 : {0}'.format(str(diam_branch2)))
        print('Thickness_3 : {0}'.format(str(diam_branch3)))

        diameters = np.asarray([diam_branch1, diam_branch2, diam_branch3])
        posmax = np.where(diameters == np.amax(diameters))[0][0]

        '''	Run the model of 3D Intra-Cranial Aneurysm :	'''
        if posmax == 0:
            diameters = [diam_branch1, diam_branch2, diam_branch3]
            CleanVascu, Vascu_Arr, ICA_Arr, Thromb = Embed_AIC_Bin(Coords_Branch1, Coords_Branch2, Coords_Branch3, BifCoords, CroppedSegm,
                                               Radius, SigmaED, diameters, AGrowth)
            """ Extract the mother branch : """
            #k1 = Make_Sphere_1(diam_branch1, diam_branch1, diam_branch1)
            k1 = Make_Sphere_3(diam_branch1)
            CoordsMothBr = np.zeros(CroppedSegm.shape)
            CoordsMothBr[Coords_Branch1[:, 0], Coords_Branch1[:, 1], Coords_Branch1[:, 2]] = 1
            MotherBranch = ndimage.convolve(CoordsMothBr, k1, mode='reflect', cval=0.0)

        elif posmax == 1:
            diameters = [diam_branch2, diam_branch1, diam_branch3]
            CleanVascu, Vascu_Arr, ICA_Arr, Thromb = Embed_AIC_Bin(Coords_Branch2, Coords_Branch1, Coords_Branch3, BifCoords, CroppedSegm,
                                               Radius, SigmaED, diameters, AGrowth)
            """ Extract the mother branch : """
            #k1 = Make_Sphere_1(diam_branch2, diam_branch2, diam_branch2)
            k1 = Make_Sphere_3(diam_branch2)
            CoordsMothBr = np.zeros(CroppedSegm.shape)
            CoordsMothBr[Coords_Branch2[:, 0], Coords_Branch2[:, 1], Coords_Branch2[:, 2]] = 1
            MotherBranch = ndimage.convolve(CoordsMothBr, k1, mode='reflect', cval=0.0)

        else:
            diameters = [diam_branch3, diam_branch1, diam_branch2]
            CleanVascu, Vascu_Arr, ICA_Arr, Thromb = Embed_AIC_Bin(Coords_Branch3, Coords_Branch1, Coords_Branch2, BifCoords, CroppedSegm,
                                               Radius, SigmaED, diameters, AGrowth)
            """ Extract the mother branch : """
            #k1 = Make_Sphere_1(diam_branch3, diam_branch3, diam_branch3)
            k1 = Make_Sphere_3(diam_branch3)
            CoordsMothBr = np.zeros(CroppedSegm.shape)
            CoordsMothBr[Coords_Branch3[:, 0], Coords_Branch3[:, 1], Coords_Branch3[:, 2]] = 1
            MotherBranch = ndimage.convolve(CoordsMothBr, k1, mode='reflect', cval=0.0)

        """
            Get the overlap between the ICA and the modelled vasculature :
        """
        MaskVascuMod = np.copy(FullStackModel)
        MaskVascuMod[MaskVascuMod > 0] = 1
        ICA_dil = ndimage.binary_dilation(ICA_Arr).astype(ICA_Arr.dtype)
        ICA_dil[ICA_dil > 0] = 1
        dil_mask = FullStackModel * ICA_dil
        MaskVascuModICA = MaskVascuMod + ICA_dil
        if MaskVascuModICA.max() == 2.0:
            MaskVascuModICA[MaskVascuModICA < 2] = 0
            MaskVascuModICA[MaskVascuModICA == 2] = 1
            if (MaskVascuModICA.sum() > ICA_dil.sum()*0.3):    ### <--- a third of the ICA should be outside the artery walls !
                print("------------------------------------------------------")
                print("ERROR... No Aneurysm was modelled ! (too much overlap)")
                print("------------------------------------------------------")
                FullStackModel = FullStackModel * 0.0
                ICA_Arr = ICA_Arr * 0.0
        else:
            print("----------------------------------------------------------------------")
            print("ERROR... No Aneurysm was modelled ! (ICA pushed outside vascular tree)")
            print("----------------------------------------------------------------------")
            FullStackModel = FullStackModel * 0.0
            ICA_Arr = ICA_Arr * 0.0
        avg_ica_gray = dil_mask[np.nonzero(dil_mask)].mean()
        ICA_Arr = ICA_Arr * avg_ica_gray


        ''' This is where we actually add (embed) the aneurysm: '''
        FullStackModel[ICA_Arr > 0] = ICA_Arr[ICA_Arr > 0]
    else:
        Thromb = np.ones(CroppedSegm.shape)

    ''' Apply a Gaussian Filtering to homogenize a bit the various branches' grey level amplitudes and fill the holes : '''
    ### TODO : Measure the Grey Level 'slope' along the artery wall (smoothness of the artery onto the background)
    ### TODO   and apply a Gaussian Filter 'sigma' accordingly !
    FullStackModel = gaussian_filter(FullStackModel, sigma=1.2)

    ''' This is where we actually add (embed) the aneurysm: '''
    #ICA_Arr = gaussian_filter(ICA_Arr, sigma=1.2)
    #FullStackModel = np.maximum(FullStackModel, ICA_Arr)
    #FullStackModel[ICA_Arr > 0] = ICA_Arr[ICA_Arr > 0]

    #avgArtMod = FullStackModel[np.nonzero(FullStackModel)].mean()
    #FullStackModel = FullStackModel * 2.0

    FullStackModel[FullStackModel < CroppedGray.mean()] = 0

    # FullStackSpline = elastic_transform(FullStackSpline, FullStackSpline.shape[1] * 0.04, FullStackSpline.shape[1] * 0.04, FullStackSpline.shape[1] * 0.04)
    # FullStackModel = elastic_transform(FullStackModel, FullStackModel.shape[1] * 0.04, FullStackModel.shape[1] * 0.04, FullStackModel.shape[1] * 0.04)
    ### OR :
    # FullStackSpline = elasticdeform.deform_random_grid(FullStackSpline, sigma=1., points=2)
    # FullStackModel = elasticdeform.deform_random_grid(FullStackModel, sigma=1., points=2)
    # FullStackSpline = np.abs(FullStackSpline)
    # FullStackModel = np.abs(FullStackModel)

    hE = int(CropExt / 2) # Half of the Extension
    z1,y1,x1 = CroppedGray.shape

    """ Reducing CropSize (after previous expansion) to have cleaner arteries diameters at the cube borders... """
    if NoShiftX == 1:
        CroppedGray = CroppedGray[hE:z1 - hE, hE:y1 - hE, 0:x1 - 2*hE]
        CroppedSegm = CroppedSegm[hE:z1 - hE, hE:y1 - hE, 0:x1 - 2*hE]
        FullStackModel = FullStackModel[hE:z1 - hE, hE:y1 - hE, 0:x1 - 2*hE]
        Thromb = Thromb[hE:z1 - hE, hE:y1 - hE, 0:x1 - 2*hE]
    elif NoShiftY == 1:
        CroppedGray = CroppedGray[hE:z1 - hE, 0:y1 - 2*hE, hE:x1 - hE]
        CroppedSegm = CroppedSegm[hE:z1 - hE, 0:y1 - 2*hE, hE:x1 - hE]
        FullStackModel = FullStackModel[hE:z1 - hE, 0:y1 - 2*hE, hE:x1 - hE]
        Thromb = Thromb[hE:z1 - hE, 0:y1 - 2*hE, hE:x1 - hE]
    elif NoShiftZ == 1:
        CroppedGray = CroppedGray[0:z1 - 2*hE, hE:y1 - hE, hE:x1 - hE]
        CroppedSegm = CroppedSegm[0:z1 - 2*hE, hE:y1 - hE, hE:x1 - hE]
        FullStackModel = FullStackModel[0:z1 - 2*hE, hE:y1 - hE, hE:x1 - hE]
        Thromb = Thromb[0:z1 - 2*hE, hE:y1 - hE, hE:x1 - hE]
    else:
        CroppedGray = CroppedGray[hE:z1 - hE, hE:y1 - hE, hE:x1 - hE]
        CroppedSegm = CroppedSegm[hE:z1 - hE, hE:y1 - hE, hE:x1 - hE]
        FullStackModel = FullStackModel[hE:z1 - hE, hE:y1 - hE, hE:x1 - hE]
        Thromb = Thromb[hE:z1 - hE, hE:y1 - hE, hE:x1 - hE]

    CropCoords = [Xc, Yc, Zc]

    if AddICA == 1:
        Vascu_Arr = Vascu_Arr[hE:z1 - hE, hE:y1 - hE, hE:x1 - hE]
        ICA_Arr = ICA_Arr[hE:z1 - hE, hE:y1 - hE, hE:x1 - hE]
        MotherBranch = MotherBranch[hE:z1 - hE, hE:y1 - hE, hE:x1 - hE]
        CleanVascu = CleanVascu[hE:z1 - hE, hE:y1 - hE, hE:x1 - hE]
        MotherBranch = np.float32(ndimage.binary_dilation(MotherBranch))
        MotherBranch[Vascu_Arr == 0] = 0

        #sitk.WriteImage(sitk.GetImageFromArray(FullStackModel),"/Users/florent/Desktop/FullStackModel.nrrd")
        #sitk.WriteImage(sitk.GetImageFromArray(Vascu_Arr),"/Users/florent/Desktop/Vascu_Arr.nrrd")
        #sitk.WriteImage(sitk.GetImageFromArray(CleanVascu),"/Users/florent/Desktop/CleanVascu.nrrd")
        #sitk.WriteImage(sitk.GetImageFromArray(ICA_Arr),"/Users/florent/Desktop/ICA_Arr.nrrd")
        if np.isnan(ICA_Arr.sum()) == True:
            FullStackModel = np.zeros(Vascu_Arr.shape)
        return (CropCoords, CroppedGray, CroppedSegm, FullStackModel, CleanVascu, ICA_Arr, MotherBranch, Thromb)
        #return (CropCoords, CroppedGray, CroppedSegm, FullStackModel, Vascu_Arr, ICA_Arr)
    else:
        return (CropCoords, CroppedGray, CroppedSegm, FullStackModel)
