function cAux = arrayCableAuxiliariesCost(o, data, Asect, stocVar, markMods)

%cable termination kits [EUR]
cTerm = 2 * 3 * 5400;

%cable hang-off assembly (as function of cable section) [EUR]%
cHangOff = 2 * (616+0.1789*Asect + 0.001336*Asect^2);

%cable protection systems [EUR]%
cProtect = 2 * 29500;

%sum auxiliary costs%
cAux = cTerm + cHangOff + cProtect;

%apply CPI inflation modifier%
cAux = cAux * costScalingFactor(o, data, 2019, 'EUR');

%apply any stochastic and market modifiers to cable cost%
cAux = cAux * scenarioModifier('cables.cost', stocVar, markMods);