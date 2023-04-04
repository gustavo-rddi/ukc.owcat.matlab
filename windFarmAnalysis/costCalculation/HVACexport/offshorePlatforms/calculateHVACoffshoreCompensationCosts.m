function o = calculateHVACoffshoreCompensationCosts(o, data, stocVar, markMods)

%determine overhead costs for SS electrical design%
Coverhead = HVACoverheadCosts(o, data, o.OWF.nOSS+o.design.osComp, stocVar, markMods)*o.design.osComp/(o.OWF.nOSS+o.design.osComp);

cComp = 0;

for i = 1 : o.OWF.nOSS
    
    %determine number of reactors%
    nComp = o.offshoreSS(i).nExportCable;
    
    %calculate total cost of onshore shunt reactors%
    cComp = cComp + shuntReactorCost(o, data, o.offshoreSS(i).QcompPlat/nComp, o.design.Vexport, 'offshore', stocVar, markMods) * nComp;
    
end

    %calculate switchgear and cable auxiliaries costs%
    cExportSwitch = GIScost(o, data, o.design.Vexport, 'offshore', stocVar, markMods) * o.offshoreCP.nHVswitch;
    cXPLEsets = cableSetCost(o, data, o.design.Vexport, 'offshore', stocVar, markMods) * o.offshoreCP.nExportCable;
    
    cPlatform = offshoreHVACplatformCost(o, data, 2/3*o.offshoreCP.capComp, o.design.Vexport, stocVar, markMods);
        
    %sum to get total SS topside costs%
    o.offshoreCP.Ctopside = cComp + cExportSwitch + cXPLEsets + cPlatform + Coverhead;
    
    %determine the number of jackets and pin-piles to be ordered this phase%
    nJKTsupply = getProcurementRequirement(o, data, 'fndComp', 'hvyJacket');
    nPPsupply = getProcurementRequirement(o, data, 'fndComp', 'pinpile');
    
    %determine overhead costs for SS jacket supply (adj. to ref. year)%
    CoverheadJKT = jacketSupplyOverheadCosts(o, data, nJKTsupply, stocVar, markMods);
    
    %calculate scaled costs for SS jacket foundations (adj. to ref. year)%
    Cproc = jacketProcurementCost(o, data, o.offshoreCP, 'hJKT', nJKTsupply, nPPsupply, stocVar, markMods);
    
    o.offshoreCP.Cfnd = Cproc + CoverheadJKT/nJKTsupply;
    
    %add costs to total substation supply costs% 
    o.CAPEX.real.exportSupply = o.CAPEX.real.exportSupply + o.offshoreCP.Ctopside + o.offshoreCP.Cfnd;
        
end