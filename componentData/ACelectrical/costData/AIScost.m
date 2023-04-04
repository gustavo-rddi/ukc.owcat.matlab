function cAIS = AIScost(o, data, Vop, stocVar, markMods)

%calculate AIS unit cost%
cAIS = 20945.8*(Vop/1e3)^0.690;

%apply CPI inflation modifier%
cAIS = cAIS * costScalingFactor(o, data, 2012, 'GBP');

%apply any stochastic and market modifiers to equipment cost%
cAIS = cAIS * scenarioModifier('HVAC.cost', stocVar, markMods);