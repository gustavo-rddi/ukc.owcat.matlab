function cCable = DCbipoleCost(o, data, Asect, Vop, matCond, stocVar, markMods)

%scale costs to different voltages%
cCable = 6.987*(Asect^0.3072)*((Vop/1e3)^0.3853)*(1-0.3941*any(strcmpi(matCond,  {'Aluminium', 'Al'})));

%apply CPI inflation modifier and currency conversion%
cCable = cCable * costScalingFactor(o, data, 2012, 'GBP');

%apply any stochastic and market modifiers to cable cost%
cCable = cCable * scenarioModifier('cables.cost', stocVar, markMods);