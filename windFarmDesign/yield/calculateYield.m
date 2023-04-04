function o = calculateYield(o, data, stocVar, markMods)

%inform of current operation%
%message(o, 'Calculating Wind Farm Yield...', 'single', 1);

o = generateProjectWindSpeeds(o, data, stocVar, markMods);

%determine ideal output of the WTGs%
o = calculateWTGoutput(o, data, stocVar, markMods);

%calculate array electrical efficiency%
o = calculateArrayEfficiency(o, data, stocVar, markMods);

%calulate annual wind farm yields%
o = calculateWindFarmYield(o, data, stocVar, markMods);

%display yield results%
displayYieldResults(o, 'single')