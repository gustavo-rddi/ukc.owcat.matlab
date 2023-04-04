function o = HVDCsubstationDecommissioning(o, data, stocVar, markMods)

%determine the number of PPs to be installed%
nPPinstall = getProcurementRequirement(o, data, 'fndComp', 'pinpile');

%determine PP installation vessel charter duration%
[hPPinstSS, NsuppSS, ~] = vesselCharterModel(o, data, o.offshoreSS, 'decom', 'PP', nPPinstall, stocVar, markMods);
[hPPinstConv, NsuppConv, ~] = vesselCharterModel(o, data, o.offshoreConv, 'decom', 'PP', nPPinstall, stocVar, markMods);

%add PP vessels to SS installation requirements%
o = addToVesselRequirements(o, data, 'SSdecom', data.PP.instVes, 1, hPPinstSS+hPPinstConv, false);
o = addToVesselRequirements(o, data, 'SSdecom', data.PP.compSup, max(NsuppSS,NsuppConv), hPPinstSS+hPPinstConv, false);

%determine the number of heavy SS jackets to be installed%
nJKTinstall = getProcurementRequirement(o, data, 'fndComp', 'hvyJacket');
    
%determine SS foundation installation vessel charter duration%
[hJKTinstSS, NsuppSS, ~] = vesselCharterModel(o, data, o.offshoreSS, 'decom', 'hJKT', nJKTinstall, stocVar, markMods);
[hJKTinstConv, NsuppConv, ~] = vesselCharterModel(o, data, o.offshoreConv, 'decom', 'hJKT', nJKTinstall, stocVar, markMods);
    
%add OHVS jacket vessels to SS installation requirements%
o = addToVesselRequirements(o, data, 'SSdecom', data.hJKT.instVes, 1, hJKTinstSS+hJKTinstConv, false);
o = addToVesselRequirements(o, data, 'SSdecom', data.hJKT.compSup, max(NsuppSS,NsuppConv), hJKTinstSS+hJKTinstConv, false);

%determine JKT installation vessel charter duration%
[hCollInst, NsuppColl, ~] = vesselCharterModel(o, data, o.offshoreSS, 'decom', 'OHVS', o.OWF.nOSS, stocVar, markMods);

%add OHVS vessels to SS installation requirements%
o = addToVesselRequirements(o, data, 'SSdecom', data.OHVS.instVes, 1, hCollInst, false);
o = addToVesselRequirements(o, data, 'SSdecom', data.OHVS.compSup, NsuppColl, hCollInst, false);

[hConvInst, NsuppConv, ~] = vesselCharterModel(o, data, o.offshoreConv, 'decom', 'VSC', o.OWF.nConv, stocVar, markMods);
    
%add OHVS vessels to SS installation requirements%
o = addToVesselRequirements(o, data, 'SSdecom', data.VSC.instVes, 1, hConvInst, false);
o = addToVesselRequirements(o, data, 'SSdecom', data.VSC.compSup, NsuppConv, hConvInst, false);