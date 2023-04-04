function CF = variableLCOEcashFlows(o, CF, data, LCOE, ecMode)

%determine real-to-nominal conversion factors%
fNom = arrayfun(@(X)CPImodifier(data, X, data.econ.(o.OWF.loc).yrReal, data.econ.(o.OWF.loc).curr), o.OWF.yrOper + CF.t);

if strcmpi(o.finance.type, 'project')

    CF_P90 = CF;
    
end

switch lower(ecMode)
            
    case 'nom';  
        
        CF.nom.elecSale = o.OWF.annYield * LCOE;
        
        targSalesStart = o.OWF.AEPnet * LCOE;
        targSalesAnn = o.OWF.AEPnet * LCOE * (CF.t >= 0) .* (CF.t < data.WTG.nOper);
        
        if strcmpi(o.finance.type, 'project')
        
            CF_P90.nom.elecSale = o.OWF.annYieldP90 * LCOE;
            
            targSalesStartP90 = o.OWF.AEPnetP90 * LCOE;
            targSalesAnnP90 = o.OWF.AEPnetP90 * LCOE * (CF.t >= 0) .* (CF.t < data.WTG.nOper);
    
        end
        
    case 'real'; 
        
        CF.nom.elecSale = o.OWF.annYield * LCOE .* fNom;
        
        targSalesStart = o.OWF.AEPnet * LCOE * fNom(CF.t == 0);
        targSalesAnn = o.OWF.AEPnet * LCOE .* fNom .* (CF.t >= 0) .* (CF.t < data.WTG.nOper);
        
        if strcmpi(o.finance.type, 'project')
            
            CF_P90.nom.elecSale = o.OWF.annYieldP90 * LCOE .* fNom;
            
            targSalesStartP90 = o.OWF.AEPnetP90 * LCOE * fNom(CF.t == 0);
            targSalesAnnP90 = o.OWF.AEPnetP90 * LCOE .* fNom .* (CF.t >= 0) .* (CF.t < data.WTG.nOper);
            
        end
        
end

opRevenue = CF.nom.elecSale .* (CF.t >= 0);
commRevenue = CF.nom.elecSale .* (CF.t < 0);

CF.nom.seabedRent = -calculateSeabedRent(o, opRevenue, CF.t, data);

investment = -CF.nom.turbSupply + -CF.nom.turbInstall ...
           + -CF.nom.fndSupply + -CF.nom.fndInstall ...
           + -CF.nom.arraySupply + -CF.nom.arrayInstall ...
           + -CF.nom.substationSupply + -CF.nom.substationInstall ...
           + -CF.nom.exportSupply + -CF.nom.exportInstall ...
           + -CF.nom.onshoreSupply + -CF.nom.onshoreInstall ...
           + -CF.nom.portFacilities;
      
vAssetCon = sum(investment);  

CARinsurance = vAssetCon * data.econ.fInsCAR * (1 + data.econ.(o.OWF.loc).taxIns);
DSUinsurnace = targSalesStart * data.econ.fInsDSU * (1 + data.econ.(o.OWF.loc).taxIns);

%calculate insurance costs during wind farm construction%
CF.nom.conInsurance = generateCashFlow(o, data, -(CARinsurance+DSUinsurnace), 'AtFID');

unleveragedInvestment = investment + -CF.nom.conInsurance + -CF.nom.projManagement + -CF.nom.development + -CF.nom.conContingency;

leveragedInvestment = unleveragedInvestment;

if strcmpi(o.finance.type, 'project')

    opRevenueP90 = CF_P90.nom.elecSale .* (CF.t >= 0);
    commRevenueP90 = CF_P90.nom.elecSale .* (CF.t < 0);

    CF_P90.nom.seabedRent = -calculateSeabedRent(o, opRevenueP90, CF.t, data);
    
    DSUinsuranceP90 = targSalesStartP90 * data.econ.fInsDSU * (1 + data.econ.(o.OWF.loc).taxIns);
    
    CF_P90.nom.conInsurance = generateCashFlow(o, data, -(CARinsurance+DSUinsuranceP90), 'AtFID');
    
    unleveragedInvestmentP90 = investment + -CF_P90.nom.conInsurance + -CF.nom.projManagement + -CF.nom.development + -CF.nom.conContingency;
    
    leveragedInvestmentP90 = unleveragedInvestmentP90;

end

for n = 1 : data.model.maxIter

    vAssetRepl = sum(leveragedInvestment);

    PDinsurance = vAssetRepl * data.econ.fInsPD * (1 + data.econ.(o.OWF.loc).taxIns);
    BIinsurance = targSalesAnn * data.econ.fInsBI * (1 + data.econ.(o.OWF.loc).taxIns);
    
    %calculate insurance costs during wind farm operation%       
    CF.nom.opInsurance = generateCashFlow(o, data, -PDinsurance, 'oper') - BIinsurance;

    vAssetDepr = sum(leveragedInvestment - commRevenue);
    
    %determine depreciation of OWF assets%
    depreStream = calculateDepreciation(o, vAssetDepr, CF.t, data);
    
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
    
        revTaxable = revTaxable + CF.nom.intIncome + CF.nom.opInterest;
        
        CF.nom.taxes = calculateTaxCashFlow(o, revTaxable, CF.t, data);
        
        vAssetReplP90 = sum(leveragedInvestmentP90);
        
        PDinsuranceP90 = vAssetReplP90 * data.econ.fInsPD * (1 + data.econ.(o.OWF.loc).taxIns);
        BIinsuranceP90 = targSalesAnnP90 * data.econ.fInsBI * (1 + data.econ.(o.OWF.loc).taxIns);
        
        CF_P90.nom.opInsurance = generateCashFlow(o, data, -PDinsuranceP90, 'oper') - BIinsuranceP90;
        
        vAssetDeprP90 = sum(leveragedInvestmentP90 - commRevenueP90);
        
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
        
        CF.nom.debtFinance = CF_P90.nom.debtFinance;

        CF.nom.opInterest = CF_P90.nom.opInterest;
        
        CF.nom.conInterest = CF_P90.nom.conInterest;

        CF.nom.financingFees = CF_P90.nom.financingFees;
       

        oldInvestment = sum(leveragedInvestment);
        newInvestment = sum(unleveragedInvestment + -CF.nom.conInterest + -CF.nom.financingFees);
        
        if abs(newInvestment - oldInvestment)/oldInvestment < data.model.tolConv
            break;
        else
            leveragedInvestment = unleveragedInvestment + -CF.nom.conInterest + -CF.nom.financingFees;
            leveragedInvestmentP90 = unleveragedInvestmentP90 + -CF_P90.nom.conInterest + -CF_P90.nom.financingFees;
        end
        
    else
        
        CF.nom.taxes = calculateTaxCashFlow(o, revTaxable, CF.t, data);
        
        break;
        
    end
    
end 

CF = calculateRealCashFlows(o, CF, data);