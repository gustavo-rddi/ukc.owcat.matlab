function o = runFinancialModel(o, data, stocVar, markMods)

%inform of current operation%
message(o, 'Building Financial Model...', 1);

o = calculateLCOEvalues(o, data, stocVar, markMods);


switch upper(o.OWF.loc);
    
    case 'FR'; o = calculateSubsidyFR(o, data);
    case 'UK'; o = calculateSubsidyUK(o, data);
        
end
