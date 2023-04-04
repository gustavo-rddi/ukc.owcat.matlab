function o = calculateHVACoffshoreSubstationCosts(o, data, stocVar, markMods)

%determine overhead costs for SS electrical design%
Coverhead = HVACoverheadCosts(o, data, o.OWF.nOSS+o.design.osComp, stocVar, markMods)*o.OWF.nOSS/(o.OWF.nOSS+o.design.osComp);

for i = 1 : o.OWF.nOSS

    %calculate cost of offshore transformers%
    cTrans = transformerCost(o, data, o.offshoreSS(i).capTrans, o.design.Vexport, 'offshore', stocVar, markMods) * o.offshoreSS(i).nTrans;
    
    %calculate switchgear and cable auxiliaries costs%
    %cArraySwitch = GIScost(o, data, o.design.Varray, 'offshore', stocVar, markMods) * o.offshoreSS(i).nMVswitch;
    cArraySwitch = GIScost(o, data, 33e3, 'offshore', stocVar, markMods) * o.offshoreSS(i).nMVswitch;
    cExportSwitch = GIScost(o, data, o.design.Vexport, 'offshore', stocVar, markMods) * o.offshoreSS(i).nHVswitch;
    cXPLEsets = cableSetCost(o, data, o.design.Vexport, 'offshore', stocVar, markMods) * o.offshoreSS(i).nExportCable;
    
    %SCADA equipment cost%
    cSCADA = SCADAcost(o, data, stocVar, markMods);
    
    switch upper(o.design.expConf)
        
        %calculate offshore platform costs%
        case 'OHVS'; cPlatform = offshoreHVACplatformCost(o, data, o.offshoreSS(i).capExport, o.design.Vexport, stocVar, markMods);
        case 'OTM'; cPlatform = OTMplatformCost(o, data, stocVar, markMods);
            
    end
        
    %sum to get total SS topside costs%
    o.offshoreSS(i).Ctopside = cTrans + cArraySwitch + cExportSwitch + cXPLEsets + cSCADA + cPlatform + Coverhead/o.OWF.nOSS;
        
    if strcmpi(o.design.expConf, 'OHVS')
    
        %determine the number of jackets and pin-piles to be ordered this phase%
        nJKTsupply = getProcurementRequirement(o, data, 'fndComp', 'hvyJacket');
        nPPsupply = getProcurementRequirement(o, data, 'fndComp', 'pinpile');
        
        %determine overhead costs for SS jacket supply (adj. to ref. year)%
        CoverheadJKT = jacketSupplyOverheadCosts(o, data, nJKTsupply, stocVar, markMods);
        
        %calculate scaled costs for SS jacket foundations (adj. to ref. year)%
        Cproc = jacketProcurementCost(o, data, o.offshoreSS(i), 'hJKT', nJKTsupply, nPPsupply, stocVar, markMods);
        
        o.offshoreSS(i).Cfnd = Cproc + CoverheadJKT/nJKTsupply;
       
    elseif strcmpi(o.design.expConf, 'OTM') && ~o.OWF.fndShare
        
        %determine the number of jackets and pin-piles to be ordered this phase%
        nJKTsupply = getProcurementRequirement(o, data, 'fndComp', 'wtgJacket');
        nPPsupply = getProcurementRequirement(o, data, 'fndComp', 'pinpile');
        
        %determine overhead costs for WTG-style jacket supply (adj. to ref. year)%
        CoverheadJKT = jacketSupplyOverheadCosts(o, data, nJKTsupply, stocVar, markMods);
        
        Cproc = jacketProcurementCost(o, data, o.offshoreSS(i), 'sJKT', nJKTsupply, nPPsupply, stocVar, markMods);
        
        %calculate scaled costs for WTG-style jacket foundations (adj. to ref. year)%
        o.offshoreSS(i).Cfnd = Cproc + CoverheadJKT/nJKTsupply;
                         
    else
        
        %no foundation cost%
        o.offshoreSS(i).Cfnd = 0;
       
    end
    
    o.offshoreSS(i).Ctopside = o.offshoreSS(i).Ctopside - o.offshoreSS(i).Cfnd;

    %add costs to total substation supply costs% 
    o.CAPEX.real.substationSupply = o.CAPEX.real.substationSupply + o.offshoreSS(i).Ctopside + o.offshoreSS(i).Cfnd;
        
end