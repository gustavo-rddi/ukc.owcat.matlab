function o = calculateHVACoffshoreInstallCosts(o, data, stocVar, markMods)
    
if ~(strcmpi(o.design.expConf, 'OTM') && o.OWF.fndShare)
    
    %determine total number of pin-piles to installed this phase%
    nPPinstall = getProcurementRequirement(o, data, 'fndComp', 'pinpile');
    
    %determine PP installation vessel costs%
    [~, ~, CvesselPP] = vesselCharterModel(o, data, o.offshoreSS, 'install', 'PP', nPPinstall, stocVar, markMods);
    
    o.CAPEX.real.substationInstall = o.CAPEX.real.substationInstall + CvesselPP;
    
end
    
if strcmpi(o.design.expConf, 'OTM')
    
    if ~o.OWF.fndShare
    
        %determine the number of WTG-style jackets to be installed%
        nJKTinstall = getProcurementRequirement(o, data, 'fndComp', 'wtgJacket');
    
        %determine overhead costs for JKT installation (scaled to remove any OTM contributions)%
        CoverheadJKT = jacketInstallOverheadCosts(o, data, nJKTinstall, stocVar, markMods) * o.OWF.nOSS/nJKTinstall;
        
        %determine SS foundation installation vessel charter duration and add to total%
        [~, ~, CvesselJKT] = vesselCharterModel(o, data, o.offshoreSS, 'install', 'sJKT', nJKTinstall, stocVar, markMods);
    
        %determine SP installation vessel charter duration%
        [~, CscourJKT] = scourProtectionInstall(o, data, o.offshoreSS, 'sJKT', stocVar, markMods);

        o.CAPEX.real.substationInstall = o.CAPEX.real.substationInstall + CvesselJKT + CscourJKT + CoverheadJKT;
        
    end
       
    %determine OTM installation vessel charter duration%
    [~, ~, CvesselSS] = vesselCharterModel(o, data, o.offshoreSS, 'install', 'OTM', o.OWF.nOSS, stocVar, markMods);
    
    o.CAPEX.real.substationInstall = o.CAPEX.real.substationInstall + CvesselSS;
    
end

if strcmpi(o.design.expConf, 'OHVS')
    
    %determine the number of heavy SS jackets to be installed%
    nJKTinstall = getProcurementRequirement(o, data, 'fndComp', 'hvyJacket');
    
    %determine overhead costs for JKT installation (scaled to remove any OTM contributions)%
    CoverheadJKT = jacketInstallOverheadCosts(o, data, nJKTinstall, stocVar, markMods) * 1/nJKTinstall;
    
    %determine JKT foundation installation vessel charter duration%
    [~, ~, CvesselJKT] = vesselCharterModel(o, data, o.offshoreSS, 'install', 'hJKT', nJKTinstall, stocVar, markMods);
    
    %determine SP installation vessel charter duration%
    [~, CscourJKT] = scourProtectionInstall(o, data, o.offshoreSS, 'hJKT', stocVar, markMods);
    
    %determine SS installation vessel charter duration%
    [~, ~, CvesselSS] = vesselCharterModel(o, data, o.offshoreSS, 'install', 'OHVS', o.OWF.nOSS+o.design.osComp, stocVar, markMods);
    
    o.CAPEX.real.substationInstall = o.CAPEX.real.substationInstall + CvesselJKT + CscourJKT + CvesselSS + CoverheadJKT;
        
end

if o.design.osComp
    
    %determine the number of heavy SS jackets to be installed%
    nJKTinstall = getProcurementRequirement(o, data, 'fndComp', 'hvyJacket');
    
    %determine overhead costs for JKT installation (scaled to remove any OTM contributions)%
    CoverheadJKT = jacketInstallOverheadCosts(o, data, nJKTinstall, stocVar, markMods) * 1/nJKTinstall;
    
    %determine SS foundation installation vessel charter duration%
    [~, ~, CvesselJKT] = vesselCharterModel(o, data, o.offshoreCP, 'install', 'hJKT', nJKTinstall, stocVar, markMods);
        
    %determine SP installation vessel charter duration%
    [~, CscourJKT] = scourProtectionInstall(o, data, o.offshoreCP, 'hJKT', stocVar, markMods);    
    
    %determine JKT installation vessel charter duration%
    [~, ~, CvesselSS] = vesselCharterModel(o, data, o.offshoreCP, 'install', 'OHVS', o.OWF.nOSS+o.design.osComp, stocVar, markMods);
    
    o.CAPEX.real.substationInstall = o.CAPEX.real.substationInstall + CvesselJKT + CscourJKT + CvesselSS + CoverheadJKT;
        
end

for i = 1 : numel(o.vessels.SSinst.type)
    
    %add vessel mobilisation costs to installation total%
    o.CAPEX.real.substationInstall = o.CAPEX.real.substationInstall + vesselMobilisationCost(o, data, o.vessels.SSinst.type{i}, stocVar, markMods) * o.vessels.SSinst.nVesMob(i);
    
end