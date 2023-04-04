function writeCHypSEdataToEXCEL(ExcelFile, o, site, year)

%open correct EXCEL sheet%
ExcelSheet = ExcelFile.Sheets.Item(strcat('Site',upper(site)));
    
if year == 2023; colOutput = 'E';
    
elseif year == 2028; colOutput = 'F';
        
elseif year == 2030; colOutput = 'G';
        
elseif year == 2035; colOutput = 'H';
        
elseif year == 2040; colOutput = 'I';
        
elseif year == 2045; colOutput = 'J';
        
elseif year == 2050; colOutput = 'K';

elseif year == 2055; colOutput = 'L';
    
elseif year == 2060; colOutput = 'M';
    
end
       
%     switch lower(scenario)
        
%         case 'standardisation'; colOutput = excelColumnOffset('E', (year-2015)/5);
%         case 'innovation'; colOutput = excelColumnOffset('L', (year-2015)/5);   
% %         case 'central'; colOutput = excelColumnOffset('L', (year-2020)/5);  
%             
%         otherwise; return;
%             
%     end

ExcelSheet.Range([colOutput, '12']).Value = o.OWF.cap / 1e6;
ExcelSheet.Range([colOutput, '13']).Value = o.OWF.nWTG;
ExcelSheet.Range([colOutput, '14']).Value = o.OWF.AEPnet / 3.6e12;
ExcelSheet.Range([colOutput, '15']).Value = o.OWF.fCap;

ExcelSheet.Range([colOutput, '16']).Value = o.CAPEX.real.development / 1e6;

ExcelSheet.Range([colOutput, '18']).Value = o.CAPEX.real.turbSupply / 1e6;
ExcelSheet.Range([colOutput, '19']).Value = o.CAPEX.real.turbInstall / 1e6;
ExcelSheet.Range([colOutput, '20']).Value = o.CAPEX.real.fndSupply / 1e6;
ExcelSheet.Range([colOutput, '21']).Value = (o.CAPEX.real.fndInstall + o.CAPEX.real.portFacilities) / 1e6;
ExcelSheet.Range([colOutput, '22']).Value = o.CAPEX.real.arraySupply / 1e6;
ExcelSheet.Range([colOutput, '23']).Value = o.CAPEX.real.arrayInstall / 1e6;
ExcelSheet.Range([colOutput, '24']).Value = o.CAPEX.real.substationSupply / 1e6;
ExcelSheet.Range([colOutput, '25']).Value = o.CAPEX.real.substationInstall / 1e6;

ExcelSheet.Range([colOutput, '28']).Value = o.CAPEX.real.exportSupply / 1e6;
ExcelSheet.Range([colOutput, '29']).Value = o.CAPEX.real.exportInstall / 1e6;
ExcelSheet.Range([colOutput, '30']).Value = (o.CAPEX.real.onshoreSupply + o.CAPEX.real.onshoreInstall) / 1e6;

ExcelSheet.Range([colOutput, '33']).Value = o.CAPEX.real.projManagement / 1e6;
ExcelSheet.Range([colOutput, '34']).Value = o.CAPEX.real.conInsurance / 1e6;
ExcelSheet.Range([colOutput, '35']).Value = o.CAPEX.real.conContingency / 1e6;

ExcelSheet.Range([colOutput, '38']).Value = o.OPEX.real.operation / 1e6;
ExcelSheet.Range([colOutput, '39']).Value = o.OPEX.real.turbMaint / 1e6;
ExcelSheet.Range([colOutput, '40']).Value = (o.OPEX.real.BOPmaint + o.OPEX.real.SSmaint + o.OPEX.real.expMaint) / 1e6;
ExcelSheet.Range([colOutput, '41']).Value = o.OPEX.real.opInsurance / 1e6;
ExcelSheet.Range([colOutput, '42']).Value = o.OPEX.real.opContingency / 1e6;

ExcelSheet.Range([colOutput, '45']).Value = o.DECEX.real.turbDecom / 1e6;
ExcelSheet.Range([colOutput, '46']).Value = o.DECEX.real.fndDecom / 1e6;
ExcelSheet.Range([colOutput, '47']).Value = o.DECEX.real.substationDecom / 1e6;
ExcelSheet.Range([colOutput, '48']).Value = o.DECEX.real.decContingency / 1e6;

ExcelSheet.Range([colOutput, '51']).Value = o.LCOE.real.total * 3.6e9;
% ExcelSheet.Range([colOutput, '52']).Value = o.P0E.value *3.6e9;
% ExcelSheet.Range([colOutput, '53']).Value = o.P0R.value *3.6e9;

ExcelSheet.Range([colOutput, '53']).Value = o.OWF.lWake;
ExcelSheet.Range([colOutput, '54']).Value = o.design.fSpace;

% ExcelSheet.Range([colOutput, '70']).Value = o.CAPEX.real.substationSupply / 1e6;
% ExcelSheet.Range([colOutput, '71']).Value = o.CAPEX.real.substationInstall / 1e6;
% ExcelSheet.Range([colOutput, '72']).Value = o.CAPEX.real.onshoreSupply / 1e6;
% ExcelSheet.Range([colOutput, '73']).Value = o.CAPEX.real.onshoreInstall / 1e6;

% switch upper(o.OWF.expType)
%     
%     case 'HVAC'; 
%         
% ExcelSheet.Range([colOutput, '74']).Value = o.CAPEX.real.exportSupply / 1e6;
% ExcelSheet.Range([colOutput, '75']).Value = o.CAPEX.real.exportInstall / 1e6;
% 
%     case 'HVDC'
% ExcelSheet.Range([colOutput, '74']).Value = o.CAPEX.real.exportSupply_offcable / 1e6;
% ExcelSheet.Range([colOutput, '75']).Value = o.CAPEX.real.exportInstall_offcable / 1e6;       
% ExcelSheet.Range([colOutput, '76']).Value = o.CAPEX.real.exportSupply_conv / 1e6;
% ExcelSheet.Range([colOutput, '77']).Value = o.CAPEX.real.exportInstall_conv / 1e6;
% 
% end 