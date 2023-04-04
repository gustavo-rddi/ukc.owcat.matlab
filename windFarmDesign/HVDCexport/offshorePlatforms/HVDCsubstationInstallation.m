function o = HVDCsubstationInstallation(o, data, stocVar, markMods)

%determine the number of PPs to be installed%
nPPinstall = getProcurementRequirement(o, data, 'fndComp', 'pinpile');

%determine PP installation vessel charter duration%
[hPPinstSS, NsuppSS, ~] = vesselCharterModel(o, data, o.offshoreSS, 'install', 'PP', nPPinstall, stocVar, markMods);
[hPPinstConv, NsuppConv, ~] = vesselCharterModel(o, data, o.offshoreConv, 'install', 'PP', nPPinstall, stocVar, markMods);

%add PP vessels to SS installation requirements%
o = addToVesselRequirements(o, data, 'SSinst', data.PP.instVes, 1, hPPinstSS+hPPinstConv, false);
o = addToVesselRequirements(o, data, 'SSinst', data.PP.compSup, max(NsuppSS,NsuppConv), hPPinstSS+hPPinstConv, false);

%determine the number of heavy SS jackets to be installed%
nJKTinstall = getProcurementRequirement(o, data, 'fndComp', 'hvyJacket');
    
%determine SS foundation installation vessel charter duration%
[hJKTinstSS, NsuppSS, ~] = vesselCharterModel(o, data, o.offshoreSS, 'install', 'hJKT', nJKTinstall, stocVar, markMods);
[hJKTinstConv, NsuppConv, ~] = vesselCharterModel(o, data, o.offshoreConv, 'install', 'hJKT', nJKTinstall, stocVar, markMods);
    
%add OHVS jacket vessels to SS installation requirements%
o = addToVesselRequirements(o, data, 'SSinst', data.hJKT.instVes, 1, hJKTinstSS+hJKTinstConv, false);
o = addToVesselRequirements(o, data, 'SSinst', data.hJKT.compSup, max(NsuppSS,NsuppConv), hJKTinstSS+hJKTinstConv, false);

%determine JKT installation vessel charter duration%
[hCollInst, NsuppColl, ~] = vesselCharterModel(o, data, o.offshoreSS, 'install', 'OHVS', o.OWF.nOSS, stocVar, markMods);

%add OHVS vessels to SS installation requirements%
o = addToVesselRequirements(o, data, 'SSinst', data.OHVS.instVes, 1, hCollInst, false);
o = addToVesselRequirements(o, data, 'SSinst', data.OHVS.compSup, NsuppColl, hCollInst, false);

[hConvInst, NsuppConv, ~] = vesselCharterModel(o, data, o.offshoreConv, 'install', 'VSC', o.OWF.nConv, stocVar, markMods);
    
%add OHVS vessels to SS installation requirements%
o = addToVesselRequirements(o, data, 'SSinst', data.VSC.instVes, 1, hConvInst, false);
o = addToVesselRequirements(o, data, 'SSinst', data.VSC.compSup, NsuppConv, hConvInst, false);

%determine SP installation vessel charter duration%
[hSPinst, ~] = scourProtectionInstall(o, data, o.offshoreSS, 'hJKT', stocVar, markMods);

%add SP vessel to SS installation requirements%
o = addToVesselRequirements(o, data, 'SSinst', 'RDV', 1, hSPinst, false);