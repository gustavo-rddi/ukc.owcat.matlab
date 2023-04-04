function CF = variableLCOEcashFlows(o, CF, data, LCOE, ecMode)

%determine real-to-nominal conversion factors%
fNom = arrayfun(@(X)CPImodifier(data, X, data.econ.(o.OWF.loc).yrReal, data.econ.(o.OWF.loc).curr), o.OWF.yrOper + CF.t);

switch lower(ecMode)
            
    case 'nom';  
        
        CF.nom.elecSale = o.OWF.annYield * LCOE;
        
        targSalesStart = o.OWF.AEPnet * LCOE;
        targSalesAnn = o.OWF.AEPnet * LCOE;
    
    case 'real'; 
        
        CF.nom.elecSale = o.OWF.annYield * LCOE .* fNom;
        
        targSalesStart = o.OWF.AEPnet * LCOE * fNom(CF.t == 0);
        targSalesAnn = o.OWF.AEPnet * LCOE .* fNom;
    
end

opRevenue = CF.nom.elecSale .* (CF.t >= 0);
commRevenue = CF.nom.elecSale .* (CF.t < 0);

investment = -CF.nom.turbSupply + -CF.nom.turbInstall ...
           + -CF.nom.fndSupply + -CF.nom.fndInstall ...
           + -CF.nom.arraySupply + -CF.nom.fndInstall ...
           + -CF.nom.substationSupply + -CF.nom.substationInstall ...
           + -CF.nom.exportSupply + -CF.nom.exportInstall ...
           + -CF.nom.onshoreSupply + -CF.nom.onshoreInstall ...
           + -CF.nom.portFacilities;
      
vAssetCon = sum(investment);  

CARinsurance = vAssetCon * data.econ.fInsCAR * (1 + data.econ.(o.OWF.loc).taxIns);
DSUinsurnace = targSalesStart * data.econ.fInsDSU * (1 + data.econ.(o.OWF.loc).taxIns);

%calculate insurance costs during wind farm construction%
CF.nom.conInsurance = generateCashFlow(o, data, -(CARinsurance+DSUinsurnace), 'AtFID');

investment = investment + -CF.nom.conInsurance + -CF.nom.projManagement + -CF.nom.development + -CF.nom.conContingency;

if strcmpi(o.finance.type, 'project')
    
    CF = calculateDebtCashFlows(o, data, CF, investment);
    
    investment = investment + -CF.nom.conInterest + -CF.nom.financingFees;
    
    decomCosts = -CF.nom.turbDecom + -CF.nom.fndDecom + -CF.nom.substationDecom ...
               + -CF.nom.decContingency;
    
    CF = calculateDecommissioningReserve(o, data, CF, decomCosts);
    
end

vAssetRepl = sum(investment);

PDinsurance = vAssetRepl * data.econ.fInsPD * (1 + data.econ.(o.OWF.loc).taxIns);
BIinsurance = targSalesAnn * data.econ.fInsBI * (1 + data.econ.(o.OWF.loc).taxIns);

%calculate insurance costs during wind farm operation%       
CF.nom.opInsurance = generateCashFlow(o, data, -PDinsurance, 'oper') - BIinsurance;

investment = investment - commRevenue; 

vAssetDepr = sum(investment);
               
%determine depreciation of OWF assets%
depreStream = calculateDepreciation(o, vAssetDepr, CF.t, data);

CF.nom.seabedRent = -calculateSeabedRent(o, opRevenue, CF.t, data);               

%determine total taxable revenue%
revTaxable = opRevenue ...
           + CF.nom.operation ...
           + CF.nom.turbMaint + CF.nom.BOPmaint + CF.nom.SSmaint + CF.nom.expMaint ...
           + CF.nom.gridConnection ...
           + CF.nom.seabedRent ...
           + CF.nom.opInsurance ...
           + CF.nom.turbDecom + CF.nom.fndDecom + CF.nom.substationDecom ...
           + CF.nom.opContingency + CF.nom.decContingency ...
           - depreStream;

if strcmpi(o.finance.type, 'project')
    revTaxable = revTaxable + CF.nom.opInterest + CF.nom.intIncome;
end
       
CF.nom.taxes = calculateTaxCashFlow(o, revTaxable, CF.t, data);

CF = calculateRealCashFlows(o, CF, data);