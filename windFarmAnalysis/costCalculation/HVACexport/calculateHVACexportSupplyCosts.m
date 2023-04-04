function o = calculateHVACexportSupplyCosts(o, data, stocVar, markMods)

%calculate cost of offshore substation supply%
o = calculateHVACoffshoreSubstationCosts(o, data, stocVar, markMods);

%calculate cost of export cable supply%
o = calculateHVACexportCableCosts(o, data, stocVar, markMods);

%calculate cost of onshore equipment supply%
o = calculateHVACgridSubstationCosts(o, data, stocVar, markMods);

%calculate costs for landfall substation%
if o.design.lfComp
    o = calculateHVAClandfallSubstationCosts(o, data, stocVar, markMods);
end

%calculate costs for offshore compensation platform%
if o.design.osComp
    o = calculateHVACoffshoreCompensationCosts(o, data, stocVar, markMods);
end

%calculate costs for interconnector cables%
if o.design.intConSS
    o = calculateHVACinterconnectorCosts(o, data, stocVar, markMods);
end