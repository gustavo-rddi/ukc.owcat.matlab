function [mMP mTP] = MPfoundationMass(dRot, dWater)

% %calculate MP and TP masses from correlations%
% %FCOW 2021 update - correlations from 'OWCAT Correlations Masterfile 20211026.xlsx/'Monopiles - FCOW21'%
% %Correlations behave better for turbines of 20-25 MW%

mMP = 1000*(5.919*10^(-8) + (2.154*10^(-4))*(dWater^1.078)*(dRot^2.170)); %in kg
mTP = 1000*(0.5873+2.325*(dWater^0.5507)*(dRot^0.6506)); % in kg




% % MP and TP mass correlation history


% %calculate MP and TP masses from DK correlations - potentially referring to Dunkirk 2018 correlations%
% mMP = 395914*exp(0.0234*dWater);
% mTP = 559.9*(dWater^0.2142)*(dRot^1.152);

% %FCOW 2020 correlation from 2019 OWCAT Data Update - Structural Mass Data - Analysis.xlsx%
% mMP = 92.6900164245174 + 0.740665334115867 *(dWater ^ 0.991689010258661) * (dRot ^ 0.725931749495663);
% mTP = 61.6600877043618 + 74.1427296898456 *(dWater ^ 0.245291800627034) * (dRot ^ 2.27307904751819E-06);
% 
% %tonnes -> kg%
% mMP = mMP*1000;
% mTP = mTP*1000;

% %Potentially post FCOW 2020 pre FCOW 2021 correlation %
%mMP = 159800 + 22.48*(dWater^1.277)*(dRot^1.236);
%mTP = 559.9*(dWater^0.2142)*(dRot^1.152);
