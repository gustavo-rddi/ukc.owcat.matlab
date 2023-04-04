function o = HVDCexportCableInstallation(o, data, stocVar, markMods)

%determine charter times for cable laying and burial%
[hLay, hBury, ~] = postLayBurialModel(o, data, o.OWF.lExportLay, o.offshoreConv, 'export', o.OWF.nExportCable+o.OWF.nCollCable,  stocVar, markMods);

%add vessels to WTG installation requirements%
o = addToVesselRequirements(o, data, 'exportInst', 'CLV', 1, hLay, true);
o = addToVesselRequirements(o, data, 'exportInst', 'OCV', 1, hBury, true);

%determine time for cable termination (with learning effects)%
hTerm = data.HVAC.hTerm * (o.OWF.nExportCable+o.OWF.nCollCable) * learningEffect(o.OWF.nExportCable+o.OWF.nCollCable, data.HVAC.Nref, data.HVAC.LRterm);

%add termination crew to installation requirements%
o = addToCrewRequirements(o, data, 'exportInst', 'term', hTerm);
