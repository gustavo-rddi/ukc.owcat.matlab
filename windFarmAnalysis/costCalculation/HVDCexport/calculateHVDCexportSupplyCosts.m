function o = calculateHVDCexportSupplyCosts(o, data, stocVar, markMods)

%calculate cost of offshore substation supply%
o = calculateHVDCcollectorCosts(o, data, stocVar, markMods);
o = calculateHVDCconverterCosts(o, data, stocVar, markMods);

%calculate cost of export cable supply%
o = calculateHVDCexportCableCosts(o, data, stocVar, markMods);

%calculate cost of onshore equipment supply%
o = calculateHVDCgridSubstationCosts(o, data, stocVar, markMods);