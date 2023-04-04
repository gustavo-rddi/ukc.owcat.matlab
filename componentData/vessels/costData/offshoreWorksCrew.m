function cCharter = offshoreWorksCrew(o, data, hCharter, crewType, markMods, stocVar) 

%calculate offshore crew cost (with vessel)%
cCharter = hCharter * data.crew.(crewType).dayRate;

%apply CPI inflation modifier%
cCharter = cCharter * costScalingFactor(o, data, data.vessel.yrRef, data.vessel.curr);

%apply any stochastic and market modifiers to WTG cost%
cCharter = cCharter * scenarioModifier('labour.cost', stocVar, markMods);
