function o = calculateHVACexportCableCosts(o, data, stocVar, markMods)



o.CAPEX.real.onshoreSupply_oncable=0;

for i = 1 : length(o.proc.exportCable.type)
    
    %determine cost per m of subsea export cable section (adj. to ref. year)%
    cSect = subseaACcableCost(o, data, o.proc.exportCable.type(i), o.design.Vexport, o.design.expCond, stocVar, markMods);
    
    o.CAPEX.real.exportSupply = o.CAPEX.real.exportSupply + cSect*o.proc.exportCable.lSupply(i);
   
end



for i = 1 : length(o.proc.onshoreCable.type)


    
    %determine cost per m of underground export cable section (adj. to ref. year)%
    cSect = undergroundACcableCost(o, data, o.proc.onshoreCable.type(i), o.design.Vexport, 'Al', stocVar, markMods);
    
    %add to total supply cost for phase%
    o.CAPEX.real.onshoreSupply = o.CAPEX.real.onshoreSupply + cSect*o.proc.onshoreCable.lSupply(i);
    o.CAPEX.real.onshoreSupply_oncable= o.CAPEX.real.onshoreSupply_oncable+ cSect*o.proc.onshoreCable.lSupply(i);
end



%calculate load-out costs for export cables cables%
CloadExport = cableLoadOutCost(o, data, sum(o.proc.exportCable.lSupply), stocVar, markMods);
CloadOnshore = cableLoadOutCost(o, data, 3*sum(o.proc.onshoreCable.lSupply), stocVar, markMods);

%sum to get total export cable supply costs%
o.CAPEX.real.exportSupply = o.CAPEX.real.exportSupply  + CloadExport;
o.CAPEX.real.onshoreSupply = o.CAPEX.real.onshoreSupply + CloadOnshore;
o.CAPEX.real.onshoreSupply_oncable= o.CAPEX.real.onshoreSupply_oncable+ CloadOnshore;