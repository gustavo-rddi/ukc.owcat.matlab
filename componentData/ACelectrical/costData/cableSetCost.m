function Cset = cableSetCost(o, data, Vop, loc, stocVar, markMods)

%correlation based on COIN data [GBP]%
Cset = 1114 * ((Vop/1e3)^0.9160);

%cost multipler for offshore units%
Cset = Cset * (1 + 0.3*strcmpi(loc, 'offshore'));

%apply CPI inflation modifier%
Cset = Cset * costScalingFactor(o, data, 2012, 'GBP');%2012 originally

%apply any stochastic and market modifiers to equipment cost%
Cset = Cset * scenarioModifier('cables.cost', stocVar, markMods);