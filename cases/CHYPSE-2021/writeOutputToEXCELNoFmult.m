function writeOutputToEXCELNoFmult(o, ExcelFile, caseNum)

ExcelSheet = ExcelFile.Sheets.Item('Outputs');

colCase = excelColumnOffset('E', caseNum);

rSpec = pi*(215/2)^2 / 15e6;
rRef = pi*(164/2)^2/8000000;

fMult = 0.3*(rSpec/rRef)^(3/2) + 0.35*(rSpec/rRef) + 0.35;

ExcelSheet.Range([colCase, '5']).Value = o.CAPEX.real.development / 1e6;

ExcelSheet.Range([colCase, '7']).Value = o.CAPEX.real.turbSupply*fMult / 1e6;
ExcelSheet.Range([colCase, '8']).Value = (o.CAPEX.real.fndSupply + o.CAPEX.real.arraySupply) / 1e6;
ExcelSheet.Range([colCase, '9']).Value = (o.CAPEX.real.turbInstall + o.CAPEX.real.fndInstall + o.CAPEX.real.arrayInstall + o.CAPEX.real.portFacilities) / 1e6;
ExcelSheet.Range([colCase, '10']).Value = (o.CAPEX.real.substationSupply + o.CAPEX.real.substationInstall) / 1e6;
ExcelSheet.Range([colCase, '11']).Value = (o.CAPEX.real.exportSupply + o.CAPEX.real.onshoreSupply + o.CAPEX.real.exportInstall + o.CAPEX.real.onshoreInstall) / 1e6;
ExcelSheet.Range([colCase, '12']).Value = (o.CAPEX.real.projManagement + o.CAPEX.real.conInsurance) / 1e6;

ExcelSheet.Range([colCase, '15']).Value = (o.OPEX.real.operation + o.OPEX.real.opInsurance) / 1e6;
ExcelSheet.Range([colCase, '16']).Value = o.OPEX.real.turbMaint / 1e6;
ExcelSheet.Range([colCase, '17']).Value = (o.OPEX.real.BOPmaint + o.OPEX.real.SSmaint) / 1e6;

ExcelSheet.Range([colCase, '20']).Value = (o.DECEX.real.turbDecom + o.DECEX.real.fndDecom) / 1e6;
ExcelSheet.Range([colCase, '21']).Value = o.DECEX.real.substationDecom / 1e6;

ExcelSheet.Range([colCase, '24']).Value = o.OWF.lWake;
ExcelSheet.Range([colCase, '25']).Value = o.OWF.AEPnet / 3.6e12;
ExcelSheet.Range([colCase, '26']).Value = o.OWF.fCap;

ExcelSheet.Range([colCase, '28']).Value = (o.CAPEX.real.exportSupply + o.CAPEX.real.exportInstall) / 1e6;
ExcelSheet.Range([colCase, '29']).Value = (o.CAPEX.real.onshoreSupply+ o.CAPEX.real.onshoreInstall) / 1e6;
