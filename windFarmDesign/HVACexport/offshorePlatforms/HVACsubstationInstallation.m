function o = HVACsubstationInstallation(o, data, stocVar, markMods)

if ~(strcmpi(o.design.expConf, 'OTM') && o.OWF.fndShare)
    
    %determine the number of PPs to be installed%
    nPPinstall = getProcurementRequirement(o, data, 'fndComp', 'pinpile');
    
    %determine PP installation vessel charter duration%
    [hPPinst, NsuppPP, ~] = vesselCharterModel(o, data, o.offshoreSS, 'install', 'PP', nPPinstall, stocVar, markMods);
    
    %add PP vessels to SS installation requirements%
    o = addToVesselRequirements(o, data, 'SSinst', data.PP.instVes, 1, hPPinst, false);
    o = addToVesselRequirements(o, data, 'SSinst', data.PP.compSup, NsuppPP, hPPinst, false);
    
end

if strcmpi(o.design.expConf, 'OTM')
    
    if ~o.OWF.fndShare
    
        %determine the number of WTG-style jackets to be installed%
        nJKTinstall = getProcurementRequirement(o, data, 'fndComp', 'wtgJacket');
    
        %determine SS foundation installation vessel charter duration and add to total%
        [hJKTinst, NsuppJKT, ~] = vesselCharterModel(o, data, o.offshoreSS, 'install', 'sJKT', nJKTinstall, stocVar, markMods);
    
        %determine SP installation vessel charter duration%
        [hSPinst, ~] = scourProtectionInstall(o, data, o.offshoreSS, 'sJKT', stocVar, markMods);

        %add foundation vessels to SS installation requirements%
        o = addToVesselRequirements(o, data, 'SSinst', data.sJKT.instVes, 1, hJKTinst, false);
        o = addToVesselRequirements(o, data, 'SSinst', data.sJKT.compSup, NsuppJKT, hJKTinst, false);
        
        %add SP vessel to SS installation requirements%
        o = addToVesselRequirements(o, data, 'SSinst', 'RDV', 1, hSPinst, false);
        
    end
       
    %determine OTM installation vessel charter duration%
    [hOTMinst, NsuppOTM, ~] = vesselCharterModel(o, data, o.offshoreSS, 'install', 'OTM', o.OWF.nOSS, stocVar, markMods);
    
    %add OTM vessels to BOP installation requirements%
    o = addToVesselRequirements(o, data, 'SSinst', data.OTM.instVes, 1, hOTMinst, false);
    o = addToVesselRequirements(o, data, 'SSinst', data.OTM.compSup, NsuppOTM, hOTMinst, false);
    
end

if strcmpi(o.design.expConf, 'OHVS')
    
    %determine the number of heavy SS jackets to be installed%
    nJKTinstall = getProcurementRequirement(o, data, 'fndComp', 'hvyJacket');
    
    %determine SS foundation installation vessel charter duration%
    [hJKTinst, NsuppJKT, ~] = vesselCharterModel(o, data, o.offshoreSS, 'install', 'hJKT', nJKTinstall, stocVar, markMods);
    
    %determine JKT installation vessel charter duration%
    [hOHVSinst, NsuppOHVS, ~] = vesselCharterModel(o, data, o.offshoreSS, 'install', 'OHVS', o.OWF.nOSS+o.design.osComp, stocVar, markMods);
    
    %determine SP installation vessel charter duration%
    [hSPinst, ~] = scourProtectionInstall(o, data, o.offshoreSS, 'hJKT', stocVar, markMods);
    
    %add OHVS jacket vessels to SS installation requirements%
    o = addToVesselRequirements(o, data, 'SSinst', data.hJKT.instVes, 1, hJKTinst, false);
    o = addToVesselRequirements(o, data, 'SSinst', data.hJKT.compSup, NsuppJKT, hJKTinst, false);
         
    %add OHVS vessels to SS installation requirements%
    o = addToVesselRequirements(o, data, 'SSinst', data.OHVS.instVes, 1, hOHVSinst, false);
    o = addToVesselRequirements(o, data, 'SSinst', data.OHVS.compSup, NsuppOHVS, hJKTinst, false);
    
    %add SP vessel to SS installation requirements%
    o = addToVesselRequirements(o, data, 'SSinst', 'RDV', 1, hSPinst, false);
        
end

if o.design.osComp
    
    %determine the number of heavy SS jackets to be installed%
    nJKTinstall = getProcurementRequirement(o, data, 'fndComp', 'hvyJacket');
    
    %determine SS foundation installation vessel charter duration%
    [hJKTinst, NsuppJKT, ~] = vesselCharterModel(o, data, o.offshoreCP, 'install', 'hJKT', nJKTinstall, stocVar, markMods);
    
    %determine JKT installation vessel charter duration%
    [hOCPinst, NsuppOHVS, ~] = vesselCharterModel(o, data, o.offshoreCP, 'install', 'OHVS', o.OWF.nOSS+o.design.osComp, stocVar, markMods);
    
    %determine SP installation vessel charter duration%
    [hSPinst, ~] = scourProtectionInstall(o, data, o.offshoreCP, 'hJKT', stocVar, markMods);
    
    %add OHVS jacket vessels to SS installation requirements%
    o = addToVesselRequirements(o, data, 'SSinst', data.hJKT.instVes, 1, hJKTinst, false);
    o = addToVesselRequirements(o, data, 'SSinst', data.hJKT.compSup, NsuppJKT, hJKTinst, false);
         
    %add OHVS vessels to SS installation requirements%
    o = addToVesselRequirements(o, data, 'SSinst', data.OHVS.instVes, 1, hOCPinst, false);
    o = addToVesselRequirements(o, data, 'SSinst', data.OHVS.compSup, NsuppOHVS, hOCPinst, false);
    
    %add SP vessel to SS installation requirements%
    o = addToVesselRequirements(o, data, 'SSinst', 'RDV', 1, hSPinst, false);
        
end