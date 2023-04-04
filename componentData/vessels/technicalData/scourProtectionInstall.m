function [hCharter, Cinstall] = scourProtectionInstall(o, data, objVect, objType, markMods, stocVar)

nPos = numel(objVect);

mTotInstall = data.(objType).mSPmat * nPos;

%number of transport trips to and from construction port%
Ntrip = ceil(mTotInstall/data.vessel.RDV.capSP);

hTravel = 2*mean([objVect.dPortCon])/data.vessel.RDV.vTravel;
hMove = mean([objVect.dSpace])/data.vessel.RDV.vTravel;

%determine time to install scour protection%
hCharter = mTotInstall/data.vessel.RDV.vLoad ...
         + (mTotInstall/data.vessel.RDV.vInst)/data.vessel.RDV.wOp ...
         + (hTravel/data.vessel.RDV.wOp) * Ntrip ...
         + (hMove/data.vessel.RDV.wOp) * (nPos - Ntrip);
     
Cinstall = vesselCharterCost(o, data, hCharter, 'RDV', [], markMods, stocVar) ...
         + scourProtectionMaterialCost(o, data, mTotInstall, markMods, stocVar);