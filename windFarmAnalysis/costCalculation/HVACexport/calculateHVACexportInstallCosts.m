function o = calculateHVACexportInstallCosts(o, data, stocVar, markMods)

%calculate cost of offshore installation%
o = calculateHVACoffshoreInstallCosts(o, data, stocVar, markMods);

%calculate cost of export cable supply%
o = calculateHVACexportCableInstallCosts(o, data, stocVar, markMods);

%calculate cost of onshore installation%
o = calculateHVAConshoreInstallCosts(o, data, stocVar, markMods);

%calculate cost of offshore compensation installation%
if o.design.osComp
    o = calculateHVACcompensationInstallCosts(o, data, stocVar, markMods);
end

%calculate cost of interconnector cable installation%
if o.design.intConSS
    o = calculateHVACinterconnectorInstallCosts(o, data, stocVar, markMods);
end

o.CAPEX.real.exportInstall = 0;
o.CAPEX.real.substationInstall = 0;
o.CAPEX.real.onshoreInstall = 0;