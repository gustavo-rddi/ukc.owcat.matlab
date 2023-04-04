function Creact = shuntReactorCost(o, data, Qrate, Vop, loc, stocVar, markMods)

%correlation based on COIN data [GBP]%
Creact = 24850 * (Qrate/1e6).^0.7824 * (Vop/1e3)^0.1575 * (1 + 0.3*strcmpi(loc, 'offshore'));

%apply CPI inflation modifier%
Creact = Creact * costScalingFactor(o, data, 2012, 'GBP');

%apply any stochastic and market modifiers to equipment cost%
Creact = Creact * scenarioModifier('elec.cost', stocVar, markMods);