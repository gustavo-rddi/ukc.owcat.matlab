function Ctrans = transformerCost(o, data, Prate, Vop, loc, stocVar, markMods)

%cost correlation for onshore units [GBP]%
Ctrans = 291.3e3 + 8647 * ((Prate/1e6)^0.8053) * ((Vop/1e3)^0.1809) * (1 + 0.6215*strcmpi(loc, 'offshore'));

%apply CPI inflation modifier%
Ctrans = Ctrans * costScalingFactor(o, data, 2012, 'GBP');

%apply any stochastic and market modifiers to equipment cost%
Ctrans = Ctrans * scenarioModifier('HVAC.cost', stocVar, markMods);