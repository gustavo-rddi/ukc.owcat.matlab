function [mJKT mPP] = JKTfoundationMass(mTopSide, dWater, soilType)

% %calculate JKT and PP masses from correlations%
% %FCOW 2021 update - correlations from 'OWCAT Correlations Masterfile 20211026.xlsx/'Jackets - FCOW21'%
% %Correlations behave better for turbines of 20-25 MW%
%convert kg -> tonnes for topside mass
mTopSide = mTopSide/1e3;

mJKT = 1000*((410.2 + (6.027*10^(-3)) *(dWater ^ 0.8384) * (mTopSide ^ 1.113))); %in kg
mPP = 1000*(131.2 + 0.01949 *(dWater ^ 0.06387) * (mTopSide ^ 1.123)*(1-soilType*0.120289381)); % in kg




% % JKT and PP mass correlation history


% %calculate JKT and PP masses from correlations - Potentially pre FCOW 2020 correlations%
% mJKT = 122000 + 921.1*(dWater^0.3563)*((mTopSide/1000)^0.7716);
% mPP = 4437*(dWater^0.08144)*((mTopSide/1000)^0.6433);

%kg -> tonnes%

%FCOW 2020 correlation from 2019 OWCAT Data Update - Structural Mass Data - Analysis.xlsx%
%mJKT = 27.1590884503128 + 1.56684810114677 *(dWater ^ 0.820772707160496) * (mTopSide ^ 0.517291505729586);
%mPP = 0.0947194064568432 + 0.744573333783794 *(dWater ^ 2.04317113328279E-06) * (mTopSide ^ 0.874182585402573);

%tonnes -> kg%
%mJKT = mJKT*1000;
%mPP = mPP*1000;


