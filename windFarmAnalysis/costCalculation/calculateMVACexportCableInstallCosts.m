function o = calculateMVACexportCableInstallCosts(o, data, stocVar, markMods)

%calculate cost of pre-laying activities%
Cprelay = cablePreLayingCosts(o, data, o.OWF.lExportLay, stocVar, markMods);

iWTG = zeros(1,o.OWF.nString);

for i = 1 : o.OWF.nString
   
    iWTG(i) = o.arrayString(i).iWTGstring(end);
    
end

%determine charter times for cable laying and burial%
[~, ~, Cvessels] = postLayBurialModel(o, data, o.OWF.lExportLay, o.WTG(iWTG), 'array', o.OWF.nExportCable,  stocVar, markMods);

%determine cable landfall costs%
Clandfall = cableLandfallCost(o, data, o.OWF.nExportCable, stocVar, markMods);

[~, Cterm] = cableTermination(o, data, 'HVAC', o.OWF.nExportCable, stocVar, markMods);

%sum export cable installation costs%
o.CAPEX.real.exportInstall = o.CAPEX.real.exportInstall + Cprelay +  Cvessels + Clandfall + Cterm;

%calculate cable installation costs%
CinstCBL = undergroundCableInstallationCost(o, data, sum(o.proc.onshoreCable.lSupply), stocVar, markMods) ...
         + undergroundCableOverheadCost(o, data, o.OWF.nExportCable, stocVar, markMods);

%calculate total phase installation costs%
o.CAPEX.real.onshoreInstall = o.CAPEX.real.onshoreInstall + CinstCBL;
