function o = calculateArraySupplyCosts(o, data, stocVar, markMods)

for i = 1 : length(o.proc.arrayCable.type)
    
    %determine cost per m of array cable section (adj. to ref. year)%
    cSect = subseaACcableCost(o, data, o.proc.arrayCable.type(i), o.design.Varray, o.design.arrCond, stocVar, markMods);
    %cSect = subseaACcableCost(o, data, o.proc.arrayCable.type(i), 33e3, o.design.arrCond, stocVar, markMods);
    
    %determine cost per section of array cable auxiliaries (adj. to ref. year)%
    cAux = arrayCableAuxiliariesCost(o, data, o.proc.arrayCable.type(i), stocVar, markMods);
    
    cSupplyType = cSect*o.proc.arrayCable.lSupply(i)*scenarioModifier('array.lCable', stocVar, markMods) + cAux*o.proc.arrayCable.nSupply(i);
    
    o.CAPEX.real.arraySupply = o.CAPEX.real.arraySupply + cSupplyType;
    
end

%calculate load-out costs for array cables (adj. to ref. year) and add to cost total%
o.CAPEX.real.arraySupply = o.CAPEX.real.arraySupply + cableLoadOutCost(o, data, sum(o.proc.arrayCable.lSupply), stocVar, markMods);
