function o = HVACsubstationDecommissioning(o, data, stocVar, markMods)

if ~(strcmpi(o.design.expConf, 'OTM') && o.OWF.fndShare)
    
    %determine the number of PPs to be decommissioned%
    nPPdecom = getProcurementRequirement(o, data, 'fndComp', 'pinpile');
    
    %determine PP decommissioning vessel charter duration%
    [hPPdecom, NsuppPP, ~] = vesselCharterModel(o, data, o.offshoreSS, 'decom', 'PP', nPPdecom, stocVar, markMods);
    
    %add PP vessels to SS decommissioning requirements%
    o = addToVesselRequirements(o, data, 'SSdecom', data.PP.instVes, 1, hPPdecom, false);
    o = addToVesselRequirements(o, data, 'SSdecom', data.PP.compSup, NsuppPP, hPPdecom, false);
    
end

if strcmpi(o.design.expConf, 'OTM')
    
    if ~o.OWF.fndShare
    
        %determine the number of WTG-style jackets to be installed%
        nJKTdecom = getProcurementRequirement(o, data, 'fndComp', 'wtgJacket');
    
        %determine SS foundation decommissioning vessel charter duration%
        [hJKTdecom, NsuppJKT, ~] = vesselCharterModel(o, data, o.offshoreSS, 'decom', 'sJKT', nJKTdecom, stocVar, markMods);
    
        %add foundation vessels to SS decommissioning requirements%
        o = addToVesselRequirements(o, data, 'SSdecom', data.sJKT.instVes, 1, hJKTdecom, false);
        o = addToVesselRequirements(o, data, 'SSdecom', data.sJKT.compSup, NsuppJKT, hJKTdecom, false);
        
    end
       
    %determine OTM decommissioning vessel charter duration%
    [hOTMdecom, NsuppOTM, ~] = vesselCharterModel(o, data, o.offshoreSS, 'decom', 'OTM', o.OWF.nOSS, stocVar, markMods);
    
    %add OTM vessels to BOP decommissioning requirements%
    o = addToVesselRequirements(o, data, 'SSdecom', data.OTM.instVes, 1, hOTMdecom, false);
    o = addToVesselRequirements(o, data, 'SSdecom', data.OTM.compSup, NsuppOTM, hOTMdecom, false);
    
end

if strcmpi(o.design.expConf, 'OHVS')
    
    %determine the number of heavy SS jackets to be decomissioned%
    nJKTinstall = getProcurementRequirement(o, data, 'fndComp', 'hvyJacket');
    
    %determine SS foundation decommissioning vessel charter duration%
    [hJKTdecom, NsuppJKT, ~] = vesselCharterModel(o, data, o.offshoreSS, 'decom', 'hJKT', nJKTinstall, stocVar, markMods);
    
    %determine JKT decommissioning vessel charter duration%
    [hOHVSdecom, NsuppOHVS, ~] = vesselCharterModel(o, data, o.offshoreSS, 'decom', 'OHVS', o.OWF.nOSS+o.design.osComp, stocVar, markMods);
    
    %add OHVS jacket vessels to SS decommissioning requirements%
    o = addToVesselRequirements(o, data, 'SSdecom', data.hJKT.instVes, 1, hJKTdecom, false);
    o = addToVesselRequirements(o, data, 'SSdecom', data.hJKT.compSup, NsuppJKT, hJKTdecom, false);
         
    %add OHVS vessels to SS decommissioning requirements%
    o = addToVesselRequirements(o, data, 'SSdecom', data.OHVS.instVes, 1, hOHVSdecom, false);
    o = addToVesselRequirements(o, data, 'SSdecom', data.OHVS.compSup, NsuppOHVS, hOHVSdecom, false);
        
end

if o.design.osComp
    
    %determine the number of heavy SS jackets to be installed%
    nJKTinstall = getProcurementRequirement(o, data, 'fndComp', 'hvyJacket');
    
    %determine SS foundation installation vessel charter duration%
    [hJKTdecom, NsuppJKT, ~] = vesselCharterModel(o, data, o.offshoreCP, 'decom', 'hJKT', nJKTinstall, stocVar, markMods);
    
    %determine JKT installation vessel charter duration%
    [hOCPdecom, NsuppOHVS, ~] = vesselCharterModel(o, data, o.offshoreCP, 'decom', 'OHVS', o.OWF.nOSS+o.design.osComp, stocVar, markMods);
    
    %add OHVS jacket vessels to SS installation requirements%
    o = addToVesselRequirements(o, data, 'SSdecom', data.hJKT.instVes, 1, hJKTdecom, false);
    o = addToVesselRequirements(o, data, 'SSdecom', data.hJKT.compSup, NsuppJKT, hJKTdecom, false);
         
    %add OHVS vessels to SS installation requirements%
    o = addToVesselRequirements(o, data, 'SSdecom', data.OHVS.instVes, 1, hOCPdecom, false);
    o = addToVesselRequirements(o, data, 'SSdecom', data.OHVS.compSup, NsuppOHVS, hOCPdecom, false);
        
end
