function result = finalOutputs_rddi(o)

result = [];

rSpec = pi*(o.WTG(1).dRot/2)^2 / o.WTG(1).cap;
rRef = pi*(164/2)^2/8000000;

fMult = 0.3*(rSpec/rRef)^(3/2) + 0.35*(rSpec/rRef) + 0.35;

result(5) = o.CAPEX.real.development / 1e6;

%ExcelSheet.Range([colCase, '7']).Value = o.CAPEX.real.turbSupply / 1e6;
result(7) = o.CAPEX.real.turbSupply*fMult / 1e6;
result(8) = o.CAPEX.real.arraySupply / 1e6;
result(9) = o.CAPEX.real.fndSupply / 1e6;
result(10) = (o.CAPEX.real.fndSupply + o.CAPEX.real.arraySupply) / 1e6;

result(11) = o.CAPEX.real.turbInstall / 1e6;
result(12) = o.CAPEX.real.fndInstall / 1e6;
result(13) = o.CAPEX.real.arrayInstall / 1e6;
result(14) = o.CAPEX.real.portFacilities / 1e6;
result(15) = (o.CAPEX.real.turbInstall + o.CAPEX.real.fndInstall + o.CAPEX.real.arrayInstall + o.CAPEX.real.portFacilities) / 1e6;

result(16) = o.CAPEX.real.substationSupply / 1e6;
result(17) = o.CAPEX.real.substationInstall / 1e6;
result(18) = (o.CAPEX.real.substationSupply + o.CAPEX.real.substationInstall) / 1e6;

result(19) = o.CAPEX.real.exportSupply / 1e6;
result(20) = o.CAPEX.real.onshoreSupply / 1e6;
result(21) = o.CAPEX.real.exportInstall / 1e6;
result(22) = o.CAPEX.real.onshoreInstall / 1e6;
result(23) = (o.CAPEX.real.exportSupply + o.CAPEX.real.onshoreSupply + o.CAPEX.real.exportInstall + o.CAPEX.real.onshoreInstall) / 1e6;

result(24) = o.CAPEX.real.projManagement / 1e6;
result(25) = o.CAPEX.real.conInsurance / 1e6;
result(26) = (o.CAPEX.real.projManagement + o.CAPEX.real.conInsurance) / 1e6;

result(29) = o.OPEX.real.operation / 1e6;
result(30) = o.OPEX.real.opInsurance / 1e6;
result(31) = (o.OPEX.real.operation + o.OPEX.real.opInsurance) / 1e6;

result(32) = o.OPEX.real.turbMaint / 1e6;
result(33) = o.OPEX.real.BOPmaint / 1e6;
result(34) = o.OPEX.real.SSmaint / 1e6;
result(35) = (o.OPEX.real.BOPmaint + o.OPEX.real.SSmaint) / 1e6;

result(38) = o.DECEX.real.turbDecom / 1e6;
result(39) = o.DECEX.real.fndDecom / 1e6;
result(40) = (o.DECEX.real.turbDecom + o.DECEX.real.fndDecom) / 1e6;

result(41) = o.DECEX.real.substationDecom / 1e6;
result(42) = o.DECEX.real.substationDecom / 1e6;

result(45) = o.OWF.lWake;
result(46) = o.design.fSpace;
result(47) = o.OWF.AEPnet / 3.6e12;
result(48) = o.OWF.fCap;

result(50) = fMult;

result = result';


