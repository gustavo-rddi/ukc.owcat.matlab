function cPlat = offshoreHVACplatformCost(o, data, capExp, vExport, stocVar, markMods)

%calculate offshore HVAC platform cost%
cPlat = 8*5014000 + 27750*((capExp/1e6)^0.15)*((vExport/1e3)^0.4082); %0.7336 original expoenent for capExp not so dependent on capacity but fixed costs

%apply CPI inflation modifier%
cPlat = cPlat * costScalingFactor(o, data, 2021, 'GBP') * scenarioModifier('HVAC.cost', stocVar, markMods);%2012