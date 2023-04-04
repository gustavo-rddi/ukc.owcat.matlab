function cPlat = offshoreHVACplatformCost(o, data, capExp, vExport, stocVar, markMods)

%calculate offshore HVAC platform cost%
cPlat = 5014000 + 27750*((capExp/1e6)^0.7336)*((vExport/1e3)^0.4082);

%apply CPI inflation modifier%
cPlat = cPlat * costScalingFactor(o, data, 2012, 'GBP') * scenarioModifier('HVAC.cost', stocVar, markMods);