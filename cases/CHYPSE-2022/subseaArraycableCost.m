function cCable = subseaArraycableCost(o, data, Asect, Vop, matCond, stocVar, markMods)

%correlation based on 2020 data from DNV [GBP]%
cCable = (43.25042 + 0.55381*(Asect^0.77251)*((Vop/1e3)^0.36922)*(1 - 0.4922*any(strcmpi(matCond,  {'Aluminium', 'Al'})))); 

%apply CPI inflation modifier and currency conversion%
cCable = cCable * costScalingFactor(o, data, 2020, 'GBP');

%apply any stochastic and market modifiers to cable cost%
cCable = cCable * scenarioModifier('cables.cost', stocVar, markMods);