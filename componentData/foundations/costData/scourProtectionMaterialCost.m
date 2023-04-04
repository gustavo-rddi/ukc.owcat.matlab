function cMat = scourProtectionMaterialCost(o, data, mMat, markMods, ~)

cMat = data.fnd.cScour * mMat;

%apply CPI inflation modifier%
cMat = cMat * costScalingFactor(o, data, data.fnd.yrRef, data.fnd.curr);
            