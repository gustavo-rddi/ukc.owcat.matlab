function cPlat = OTMplatformCost(o, data, stocVar, markMods)

%primary steel [GBP]%
cPS = 5070000;

%secondary steel [GBP]%
cSS = 2170000;

%sum costs%
cPlat = cPS + cSS;

%apply CPI inflation modifier%
cPlat = cPlat * costScalingFactor(o, data, 2019, 'GBP') * scenarioModifier('HVAC.cost', stocVar, markMods);