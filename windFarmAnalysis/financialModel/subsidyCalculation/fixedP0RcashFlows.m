function CF = fixedP0RcashFlows(o, data, stocVar, markMods)

CF.t = (-(6+o.OWF.nComm) : data.WTG.nOper+1);

CF.real.onshoreSupply  = generateCashFlow(o, data, -o.CAPEX.real.onshoreSupply,  'conExport');
CF.real.onshoreInstall = generateCashFlow(o, data, -o.CAPEX.real.onshoreInstall, 'conExport');

CF.real.exportSupply  = generateCashFlow(o, data, -o.CAPEX.real.exportSupply,  'conBOP');
CF.real.exportInstall = generateCashFlow(o, data, -o.CAPEX.real.exportInstall, 'conBOP');

CF.real.conContingency = ( CF.real.onshoreSupply + CF.real.onshoreInstall ...
                         + CF.real.exportSupply + CF.real.exportInstall ) * data.econ.contCon;
                     
CF.real.expMaint  = generateCashFlow(o, data, -o.OPEX.real.expMaint,  'oper', 'OM.bopReal', stocVar, markMods);

CF.real.opContingency = CF.real.expMaint * data.econ.contOp;

CF.real.substationDecom = generateCashFlow(o, data, -o.DECEX.real.substationDecom,  'decomBOP');

CF = calculateNominalCashFlows(o, CF, data);