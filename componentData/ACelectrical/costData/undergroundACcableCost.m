function cCable = undergroundACcableCost(o, data, Asect, Vop, matCond, stocVar, markMods)

%correlation based on full set of data (Navitus and Ecofys) [EUR]%
cCable = 2.063*(Asect^0.3763)*((Vop/1e3)^0.5944)*(1 - 0.5388*any(strcmpi(matCond,  {'Aluminium', 'Al'}))); 

%apply CPI inflation modifier and currency conversion%
cCable = cCable * costScalingFactor(o, data, 2012, 'GBP');

%apply any stochastic and market modifiers to cable cost%
cCable = cCable * scenarioModifier('cables.cost', stocVar, markMods);