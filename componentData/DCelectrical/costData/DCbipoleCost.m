function cCable = DCbipoleCost(o, data, Asect, Vop, matCond, stocVar, markMods)

%scale costs to different voltages from 2020 DNV cost data%
cCable = 60.07121+0.73666*(Asect^0.43194)*((Vop/1e3)^0.54689)*(1-0.3941*any(strcmpi(matCond,  {'Aluminium', 'Al'})))*o.finance.CuMult20;

%apply CPI inflation modifier and currency conversion%
cCable = cCable * costScalingFactor(o, data, 2020, 'GBP');

%apply any stochastic and market modifiers to cable cost%
cCable = cCable * scenarioModifier('cables.cost', stocVar, markMods);