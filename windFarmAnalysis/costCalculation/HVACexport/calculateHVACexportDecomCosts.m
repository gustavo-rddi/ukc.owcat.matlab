function o = calculateHVACexportDecomCosts(o, data, stocVar, markMods)
    
if ~(strcmpi(o.design.expConf, 'OTM') && o.OWF.fndShare)
    
    %determine total number of pin-piles to installed this phase%
    nPPinstall = getProcurementRequirement(o, data, 'fndComp', 'pinpile');
    
    %determine PP installation vessel costs%
    [~, ~, CvesselPP] = vesselCharterModel(o, data, o.offshoreSS, 'decom', 'PP', nPPinstall, stocVar, markMods);
    
    o.DECEX.real.substationDecom = o.DECEX.real.substationDecom + CvesselPP;
    
end
    
if strcmpi(o.design.expConf, 'OTM')
    
    if ~o.OWF.fndShare
    
        %determine the number of WTG-style jackets to be installed%
        nJKTinstall = getProcurementRequirement(o, data, 'fndComp', 'wtgJacket');
    
        %determine overhead costs for JKT installation (scaled to remove any OTM contributions)%
        CoverheadJKT = jacketInstallOverheadCosts(o, data, nJKTinstall, stocVar, markMods) * o.OWF.nOSS/nJKTinstall;
        
        %determine SS foundation installation vessel charter duration and add to total%
        [~, ~, CvesselJKT] = vesselCharterModel(o, data, o.offshoreSS, 'decom', 'sJKT', nJKTinstall, stocVar, markMods);

        o.DECEX.real.substationDecom = o.DECEX.real.substationDecom + CvesselJKT + CoverheadJKT;
        
    end
       
    %determine OTM installation vessel charter duration%
    [~, ~, CvesselSS] = vesselCharterModel(o, data, o.offshoreSS, 'decom', 'OTM', o.OWF.nOSS, stocVar, markMods);
    
    o.DECEX.real.substationDecom = o.DECEX.real.substationDecom + CvesselSS;
    
end

if strcmpi(o.design.expConf, 'OHVS')
    
    %determine the number of heavy SS jackets to be installed%
    nJKTinstall = getProcurementRequirement(o, data, 'fndComp', 'hvyJacket');
    
    %determine overhead costs for JKT installation (scaled to remove any OTM contributions)%
    CoverheadJKT = jacketInstallOverheadCosts(o, data, nJKTinstall, stocVar, markMods) * 1/nJKTinstall;
    
    %determine JKT foundation installation vessel charter duration%
    [~, ~, CvesselJKT] = vesselCharterModel(o, data, o.offshoreSS, 'decom', 'hJKT', nJKTinstall, stocVar, markMods);
    
    %determine SS installation vessel charter duration%
    [~, ~, CvesselSS] = vesselCharterModel(o, data, o.offshoreSS, 'decom', 'OHVS', o.OWF.nOSS+o.design.osComp, stocVar, markMods);
    
    o.DECEX.real.substationDecom = o.DECEX.real.substationDecom + CvesselJKT + CvesselSS + CoverheadJKT;
        
end

if o.design.osComp
    
    %determine the number of heavy SS jackets to be installed%
    nJKTinstall = getProcurementRequirement(o, data, 'fndComp', 'hvyJacket');
    
    %determine overhead costs for JKT installation (scaled to remove any OTM contributions)%
    CoverheadJKT = jacketInstallOverheadCosts(o, data, nJKTinstall, stocVar, markMods) * 1/nJKTinstall;
    
    %determine SS foundation installation vessel charter duration%
    [~, ~, CvesselJKT] = vesselCharterModel(o, data, o.offshoreCP, 'decom', 'hJKT', nJKTinstall, stocVar, markMods);
        
    %determine JKT installation vessel charter duration%
    [~, ~, CvesselSS] = vesselCharterModel(o, data, o.offshoreCP, 'decom', 'OHVS', o.OWF.nOSS+o.design.osComp, stocVar, markMods);
    
    o.DECEX.real.substationDecom = o.DECEX.real.substationDecom + CvesselJKT + CvesselSS + CoverheadJKT;
        
end

for i = 1 : numel(o.vessels.SSdecom.type)
    
    %add vessel mobilisation costs to installation total%
    o.DECEX.real.substationDecom = o.DECEX.real.substationDecom + vesselMobilisationCost(o, data, o.vessels.SSdecom.type{i}, stocVar, markMods) * o.vessels.SSdecom.nVesMob(i);
    
end