function [mJKT mPP] = JKTfoundationMass(mTopSide, dWater)

% %calculate JKT and PP masses from correlations%
% mJKT = 122000 + 921.1*(dWater^0.3563)*((mTopSide/1000)^0.7716);
% mPP = 4437*(dWater^0.08144)*((mTopSide/1000)^0.6433);

%kg -> tonnes%
mTopSide = mTopSide/1000;

%FCOW 2020 correlation from 2019 OWCAT Data Update - Structural Mass Data - Analysis.xlsx%
mJKT = 27.1590884503128 + 1.56684810114677 *(dWater ^ 0.820772707160496) * (mTopSide ^ 0.517291505729586);
mPP = 0.0947194064568432 + 0.744573333783794 *(dWater ^ 2.04317113328279E-06) * (mTopSide ^ 0.874182585402573);

%tonnes -> kg%
mJKT = mJKT*1000;
mPP = mPP*1000;