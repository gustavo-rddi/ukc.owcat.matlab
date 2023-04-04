function CF = variableLCOEcashFlows_project(o, CF, data, LCOE, ecMode)


%Comments
%What if I compute real? then I will not be able to calculate anything
%else!




%determine real-to-nominal conversion factors%
fNom = arrayfun(@(X)CPImodifier(data, X, data.econ.(o.OWF.loc).yrReal, data.econ.(o.OWF.loc).curr), o.OWF.yrOper + CF.t);

CF_P90 = CF;


switch lower(ecMode)
            
    case 'nom';  
        
        CF_P90.nom.elecSale = o.OWF.annYieldP90 * LCOE;
            
        targSalesStartP90 = o.OWF.AEPnetP90 * LCOE;
        targSalesAnnP90 = o.OWF.AEPnetP90 * LCOE * (CF.t >= 0) .* (CF.t < data.WTG.nOper);
        
    case 'real'; 
        
      CF_P90.nom.elecSale = o.OWF.annYieldP90 * LCOE .* fNom;
            
         targSalesStartP90 = o.OWF.AEPnetP90 * LCOE * fNom(CF.t == 0);
         targSalesAnnP90 = o.OWF.AEPnetP90 * LCOE .* fNom .* (CF.t >= 0) .* (CF.t < data.WTG.nOper);

end



opRevenueP90 = CF_P90.nom.elecSale .* (CF.t >= 0);
commRevenueP90 = CF_P90.nom.elecSale .* (CF.t < 0);


 CF_P90.nom.seabedRent = -calculateSeabedRent(o, opRevenueP90, CF.t, data);

investment = -CF.nom.turbSupply + -CF.nom.turbInstall ...
           + -CF.nom.fndSupply + -CF.nom.fndInstall ...
           + -CF.nom.arraySupply + -CF.nom.arrayInstall ...
           + -CF.nom.substationSupply + -CF.nom.substationInstall ...
           + -CF.nom.exportSupply + -CF.nom.exportInstall ...
           + -CF.nom.onshoreSupply + -CF.nom.onshoreInstall ...
           + -CF.nom.portFacilities;
           
vAssetCon = sum(investment);  

CARinsurance = vAssetCon * data.econ.fInsCAR * (1 + data.econ.(o.OWF.loc).taxIns);
DSUinsuranceP90 = targSalesStartP90 * data.econ.fInsDSU * (1 + data.econ.(o.OWF.loc).taxIns);

%calculate insurance costs during wind farm construction%
CF_P90.nom.conInsurance = generateCashFlow(o, data, -(CARinsurance+DSUinsuranceP90), 'AtFID');
unleveragedInvestmentP90 = investment + -CF_P90.nom.conInsurance + -CF.nom.projManagement + -CF.nom.development + -CF.nom.conContingency;
leveragedInvestmentP90 = unleveragedInvestmentP90;



for n = 1 : data.model.maxIter

 vAssetReplP90 = sum(leveragedInvestmentP90);
        
 PDinsuranceP90 = vAssetReplP90 * data.econ.fInsPD * (1 + data.econ.(o.OWF.loc).taxIns);
 BIinsuranceP90 = targSalesAnnP90 * data.econ.fInsBI * (1 + data.econ.(o.OWF.loc).taxIns);
 
%calculate insurance costs during wind farm operation%           
 CF_P90.nom.opInsurance = generateCashFlow(o, data, -PDinsuranceP90, 'oper') - BIinsuranceP90;
        
 vAssetDeprP90 = sum(leveragedInvestmentP90 - commRevenueP90);
 
%determine depreciation of OWF assets%  
 depreStreamP90 = calculateDepreciation(o, vAssetDeprP90, CF.t, data);
        

%determine total taxable revenue%
 revTaxableP90 = opRevenueP90 ...
            + CF_P90.nom.operation ...
            + CF_P90.nom.turbMaint + CF_P90.nom.BOPmaint + CF_P90.nom.SSmaint + CF_P90.nom.expMaint ...
            + CF_P90.nom.gridConnection ...
            + CF_P90.nom.seabedRent ...
            + CF_P90.nom.opInsurance ...
            + CF_P90.nom.turbDecom + CF_P90.nom.fndDecom + CF_P90.nom.substationDecom ...
            + CF_P90.nom.opContingency + CF_P90.nom.decContingency ...
            - depreStreamP90;
        
 revTaxableP90 = revTaxableP90 + CF_P90.nom.intIncome + CF_P90.nom.opInterest;
 
 CF_P90.nom.taxes = calculateTaxCashFlow(o, revTaxableP90, CF.t, data);

CFADS = opRevenueP90 ...
              + CF_P90.nom.intIncome ...
              + CF_P90.nom.operation ...
              + CF_P90.nom.turbMaint + CF_P90.nom.BOPmaint + CF_P90.nom.SSmaint + CF_P90.nom.expMaint ...
              + CF_P90.nom.gridConnection ...
              + CF_P90.nom.seabedRent ...
              + CF_P90.nom.opInsurance ...
              + CF_P90.nom.turbDecom + CF_P90.nom.fndDecom + CF_P90.nom.substationDecom ...
              + CF_P90.nom.opContingency + CF_P90.nom.decContingency ...
              + CF_P90.nom.decomReserve ...
              + CF_P90.nom.taxes;

 CF_P90 = debtScuplting(o, data, CF_P90, leveragedInvestmentP90, CFADS);
 
 %Results from Debt Sculpting(debtFinance,opInterest,conInterest,financingfees)
       
oldInvestment = sum(leveragedInvestmentP90);
newInvestment = sum(unleveragedInvestmentP90 + -CF_P90.nom.conInterest + -CF_P90.nom.financingFees);      
        
  

 %Convergence criteria
 if abs(newInvestment - oldInvestment)/oldInvestment < data.model.tolConv
            break;
 else
    leveragedInvestmentP90 = unleveragedInvestmentP90 + -CF_P90.nom.conInterest + -CF_P90.nom.financingFees;
 end          
    
 
 
end

%Do I need to update this with CF_90?
CF = calculateRealCashFlows(o, CF_P90, data);



        
        
        
       
       
       
       


