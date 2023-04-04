function CF = fixedPstrikeCashFlows(o, data, stocVar, markMods)

CF.t = (-(6+o.OWF.nComm) : data.WTG.nOper+1);

CF.real.development = generateCashFlow(o, data, -o.CAPEX.real.development, 'dev');

CF.real.portFacilities  = generateCashFlow(o, data, -o.CAPEX.real.portFacilities,  'conOnshore');

CF.real.onshoreSupply  = generateCashFlow(o, data, -o.CAPEX.real.onshoreSupply,  'conOnshore');
CF.real.onshoreInstall = generateCashFlow(o, data, -o.CAPEX.real.onshoreInstall, 'conOnshore');

CF.real.substationSupply  = generateCashFlow(o, data, -o.CAPEX.real.substationSupply,  'conExport');
CF.real.substationInstall = generateCashFlow(o, data, -o.CAPEX.real.substationInstall, 'conExport');

CF.real.exportSupply  = generateCashFlow(o, data, -o.CAPEX.real.exportSupply,  'conExport');
CF.real.exportInstall = generateCashFlow(o, data, -o.CAPEX.real.exportInstall, 'conExport');

CF.real.fndSupply  = generateCashFlow(o, data, -o.CAPEX.real.fndSupply,  'conBOP');
CF.real.fndInstall = generateCashFlow(o, data, -o.CAPEX.real.fndInstall, 'conBOP');

CF.real.arraySupply  = generateCashFlow(o, data, -o.CAPEX.real.arraySupply,  'conBOP');
CF.real.arrayInstall = generateCashFlow(o, data, -o.CAPEX.real.arrayInstall, 'conBOP');

CF.real.turbSupply  = generateCashFlow(o, data, -o.CAPEX.real.turbSupply,  'conTurb');
CF.real.turbInstall = generateCashFlow(o, data, -o.CAPEX.real.turbInstall, 'conTurb');

CF.real.projManagement = generateCashFlow(o, data, -o.CAPEX.real.projManagement,  'conAll');

CF.real.operation = generateCashFlow(o, data, -o.OPEX.real.operation,  'oper');

CF.real.turbMaint = generateCashFlow(o, data, -o.OPEX.real.turbMaint, 'oper', 'OM.turbReal', stocVar, markMods);
CF.real.BOPmaint  = generateCashFlow(o, data, -o.OPEX.real.BOPmaint,  'oper', 'OM.bopReal', stocVar, markMods);
CF.real.SSmaint   = generateCashFlow(o, data, -o.OPEX.real.SSmaint,   'oper', 'OM.bopReal', stocVar, markMods);
CF.real.expMaint  = generateCashFlow(o, data, -o.OPEX.real.expMaint,  'oper', 'OM.bopReal', stocVar, markMods);

CF.real.gridConnection = generateCashFlow(o, data, -o.OPEX.real.gridConnection,  'oper');

CF.real.turbDecom = generateCashFlow(o, data, -o.DECEX.real.turbDecom,  'decomTurb');
CF.real.fndDecom = generateCashFlow(o, data, -o.DECEX.real.fndDecom,  'decomBOP');
CF.real.substationDecom = generateCashFlow(o, data, -o.DECEX.real.substationDecom,  'decomBOP');

CF.real.conContingency = ( CF.real.development ...
                         + CF.real.turbSupply + CF.real.turbInstall ...
                         + CF.real.fndSupply + CF.real.fndInstall ...
                         + CF.real.arraySupply + CF.real.fndInstall ...
                         + CF.real.substationSupply + CF.real.substationInstall ...
                         + CF.real.exportSupply + CF.real.exportInstall ...
                         + CF.real.onshoreSupply + CF.real.onshoreInstall ...
                         + CF.real.projManagement ...
                         + CF.real.portFacilities ) * data.econ.contCon;

CF.real.opContingency = ( CF.real.operation ...
                        + CF.real.turbMaint + CF.real.BOPmaint + CF.real.SSmaint + CF.real.expMaint ...
                        + CF.real.gridConnection ) * data.econ.contOp;
                    
CF.real.decContingency = ( CF.real.turbDecom + CF.real.fndDecom + CF.real.substationDecom ) * data.econ.contOp;                    
                    
CF = calculateNominalCashFlows(o, CF, data);