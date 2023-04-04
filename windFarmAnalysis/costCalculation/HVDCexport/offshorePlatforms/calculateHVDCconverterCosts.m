function o = calculateHVDCconverterCosts(o, data, stocVar, markMods)

o.CAPEX.real.exportSupply_conv =0;

for i = 1 : o.OWF.nConv

    %sum to get total offshore substation topside costs%
    o.offshoreConv(i).Ctopside = 0.5 * 1054131 * 7.2 * (o.offshoreConv(i).capConv/1e6)^0.6733 * costScalingFactor(o, data, 2021, 'GBP') ...
                               * scenarioModifier('HVDC.cost', stocVar, markMods);
                       
    %determine the number of jackets and pin-piles to be ordered this phase%
    nJKTsupply = getProcurementRequirement(o, data, 'fndComp', 'hvyJacket');
    nPPsupply = getProcurementRequirement(o, data, 'fndComp', 'pinpile');
    
    %determine overhead costs for SS jacket supply (adj. to ref. year)%
    CoverheadJKT = jacketSupplyOverheadCosts(o, data, nJKTsupply, stocVar, markMods);
    
    %calculate scaled costs for SS jacket foundations (adj. to ref. year)%
    Cproc = jacketProcurementCost(o, data, o.offshoreConv(i), 'hJKT', nJKTsupply, nPPsupply, stocVar, markMods);
    
    o.offshoreConv(i).Cfnd = Cproc + CoverheadJKT/nJKTsupply;

    o.offshoreConv(i).Ctopside = o.offshoreConv(i).Ctopside - o.offshoreConv(i).Cfnd;

    %add costs to total substation supply costs% 
    o.CAPEX.real.substationSupply = o.CAPEX.real.substationSupply + o.offshoreConv(i).Ctopside + o.offshoreConv(i).Cfnd;

end