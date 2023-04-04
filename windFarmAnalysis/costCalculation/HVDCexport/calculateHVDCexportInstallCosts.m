function o = calculateHVDCexportInstallCosts(o, data, stocVar, markMods)

%calculate cost of offshore installation%
o = calculateHVDCoffshoreInstallCosts(o, data, stocVar, markMods);

o = calculateHVDCexportCableInstallCosts(o, data, stocVar, markMods);

%calculate cost of onshore installation%
o = calculateHVDConshoreInstallCosts(o, data, stocVar, markMods);