function cCable = subseaACcableCost(o, data, Asect, Vop, matCond, stocVar, markMods)

%correlation based on full set of data (incl. Navitus, Blyth and Ecofys) [EUR]%
cCable = (57.38 + 0.582*(Asect^0.7317)*((Vop/1e3)^0.3701)*(1 - 0.4922*any(strcmpi(matCond,  {'Aluminium', 'Al'})))); 

%apply CPI inflation modifier and currency conversion%
cCable = cCable * costScalingFactor(o, data, 2012, 'GBP');

%apply any stochastic and market modifiers to cable cost%
cCable = cCable * scenarioModifier('cables.cost', stocVar, markMods);
    