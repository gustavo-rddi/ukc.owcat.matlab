function [hPlan, Cvessels] = mooringInstallModel(o, data, objVect, mode, objType, nObjPhase, stocVar, markMods)

%number of installation sites%
nPos = numel(objVect);

%number of objects to install%
if strcmpi(objType, 'PP') 
    nObjInstall = sum([objVect.nMoor]);
else
    nObjInstall = nPos;
end

%default operation times%
hLoad = data.(objType).hLoad;
hInstall = data.(objType).hInstall;
hSurvey = data.(objType).hSurvey;

if strcmpi(mode, 'decom')
    
    %decommissioning modifiers%
    hLoad = hLoad * (1 + data.(objType).fDecom);
    hInstall = hInstall * (1 + data.(objType).fDecom);

end

if isfield(data.(objType), 'LRinst')

    %apply learning-by-doing effects where available%
    hLoad = hLoad * learningEffect(nObjPhase, data.(objType).Nref, data.(objType).LRinst);
    hInstall = hInstall * learningEffect(nObjPhase, data.(objType).Nref, data.(objType).LRinst);

end

%weather window based on vessel choice%
wInst = data.vessel.(data.(objType).instVes).wOp;

%calculate vessel travelling and moving times%
hTravel = 2*mean([objVect.dPortCon])/data.vessel.(data.(objType).instVes).vTravel;

%determine base charter duration%
hPlan = (hPrep + (hTravel+hHookUp)/wInst) * nPos;
 
Cvessels = vesselCharterCost(o, data, hPlan, data.(objType).instVes, [], stocVar, markMods) ...
         + vesselCharterCost(o, data, hPlan, 'ATV', [], stocVar, markMods) * data.(objType).Ntug;   