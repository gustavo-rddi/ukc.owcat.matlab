function cCable = subseaACcableCost(o, data, Asect, Vop, matCond, stocVar, markMods)

%correlation based on 2020 data from DNV and 2021 costs from EDF R Fr & EDF R UK [GBP]%
cCable = (60.01253 + 0.71098*(Asect^0.53716)*((Vop/1e3)^0.52934)*(1 - 0.04730*any(strcmpi(matCond,  {'Aluminium', 'Al'}))))*o.finance.CuMult20; 

%apply CPI inflation modifier and currency conversion%
cCable = cCable * costScalingFactor(o, data, 2021, 'GBP');

%apply any stochastic and market modifiers to cable cost%
cCable = cCable * scenarioModifier('cables.cost', stocVar, markMods);
    