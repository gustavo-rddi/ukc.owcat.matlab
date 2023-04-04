function mTower = WTGtowerMass(dRot, mHub)

%determine WTG tower mass%
mTower = 32520 + 2725*(dRot^0.111)*((mHub/1e3)^0.6494);