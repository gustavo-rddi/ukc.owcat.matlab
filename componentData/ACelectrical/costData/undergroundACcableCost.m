function cCable = undergroundACcableCost(o, data, Asect, Vop, matCond, stocVar, markMods)

%correlation based on 2020 cost data from DNV [GBP]%
cCable = 57.38664+0.49529*(Asect^0.64938)*((Vop/1e3)^0.25146)*(1 - 0.5388*any(strcmpi(matCond,  {'Aluminium', 'Al'})))*o.finance.CuMult20; 

%apply CPI inflation modifier and currency conversion%
cCable = cCable * costScalingFactor(o, data, 2021, 'GBP');

%apply any stochastic and market modifiers to cable cost%
cCable = cCable * scenarioModifier('cables.cost', stocVar, markMods);