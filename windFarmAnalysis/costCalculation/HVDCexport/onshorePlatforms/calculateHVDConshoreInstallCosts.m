function o = calculateHVDConshoreInstallCosts(o, data, stocVar, markMods)

%determine total length of cable to install%
lExportOnshore = sum([o.offshoreConv.lCableOnshore].*[o.offshoreConv.nExportCable]);

%calculate cable installation costs%
CinstCBL = undergroundCableInstallationCost(o, data, lExportOnshore, stocVar, markMods) ...
         + undergroundCableOverheadCost(o, data, o.OWF.nExportCable, stocVar, markMods);

%calculate total phase installation costs%
o.CAPEX.real.onshoreInstall = o.CAPEX.real.onshoreInstall + CinstCBL;