function cSCADA = SCADAcost(o, data, stocVar, markMods)

%calculate unit cost [GBP]%
cSCADA = 1364000;

%apply CPI inflation modifier%
cSCADA = cSCADA * costScalingFactor(o, data, 2019, 'GBP');

%apply any stochastic and market modifiers to equipment cost%
cSCADA = cSCADA * scenarioModifier('HVAC.cost', stocVar, markMods);
