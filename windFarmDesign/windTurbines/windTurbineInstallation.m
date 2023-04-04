function o = windTurbineInstallation(o, data, stocVar, markMods)

if any(strcmpi({o.WTG.turbInst}, 'offshore'))

    iOffshore = strcmpi({o.WTG.turbInst}, 'offshore');

    %determine WTG installation vessel charter duration%
    [hWTGinst, NsupVes, ~] = vesselCharterModel(o, data, o.WTG(iOffshore), 'install', 'WTG', sum(iOffshore), stocVar, markMods);
  
    %add vessels to WTG installation requirements%
    o = addToVesselRequirements(o, data, 'WTGinst', data.WTG.instVes, 1, hWTGinst, true);
    o = addToVesselRequirements(o, data, 'WTGinst', data.WTG.compSup, NsupVes, hWTGinst, true);
    
end

%determine time for WTG commissioning (with learning effects)%
[hComm, ~] = componentCommissioning(o, data, 'WTG', o.OWF.nWTG, stocVar, markMods);

%add commissioning crew to installation requirements%
o = addToCrewRequirements(o, data, 'WTGinst', 'comm', hComm);