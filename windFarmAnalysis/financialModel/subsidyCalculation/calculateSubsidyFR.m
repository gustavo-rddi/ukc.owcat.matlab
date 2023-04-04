function o = calculateSubsidyFR(o, data, stocVar, markMods)

%use simple LCOE as first-guess value%
P0Rguess = getP0Restimate(o, data);
P0Eguess = getP0Eestimate(o, data);

o.P0R.CF = fixedP0RcashFlows(o, data, stocVar, markMods);

o.P0R.value = fzero(@(x)evaluateProjectNPV(o, o.P0R.CF, data, x, 'P0R'), P0Rguess);
    
o.P0R.CF = variableP0RcashFlows(o, o.P0R.CF, data, o.P0R.value);

o.P0E.CF = fixedP0EcashFlows(o, data, o.P0R.value, stocVar, markMods);

%calculate nominal LCOE values and strike prices%
o.P0E.value = fzero(@(x)evaluateProjectNPV(o, o.P0E.CF, data, x, 'P0E'), P0Eguess);

o.P0E.CF = variableP0EcashFlows(o, o.P0E.CF, data, o.P0E.value);
