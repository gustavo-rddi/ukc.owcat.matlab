function writeFCOWdataToEXCEL(ExcelFile, o, site, scenario, year)

%open correct EXCEL sheet%
ExcelSheet = ExcelFile.Sheets.Item(strcat('Site',upper(site)));

if year == 2015
    
    colOutput = 'E';
    
else
    
    switch lower(scenario)
        
        case 'standardisation'; colOutput = excelColumnOffset('E', (year-2015)/5);
        case 'innovation'; colOutput = excelColumnOffset('L', (year-2015)/5);   
%         case 'central'; colOutput = excelColumnOffset('L', (year-2020)/5);  
            
        otherwise; return;
            
    end
    
end

ExcelSheet.Range([colOutput, '26']).Value = o.OWF.cap / 1e6;
ExcelSheet.Range([colOutput, '27']).Value = o.OWF.nWTG;
ExcelSheet.Range([colOutput, '28']).Value = o.OWF.AEPnet / 3.6e12;

ExcelSheet.Range([colOutput, '30']).Value = o.CAPEX.real.development / 1e6;

ExcelSheet.Range([colOutput, '32']).Value = o.CAPEX.real.turbSupply / 1e6;
ExcelSheet.Range([colOutput, '33']).Value = o.CAPEX.real.turbInstall / 1e6;
ExcelSheet.Range([colOutput, '34']).Value = o.CAPEX.real.fndSupply / 1e6;
ExcelSheet.Range([colOutput, '35']).Value = (o.CAPEX.real.fndInstall + o.CAPEX.real.portFacilities) / 1e6;
ExcelSheet.Range([colOutput, '36']).Value = o.CAPEX.real.arraySupply / 1e6;
ExcelSheet.Range([colOutput, '37']).Value = o.CAPEX.real.arrayInstall / 1e6;
ExcelSheet.Range([colOutput, '38']).Value = o.CAPEX.real.substationSupply / 1e6;
ExcelSheet.Range([colOutput, '39']).Value = o.CAPEX.real.substationInstall / 1e6;

ExcelSheet.Range([colOutput, '42']).Value = o.CAPEX.real.exportSupply / 1e6;
ExcelSheet.Range([colOutput, '43']).Value = o.CAPEX.real.exportInstall / 1e6;
ExcelSheet.Range([colOutput, '44']).Value = (o.CAPEX.real.onshoreSupply + o.CAPEX.real.onshoreInstall) / 1e6;

ExcelSheet.Range([colOutput, '47']).Value = o.CAPEX.real.projManagement / 1e6;
ExcelSheet.Range([colOutput, '48']).Value = o.CAPEX.real.conInsurance / 1e6;
ExcelSheet.Range([colOutput, '49']).Value = o.CAPEX.real.conContingency / 1e6;

ExcelSheet.Range([colOutput, '52']).Value = o.OPEX.real.operation / 1e6;
ExcelSheet.Range([colOutput, '53']).Value = o.OPEX.real.turbMaint / 1e6;
ExcelSheet.Range([colOutput, '54']).Value = (o.OPEX.real.BOPmaint + o.OPEX.real.SSmaint + o.OPEX.real.expMaint) / 1e6;
ExcelSheet.Range([colOutput, '55']).Value = o.OPEX.real.opInsurance / 1e6;
ExcelSheet.Range([colOutput, '56']).Value = o.OPEX.real.opContingency / 1e6;

ExcelSheet.Range([colOutput, '59']).Value = o.DECEX.real.turbDecom / 1e6;
ExcelSheet.Range([colOutput, '60']).Value = o.DECEX.real.fndDecom / 1e6;
ExcelSheet.Range([colOutput, '61']).Value = o.DECEX.real.substationDecom / 1e6;
ExcelSheet.Range([colOutput, '62']).Value = o.DECEX.real.decContingency / 1e6;

ExcelSheet.Range([colOutput, '65']).Value = o.LCOE.real.total * 3.6e9;
ExcelSheet.Range([colOutput, '66']).Value = o.P0E.value *3.6e9;
ExcelSheet.Range([colOutput, '67']).Value = o.P0R.value *3.6e9;

