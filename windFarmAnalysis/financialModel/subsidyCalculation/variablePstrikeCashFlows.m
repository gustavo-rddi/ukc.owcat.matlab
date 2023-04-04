function CF = variablePstrikeCashFlows(o, CF, data, Pstrike)

[CF.nom.elecSale, targSalesStart, targSalesAnn] = subsidyRevenueStream(o, data, Pstrike, CF.t, 'Pstrike');
   
opRevenue = CF.nom.elecSale .* (CF.t >= 0);
commRevenue = CF.nom.elecSale .* (CF.t < 0);

investment = -CF.nom.turbSupply + -CF.nom.turbInstall ...
           + -CF.nom.fndSupply + -CF.nom.fndInstall ...
           + -CF.nom.arraySupply + -CF.nom.fndInstall ...
           + -CF.nom.substationSupply + -CF.nom.substationInstall ...
           + -CF.nom.exportSupply + -CF.nom.exportInstall ...
           + -CF.nom.onshoreSupply + -CF.nom.onshoreInstall ...
           + -CF.nom.portFacilities;
      
vAssetCon = cumsum(investment) .* (CF.t < 0);  

%calculate insurance costs during wind farm construction%
CF.nom.conInsurance = generateCashFlow(o, data, -data.econ.fInsDSU * targSalesStart * (1 + data.econ.(o.OWF.loc).taxIns), 'conAll') ...
                    - vAssetCon * data.econ.fInsCAR * (1 + data.econ.(o.OWF.loc).taxIns);

investOFTO = -CF.nom.onshoreSupply + -CF.nom.onshoreInstall ...
           + -CF.nom.exportSupply + -CF.nom.exportInstall ...
           + -CF.nom.substationSupply + -CF.nom.substationInstall;
       
CF = calculateOFTOcashFlows(o, CF, investOFTO, data);                
                
investment = investment + -CF.nom.conInsurance + -CF.nom.projManagement + -CF.nom.development + -CF.nom.conContingency - investOFTO;

vAssetRepl = sum(investment);   

%calculate insurance costs during wind farm operation%       
CF.nom.opInsurance = generateCashFlow(o, data, -data.econ.fInsPD * vAssetRepl * (1 + data.econ.(o.OWF.loc).taxIns), 'oper') ...
                   - data.econ.fInsBI .* targSalesAnn * (1 + data.econ.(o.OWF.loc).taxIns) .* (CF.t >= 0) .* (CF.t < o.OWF.nOper);                

investment = investment - commRevenue; 

vAssetDepr = sum(investment);
               
%determine depreciation of OWF assets%
depreStream = calculateDepreciation(o, vAssetDepr, CF.t, data);

CF.nom.seabedRent = -calculateSeabedRent(o, opRevenue, CF.t, data);               

%determine total taxable revenue%
revTaxable = opRevenue ...
           + CF.nom.operation ...
           + CF.nom.turbMaint + CF.nom.BOPmaint + CF.nom.SSmaint + CF.nom.expMaint ...
           + CF.nom.gridConnection + CF.nom.OFTOfee ...
           + CF.nom.seabedRent ...
           + CF.nom.opInsurance ...
           + CF.nom.opContingency ...
           - depreStream;

CF.nom.taxes = calculateTaxCashFlow(o, revTaxable, CF.t, data);

CF = calculateRealCashFlows(o, CF, data);