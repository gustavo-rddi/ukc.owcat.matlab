function cTrans = monopileTransportCosts(o, data, nSupply, stocVar, markMods)

%transport of monopile foundation [EUR]%
cTrans = 8300000 * (nSupply/70)^0.5;

%apply CPI inflation modifier and currency conversion%
cTrans = cTrans * costScalingFactor(o, data, 2019, 'EUR');

%apply any stochastic and market modifiers to WTG cost%
cTrans = cTrans * scenarioModifier('vessels.cost', stocVar, markMods);