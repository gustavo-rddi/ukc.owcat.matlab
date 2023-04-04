function CF = variableP0RcashFlows(o, CF, data, P0R)

[CF.nom.subRevenue, targSalesStart, ~] = subsidyRevenueStream(o, data, P0R, CF.t, 'P0R');

investment = -CF.nom.exportSupply + -CF.nom.exportInstall ...
           + -CF.nom.onshoreSupply + -CF.nom.onshoreInstall;

vAssetCon = sum(investment);

CAR = vAssetCon * data.econ.fInsCAR * (1 + data.econ.FR.taxIns);
DSU = targSalesStart * data.econ.fInsDSU * (1 + data.econ.(o.OWF.loc).taxIns);

%calculate insurance costs during wind farm construction%
CF.nom.conInsurance = generateCashFlow(o, data, CAR + DSU, 'conOnshore');
     
investment = investment + -CF.nom.conInsurance + -CF.nom.conContingency;

vAssetRepl = sum(investment);   

PDinsurance = vAssetRepl * data.econ.fInsPD * (1 + data.econ.(o.OWF.loc).taxIns);

%calculate insurance costs during wind farm operation%       
CF.nom.opInsurance = generateCashFlow(o, data, -PDinsurance, 'oper');                

CF = calculateRealCashFlows(o, CF, data);