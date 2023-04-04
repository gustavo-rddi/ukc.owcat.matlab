function [hPlan, Cvessels] = gbffloatingInstallModel(o, data, objVect, mode, objType, nObjPhase, stocVar, markMods)

%number of installation sites%
nPos = numel(objVect);

%default operation times%
hPrep = data.(objType).hPrep;
hHookUp = data.(objType).hHookUp;

if strcmpi(mode, 'decom')
    
    %decommissioning modifiers%
    hPrep = hPrep * (1 + data.(objType).fDecom);
    hHookUp = hHookUp * (1 + data.(objType).fDecom);

end

if isfield(data.(objType), 'LRinst')

    %apply learning-by-doing effects where available%
    hPrep = hPrep * learningEffect(nObjPhase, data.(objType).Nref, data.(objType).LRinst);
    hHookUp = hHookUp * learningEffect(nObjPhase, data.(objType).Nref, data.(objType).LRinst);

end

%weather window based on vessel choice%
wInst = data.vessel.(data.(objType).instVes).wOp;

%calculate vessel travelling and moving times%
hTravel = mean([objVect.dPortCon])*(1/data.vessel.(data.(objType).instVes).vTravel + 1/data.(objType).vTow);

%determine base charter duration%
hPlan = (hPrep + (hTravel+hHookUp)/wInst) * nPos;
 
Cvessels = vesselCharterCost(o, data, hPlan, data.(objType).instVes, [], stocVar, markMods) ...
         + vesselCharterCost(o, data, hPlan, 'ATV', [], stocVar, markMods) * data.(objType).Ntug;   