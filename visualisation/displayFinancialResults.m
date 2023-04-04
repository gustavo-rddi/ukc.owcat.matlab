function displayFinancialResults(o, data, modes)

switch upper(data.econ.(o.OWF.loc).curr)
    
    case 'GBP'; currSym = '£';
    case 'EUR'; currSym = '€';
        
end

if any(strcmpi(o.runMode, modes))
    
    %design results of design calculation%
    fprintf(1, '  Overnight Project CAPEX:      %5.0f [%s/kW] (%4d)\n', 1000*o.CAPEX.real.total/o.OWF.cap, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Development Costs:         %5.0f [%s/kW] (%4d)\n', 1000*o.CAPEX.real.development/o.OWF.cap, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Project Management:        %5.0f [%s/kW] (%4d)\n', 1000*o.CAPEX.real.projManagement/o.OWF.cap, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Wind Turbines:             %5.0f [%s/kW] (%4d)\n', 1000*o.CAPEX.real.turbSupply/o.OWF.cap, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Turbine Foundations:       %5.0f [%s/kW] (%4d)\n', 1000*o.CAPEX.real.fndSupply/o.OWF.cap, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Inter-Array Cables:        %5.0f [%s/kW] (%4d)\n', 1000*o.CAPEX.real.arraySupply/o.OWF.cap, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Offshore Substations:      %5.0f [%s/kW] (%4d)\n', 1000*o.CAPEX.real.substationSupply/o.OWF.cap, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Export System:             %5.0f [%s/kW] (%4d)\n', 1000*(o.CAPEX.real.exportSupply+o.CAPEX.real.onshoreSupply+o.CAPEX.real.onshoreInstall)/o.OWF.cap, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Installation:              %5.0f [%s/kW] (%4d)\n', 1000*(o.CAPEX.real.portFacilities+o.CAPEX.real.turbInstall+o.CAPEX.real.fndInstall+o.CAPEX.real.arrayInstall+o.CAPEX.real.substationInstall+o.CAPEX.real.exportInstall)/o.OWF.cap, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Insurance:                 %5.0f [%s/kW] (%4d)\n', 1000*o.CAPEX.real.conInsurance/o.OWF.cap, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Contingency:               %5.0f [%s/kW] (%4d)\n', 1000*o.CAPEX.real.conContingency/o.OWF.cap, currSym, data.econ.(o.OWF.loc).yrReal);
            
    disp(' ');
    fprintf(1, '  Annual Project OPEX:          %5.1f [%s/kWyr] (%4d)\n', 1000*o.OPEX.real.total/o.OWF.cap, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Operation Costs:           %5.1f [%s/kWyr] (%4d)\n', 1000*o.OPEX.real.operation/o.OWF.cap, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Turbine Maintenance:       %5.1f [%s/kWyr] (%4d)\n', 1000*o.OPEX.real.turbMaint/o.OWF.cap, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - BoP Maintenance:           %5.1f [%s/kWyr] (%4d)\n', 1000*(o.OPEX.real.BOPmaint+o.OPEX.real.SSmaint+o.OPEX.real.expMaint)/o.OWF.cap, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Grid Access Charges:       %5.1f [%s/kWyr] (%4d)\n', 1000*o.OPEX.real.gridConnection/o.OWF.cap, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Seabed Rent & Fees:        %5.1f [%s/kWyr] (%4d)\n', 1000*o.OPEX.real.seabedRent/o.OWF.cap, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Insurance:                 %5.1f [%s/kWyr] (%4d)\n', 1000*o.OPEX.real.opInsurance/o.OWF.cap, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Contingency:               %5.1f [%s/kWyr] (%4d)\n', 1000*o.OPEX.real.opContingency/o.OWF.cap, currSym, data.econ.(o.OWF.loc).yrReal);
    
    disp(' ');
    fprintf(1, '  Levelised Energy Cost:        %5.1f [%s/MWh] (%4d)\n', o.LCOE.real.total*3.6e9, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Development Costs:         %5.1f [%s/MWh] (%4d)\n', o.LCOE.real.development*3.6e9, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Project Management:        %5.1f [%s/MWh] (%4d)\n', o.LCOE.real.projManagement*3.6e9, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Wind Turbines:             %5.1f [%s/MWh] (%4d)\n', o.LCOE.real.turbSupply*3.6e9, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Turbine Foundations:       %5.1f [%s/MWh] (%4d)\n', o.LCOE.real.fndSupply*3.6e9, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Inter-Array Cables:        %5.1f [%s/MWh] (%4d)\n', o.LCOE.real.arraySupply*3.6e9, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Offshore Substations:      %5.1f [%s/MWh] (%4d)\n', o.LCOE.real.substationSupply*3.6e9, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Export System:             %5.1f [%s/MWh] (%4d)\n', (o.LCOE.real.onshoreSupply+o.LCOE.real.exportSupply+o.LCOE.real.onshoreInstall+o.LCOE.real.gridConnection)*3.6e9, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Installation:              %5.1f [%s/MWh] (%4d)\n', (o.LCOE.real.portFacilities+o.LCOE.real.turbInstall+o.LCOE.real.fndInstall+o.LCOE.real.arrayInstall+o.LCOE.real.substationInstall+o.LCOE.real.exportInstall)*3.6e9, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Operation Costs:           %5.1f [%s/MWh] (%4d)\n', o.LCOE.real.operation*3.6e9, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Wind Farm Maintenance:     %5.1f [%s/MWh] (%4d)\n', (o.LCOE.real.turbMaint+o.LCOE.real.BOPmaint+o.LCOE.real.SSmaint+o.LCOE.real.expMaint)*3.6e9, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Insurance:                 %5.1f [%s/MWh] (%4d)\n', (o.LCOE.real.conInsurance+o.LCOE.real.opInsurance)*3.6e9, currSym, data.econ.(o.OWF.loc).yrReal);
    
    if strcmpi(o.finance.type, 'project')
        fprintf(1, '   - Decomissioning:            %5.1f [%s/MWh] (%4d)\n', (o.LCOE.real.turbDecom + o.LCOE.real.fndDecom + o.LCOE.real.substationDecom+o.LCOE.real.decomReserve+o.LCOE.real.intIncome)*3.6e9, currSym, data.econ.(o.OWF.loc).yrReal);
        fprintf(1, '   - Financing Fees:            %5.1f [%s/MWh] (%4d)\n', o.LCOE.real.financingFees*3.6e9, currSym, data.econ.(o.OWF.loc).yrReal);
        fprintf(1, '   - Debt Finance:              %5.1f [%s/MWh] (%4d)\n', (o.LCOE.real.debtFinance+o.LCOE.real.conInterest+o.LCOE.real.opInterest)*3.6e9, currSym, data.econ.(o.OWF.loc).yrReal);
    else
        fprintf(1, '   - Decomissioning:            %5.1f [%s/MWh] (%4d)\n', (o.LCOE.real.turbDecom + o.LCOE.real.fndDecom + o.LCOE.real.substationDecom)*3.6e9, currSym, data.econ.(o.OWF.loc).yrReal);
    end
    
    fprintf(1, '   - Seabed Rent & Fees:        %5.1f [%s/MWh] (%4d)\n', o.LCOE.real.seabedRent*3.6e9, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Corporation Taxes:         %5.1f [%s/MWh] (%4d)\n', o.LCOE.real.taxes*3.6e9, currSym, data.econ.(o.OWF.loc).yrReal);
    fprintf(1, '   - Contingency:               %5.1f [%s/MWh] (%4d)\n', (o.LCOE.real.conContingency + o.LCOE.real.opContingency + o.LCOE.real.decContingency)*3.6e9, currSym, data.econ.(o.OWF.loc).yrReal);
      
    switch upper(o.OWF.loc)
        
        case 'FR';
            
            disp(' ');
            fprintf(1, '  Required P0 Feed-In Tariff:   %5.1f [%s/MWh] (%4d)\n', (o.P0E.value+o.P0R.value)*3.6e9, currSym, data.econ.FR.yrPrice);
            fprintf(1, '   - Wind Farm Tariff (P0E):    %5.1f [%s/MWh] (%4d)\n', o.P0E.value*3.6e9, currSym, data.econ.FR.yrPrice);
            fprintf(1, '   - Connection Tariff (P0R):   %5.1f [%s/MWh] (%4d)\n', o.P0R.value*3.6e9, currSym, data.econ.FR.yrPrice);
      
        case 'UK'
            
            disp(' ');
            fprintf(1, '  Required CfD Strike Price:    %5.1f [%s/MWh] (%4d)\n', o.Pstrike.value*3.6e9, currSym, data.econ.UK.yrPrice);
            
    end
            
    disp(' ');
    
end
