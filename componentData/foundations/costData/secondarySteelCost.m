function Css = secondarySteelCost(o, data, ~, stocVar, markMods)

%boat-landing and ladders [EUR]%
Cboat = 110000;

%internal platforms [EUR]%
Cint = 23000;

%array-cable J-tubes [EUR]%
Ctube = 62000;

%calculate cost correction factor%
fCorr = (1 - data.fnd.fManSS) * scenarioModifier('steel.cost', stocVar, markMods) ...
        + data.fnd.fManSS * scenarioModifier('labour.cost', stocVar, markMods);

%sum of secondary costs%
Css = (Cboat + Cint + Ctube) * fCorr;

%apply CPI inflation modifier and currency conversion%
Css = Css * costScalingFactor(o, data, 2019, 'EUR');