function cTrans = WTGtransportCosts(o, data, Nturb, stocVar, markMods)

cTrans = 400e3 * Nturb;

%apply CPI inflation modifier and currency conversion%
cTrans = cTrans * costScalingFactor(o, data, 2020, 'GBP');%2014 originally

%apply any stochastic and market modifiers to WTG cost%
cTrans = cTrans * scenarioModifier('vessels.cost', stocVar, markMods);