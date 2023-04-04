function Cps = primarySteelCost(o, data, mass, objType, nSupply, stocVar, markMods)

%calculate cost correction factor%
fCorr = (1 - data.(objType).fMan) * scenarioModifier('steel.cost', stocVar, markMods) ...
      + data.(objType).fMan * learningEffect(nSupply, data.(objType).Nref, data.(objType).LRman) * scenarioModifier('labour.cost', stocVar, markMods);

%calculate primary steel costs%
Cps = mass * data.(objType).cSteel * fCorr;

Cps = Cps * costScalingFactor(o, data, data.fnd.yrRef, data.fnd.curr);