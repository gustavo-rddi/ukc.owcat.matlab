function mSS = SSfoundationMass(mTopSide, dRotor)

%calculate JKT and PP masses from correlations%
mSS = 1078+0.0007475*((mTopSide/1000)^1.211)*(dRotor^1.316);
