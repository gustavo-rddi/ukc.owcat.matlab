function o = calculateFoundationSupplyCosts(o, data, stocVar, markMods)


if any(strcmpi({o.WTG.fndType}, 'oblyth'))
o.CAPEX.real.fndSupply= o.GBF.supply.oblyth;
return;
end
if any(strcmpi({o.WTG.fndType}, 'o500gbf'))
o.CAPEX.real.fndSupply= o.GBF.supply.o500gbf;
return;
end
if any(strcmpi({o.WTG.fndType}, 'o500jkt'))
o.CAPEX.real.fndSupply= o.GBF.supply.o500jkt;
return; 
end


if any(strcmpi({o.WTG.fndType}, 'monopile'))
    
    %determine the number of monopiles to be ordered this phase%
    nMPsupply = getProcurementRequirement(o, data, 'fndComp', 'monopile');
    
    %determine overhead costs for monopile supply%
    CoverheadMP = monopileSupplyOverheadCosts(o, data, nMPsupply, stocVar, markMods);
    
    CtransportMP = monopileTransportCosts(o, data, nMPsupply, stocVar, markMods);
        
    o.CAPEX.real.fndSupply = o.CAPEX.real.fndSupply + CoverheadMP + CtransportMP;
    
end

if any(strcmpi({o.WTG.fndType}, 'jacket'))
    
    %determine the number of jackets and pin-piles to be ordered this phase%
    nJKTsupply = getProcurementRequirement(o, data, 'fndComp', 'wtgJacket');
    nPPsupply = getProcurementRequirement(o, data, 'fndComp', 'pinpile');
    
    %determine overhead costs for jacket supply%
    CoverheadJKT = jacketSupplyOverheadCosts(o, data, nJKTsupply, stocVar, markMods);
    
    CtransportJKT = jacketTransportCosts(o, data, nJKTsupply, stocVar, markMods);
    
    o.CAPEX.real.fndSupply = o.CAPEX.real.fndSupply + CoverheadJKT + CtransportJKT;
        
end

if any(strcmpi({o.WTG.fndType}, 'semisub'))
    
    iSS = strcmpi({o.WTG.fndType}, 'semisub');
    
    nSSsupply = getProcurementRequirement(o, data, 'fndComp', 'semisub');
    nAnchSupply = getProcurementRequirement(o, data, 'fndComp', 'drag');
    %Same cost overheads as for a jacket foundation
    CoverheadSS = jacketSupplyOverheadCosts(o, data, nSSsupply, stocVar, markMods);
        
    Cmoor = mooringLineCost(o, data, sum([o.WTG(iSS).lMoor].*[o.WTG(iSS).nMoor]), nAnchSupply, data.semi.anchType, stocVar, markMods);
    
    o.CAPEX.real.fndSupply = o.CAPEX.real.fndSupply + CoverheadSS + Cmoor;
    
end


if any(strcmpi({o.WTG.fndType}, 'gbf'))
    
    nGBFsupply = getProcurementRequirement(o, data, 'fndComp', 'gbf');
    
    %Same cost overheads as for a jacket foundation
    CoverheadGBF = jacketSupplyOverheadCosts(o, data, nGBFsupply, stocVar, markMods);
        
    o.CAPEX.real.fndSupply = o.CAPEX.real.fndSupply + CoverheadGBF;
    
end


for i = 1 : o.OWF.nWTG
    
    switch lower(o.WTG(i).fndType)
        
        case 'monopile';
            
            %calculate scaled costs for monopile foundations (adj. to ref. year)%
            Cproc = monopileProcurementCost(o, data, o.WTG(i), nMPsupply, stocVar, markMods);
            
            %add overhead costs for monopile supply%
            o.WTG(i).Cfnd = Cproc + CoverheadMP/nMPsupply;
            
        case 'jacket';
            
            %calculate scaled costs for jacket foundations (adj. to ref. year)%
            Cproc = jacketProcurementCost(o, data, o.WTG(i), 'sJKT', nJKTsupply, nPPsupply, stocVar, markMods);
            
            %add overhead costs for jacket supply%
            o.WTG(i).Cfnd = Cproc + CoverheadJKT/nJKTsupply;
            
        case 'semisub'
            
            %calculate scaled costs for semisub foundations (adj. to ref. year)%
            Cproc = semiSubProcurementCost(o, data, o.WTG(i), nSSsupply, stocVar, markMods);
            
            %add overhead costs for jacket supply%
            o.WTG(i).Cfnd = Cproc + CoverheadSS/nSSsupply;
            
        case 'gbf'
            
            %calculate scaled costs for GBF foundations (adj. to ref. year)%
            Cproc = gbfProcurementCost(o, data, o.WTG(i), nGBFsupply, stocVar, markMods);
            
            %add overhead costs for jacket supply%
            o.WTG(i).Cfnd = Cproc + CoverheadGBF/nGBFsupply;
            
    end
    
    %assign foundation supply costs to correct phase%
    o.CAPEX.real.fndSupply = o.CAPEX.real.fndSupply + Cproc;
    
end