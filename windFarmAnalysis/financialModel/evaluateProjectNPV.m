function NPV = evaluateProjectNPV(o, CF, data, Pvalue, revType, ecMode)
%Only LCOE has been modified according to project and corporate finance
switch lower(revType)
    
    case 'lcoe'
        
        CF = variableLCOEcashFlows(o, CF, data, Pvalue, ecMode);
        switch lower(o.finance.type)
        
            case 'corporate'; fDisc = o.finance.kHurdle;
                %CF = variableLCOEcashFlows_corporate(o, CF, data, Pvalue, ecMode);
                
            case 'project'; fDisc = o.finance.MARR;
                %CF = variableLCOEcashFlows_project(o, CF, data, Pvalue, ecMode);
                
        end
        
    case 'p0r'
        
        CF = variableP0RcashFlows(o, CF, data, Pvalue);
        
        fDisc = data.econ.FR.ROEcap;
        
    case 'p0e'
        
        CF = variableP0EcashFlows(o, CF, data, Pvalue);
        
        switch lower(o.finance.type)
        
            case 'corporate'; fDisc = o.finance.kHurdle;
            case 'project'; fDisc = o.finance.MARR;
                
        end
              
    case 'pstrike'    
        
        CF = variablePstrikeCashFlows(o, CF, data, Pvalue);
        
        switch lower(o.finance.type)
        
            case 'corporate'; fDisc = o.finance.kHurdle;
            case 'project'; fDisc = o.finance.MARR;
                
        end
        
end

CFlist = fieldnames(CF.nom);

NPV = 0;

for i = 1 : length(CFlist)
   
    NPV = NPV + sum(CF.nom.(CFlist{i}) ./ (1 + fDisc).^CF.t);
   
end