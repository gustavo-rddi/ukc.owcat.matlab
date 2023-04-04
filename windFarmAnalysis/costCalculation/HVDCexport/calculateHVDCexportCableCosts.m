function o = calculateHVDCexportCableCosts(o, data, stocVar, markMods)
o.CAPEX.real.exportSupply_acoffcable =0;
o.CAPEX.real.exportSupply_dccable =0;




for i = 1 : length(o.proc.exportCable.type)
    
    %determine cost per m of subsea export cable section (adj. to ref. year)%
    cSect = subseaACcableCost(o, data, o.proc.exportCable.type(i), o.design.Vcoll, o.design.expCond, stocVar, markMods);
    
    o.CAPEX.real.exportSupply = o.CAPEX.real.exportSupply + cSect*o.proc.exportCable.lSupply(i);
    o.CAPEX.real.exportSupply_acoffcable = o.CAPEX.real.exportSupply_acoffcable + cSect*o.proc.exportCable.lSupply(i);
    
end

for i = 1 : length(o.proc.HVDCbipole.type)
    
    %determine cost per m of underground export cable section (adj. to ref. year)%
    cSect = DCbipoleCost(o, data, o.proc.HVDCbipole.type(i), o.design.Vexport, o.design.expCond, stocVar, markMods);
    
    %add to total supply cost for phase%
    o.CAPEX.real.exportSupply = o.CAPEX.real.exportSupply + cSect*o.proc.HVDCbipole.lSupply(i);
    o.CAPEX.real.exportSupply_dccable = o.CAPEX.real.exportSupply_dccable + cSect*o.proc.HVDCbipole.lSupply(i);
    
end

%calculate load-out costs for export cables cables%
CloadExport = cableLoadOutCost(o, data, sum(o.proc.exportCable.lSupply), stocVar, markMods);
o.CAPEX.real.exportSupply_acoffcable = o.CAPEX.real.exportSupply_acoffcable+CloadExport;
CloadBipole = cableLoadOutCost(o, data, sum(o.proc.HVDCbipole.lSupply), stocVar, markMods);
o.CAPEX.real.exportSupply_dccable = o.CAPEX.real.exportSupply_dccable +CloadBipole;

%sum to get total export cable supply costs%
o.CAPEX.real.exportSupply = o.CAPEX.real.exportSupply  + CloadExport + CloadBipole;
o.CAPEX.real.exportSupply_offcable = o.CAPEX.real.exportSupply_acoffcable + o.CAPEX.real.exportSupply_dccable;
