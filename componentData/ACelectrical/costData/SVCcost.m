function cSVC = SVCcost(o, data, Prate, stocVar, markMods)

%correlation based on COIN data%
cSVC = 256277 * (Prate/1e6)^0.7596;

%apply CPI inflation modifier%
cSVC = cSVC * costScalingFactor(o, data, 2012, 'GBP');

%apply any stochastic and market modifiers to equipment cost%
cSVC = cSVC * scenarioModifier('elec.cost', stocVar, markMods);