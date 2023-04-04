function Cswitch = GIScost(o, data, Vop, loc, stocVar, markMods)

%correlation based on COIN data [GBP]%
Cswitch = 600.8 * ((Vop/1e3)^1.455);

%cost multipler for offshore units%
Cswitch = Cswitch * (1 + 0.2731*strcmpi(loc, 'offshore'));

%apply CPI inflation modifier%
Cswitch = Cswitch * costScalingFactor(o, data, 2012, 'GBP');%2012 original

%apply any stochastic and market modifiers to equipment cost%
Cswitch = Cswitch * scenarioModifier('HVAC.cost', stocVar, markMods);