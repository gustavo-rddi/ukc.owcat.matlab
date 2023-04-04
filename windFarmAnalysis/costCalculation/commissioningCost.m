function Ccomm = commissioningCost(o, data, objType, nComm, stocVar, markMods)

hComm = data.(objType).hComm * scenarioModifier([objType, '.hComm'], stocVar, markMods); 

if isfield(data.(objType), 'LRinst')

    hComm = hComm * learningEffect(nComm, data.(objType).Nref, data.(objType).LRinst);

end

Ccomm = offshoreWorksCrew(o, data, hComm*nComm, 'comm', markMods, stocVar) ...
      + vesselCharterCost(o, data, hComm*nComm, 'CTV', [], markMods, stocVar);