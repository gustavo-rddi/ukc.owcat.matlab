function Ccomm = WTGcomissioningCost(o, data, objType, nComm, ~, ~)

hComm = data.(objType).hComm * learningEffect(nComm, data.(objType).Nref, data.(objType).LRinst);

hComm = applyScenarioModifier(hComm, [objType, '.hComm'], stocVar, markMods);

Ccomm = offshoreWorksCrew(o, data, hComm, 'comm', markMods, stocVar) ...
      + vesselCharterCost(o, data, hComm, 'CTV', [], markMods, stocVar);