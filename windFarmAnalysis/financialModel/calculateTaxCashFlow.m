function taxes = calculateTaxCashFlow(o, revTax, t, data)

%determine cost of taxes%
taxes = -data.econ.(o.OWF.loc).taxCorp * revTax;

if strcmpi(o.finance.type, 'project')

    switch upper(o.OWF.loc)
        
        case 'FR'; carryLim = min(revTax, 0.5*revTax+5e5);
        case 'UK'; carryLim = Inf * ones(size(revTax));
            
    end
    
    taxCredit = 0;
    
    if any(taxes > 0)
        
        for i = find(t >= 0)
            
            if taxes(i) > 0
                
                if i < length(t)
                    
                    %apply tax credits for loss-making years%
                    taxCredit = taxCredit + taxes(i);
                    
                end
                
                %move taxes forward%
                taxes(i) = 0;
                
            elseif taxCredit > 0
                
                taxes(i) = -data.econ.(o.OWF.loc).taxCorp * (revTax(i) - min(taxCredit, carryLim(i)));
                
                taxCredit = taxCredit - min(taxCredit, carryLim(i));
                
            end
            
        end
        
    end
    
end

switch upper(o.OWF.loc)
    
    case 'FR'
        
        taxes = taxes + data.econ.FR.sCharge*taxes.*(taxes>0);
        
end