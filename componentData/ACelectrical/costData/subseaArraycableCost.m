function cCable = subseaArraycableCost(o, data, Asect, Vop, matCond, stocVar, markMods)

%correlation based on 2020 data from DNV [GBP]+ South Brittany tender%
cCable = (298.21654 + 0.08984*(Asect^0.81596)*((Vop/1e3)^0.70909)*(1 - 0.4922*any(strcmpi(matCond,  {'Aluminium', 'Al'}))))*o.finance.CuMult22; 

%apply CPI inflation modifier and currency conversion%
cCable = cCable * costScalingFactor(o, data, 2022, 'EUR');

%apply any stochastic and market modifiers to cable cost%
cCable = cCable * scenarioModifier('cables.cost', stocVar, markMods);