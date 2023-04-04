function o = windTurbineDecommissioning(o, data, stocVar, markMods)

if any(strcmpi({o.WTG.turbInst}, 'offshore'))

    %determine WTG installation vessel charter duration%
    [hWTGdecom, NsupVes, ~] = vesselCharterModel(o, data, o.WTG, 'decom', 'WTG', o.OWF.nWTG, stocVar, markMods);

    o = addToVesselRequirements(o, data, 'WTGdecom', data.WTG.instVes, 1, hWTGdecom, true);
    o = addToVesselRequirements(o, data, 'WTGdecom', data.WTG.compSup, NsupVes, hWTGdecom, true);
       
end