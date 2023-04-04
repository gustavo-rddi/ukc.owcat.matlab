function [hTerm, Cterm] = cableTermination(o, data, cableType, nTerm, stocVar, markMods)

hTerm = 2*data.(cableType).hTerm * nTerm * scenarioModifier([cableType, '.hTermPlan'], stocVar, markMods); 

if isfield(data.(cableType), 'LRterm')

    hTerm = hTerm * learningEffect(nTerm, data.(cableType).Nref, data.(cableType).LRterm);

end

hTermReal = hTerm * scenarioModifier([cableType, '.hTermReal'], stocVar, markMods); 

Cterm = offshoreWorksCrew(o, data, hTermReal, 'term', markMods, stocVar) ...
      + vesselCharterCost(o, data, hTermReal, 'CTV', [], markMods, stocVar);