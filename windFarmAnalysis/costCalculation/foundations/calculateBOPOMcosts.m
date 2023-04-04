function cBOP = calculateBOPOMcosts(o, data, nWTG, stocVar, markMods)

%cost of balance of plant inspections (Navitus)%
cFndMaint = 0.76e6*(nWTG/70).^(log(1.92)/log(2));

%cost of array cable inspections (Navitus)%
cArrayMaint = 0.52e6*(nWTG/70).^(log(1.92)/log(2));

%sum O&M costs%
cBOP = cFndMaint + cArrayMaint;

%apply any stochastic and market modifiers to WTG cost%
cBOP = cBOP * scenarioModifier('OM.turbInsp', stocVar, markMods);  

%apply CPI inflation modifier%
cBOP = cBOP * costScalingFactor(o, data, 2014, 'GBP'); 