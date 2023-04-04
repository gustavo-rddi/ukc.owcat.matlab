function Cinstall = quaySideInstallation(o, data, objVect, mode, objType, nObjPhase, stocVar, markMods)

%number of installation sites%
nObjInstall = numel(objVect);

hInstall = data.(objType).hInstall;

if strcmpi(mode, 'decom')
    
    %decommissioning modifiers%
    hInstall = hInstall * (1 + data.(objType).fDecom);

end

if isfield(data.(objType), 'LRinst')

    %apply learning-by-doing effects where available%
    hInstall = hInstall * learningEffect(nObjPhase, data.(objType).Nref, data.(objType).LRinst);

end


if strcmpi(mode, 'install')

    %apply any stochastic and market modifiers to real and planned installation time%
    hInstallPlan = hInstall * scenarioModifier([objType,'.hInstPlan'], stocVar, markMods);
    
    hInstallReal = hInstallPlan * scenarioModifier([objType,'.hInstReal'], stocVar, markMods);
    
else
    
    %apply any stochastic and market modifiers to real and planned  decommissioning time%
    hInstallPlan = hInstall * scenarioModifier([objType,'.hDecomPlan'], stocVar, markMods);
        
    hInstallReal = hInstallPlan * scenarioModifier([objType,'.hDecomReal'], stocVar, markMods);
    
end

Cinstall = data.equip.crane * hInstallReal * nObjInstall;

%apply CPI inflation modifier and currency conversion%
Cinstall = Cinstall * costScalingFactor(o, data, data.vessel.yrRef, data.vessel.curr);