function o = MVACexportCableInstallation(o, data, stocVar, markMods)

iWTG = zeros(1,o.OWF.nString);

for i = 1 : o.OWF.nString
   
    iWTG(i) = o.arrayString(i).iWTGstring(end);
    
end

%determine charter times for cable laying and burial%
[hLay, hBury, ~] = postLayBurialModel(o, data, o.OWF.lExportLay, o.WTG(iWTG), 'array', o.OWF.nExportCable,  stocVar, markMods);

%add vessels to WTG installation requirements%
o = addToVesselRequirements(o, data, 'exportInst', 'CLV', 1, hLay, true);
o = addToVesselRequirements(o, data, 'exportInst', 'OCV', 1, hBury, true);

%determine time for cable termination (with learning effects)%
hTerm = data.HVAC.hTerm * o.OWF.nExportCable * learningEffect(o.OWF.nExportCable, data.HVAC.Nref, data.HVAC.LRterm);

%add termination crew to installation requirements%
o = addToCrewRequirements(o, data, 'exportInst', 'term', hTerm);
