function [mMP mTP] = MPfoundationMass(dRot, dWater)

% %calculate MP and TP masses from correlations%
mMP = 159800 + 22.48*(dWater^1.277)*(dRot^1.236);
mTP = 559.9*(dWater^0.2142)*(dRot^1.152);

% %calculate MP and TP masses from DK correlations%
% mMP = 395914*exp(0.0234*dWater);
% mTP = 559.9*(dWater^0.2142)*(dRot^1.152);

% %FCOW 2020 correlation from 2019 OWCAT Data Update - Structural Mass Data - Analysis.xlsx%
% mMP = 92.6900164245174 + 0.740665334115867 *(dWater ^ 0.991689010258661) * (dRot ^ 0.725931749495663);
% mTP = 61.6600877043618 + 74.1427296898456 *(dWater ^ 0.245291800627034) * (dRot ^ 2.27307904751819E-06);
% 
% %tonnes -> kg%
% mMP = mMP*1000;
% mTP = mTP*1000;