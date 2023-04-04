function [hComm, Ccomm] = componentCommissioning(o, data, objType, nComm, stocVar, markMods)

hComm = data.(objType).hComm * nComm * scenarioModifier([objType, '.hCommPlan'], stocVar, markMods); 

if isfield(data.(objType), 'LRinst')

    hComm = hComm * learningEffect(nComm, data.(objType).Nref, data.(objType).LRinst);

end

hCommReal = hComm * scenarioModifier([objType, '.hCommReal'], stocVar, markMods); 

Ccomm = offshoreWorksCrew(o, data, hCommReal, 'comm', markMods, stocVar) ...
      + vesselCharterCost(o, data, hCommReal, 'CTV', [], markMods, stocVar);