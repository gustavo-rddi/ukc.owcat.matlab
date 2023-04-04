function o = calculateDECEX(o, data, stocVar, markMods)

o = calculateWTGdecomCosts(o, data, stocVar, markMods);

o = calculateFoundationDecomCosts(o, data, stocVar, markMods);

switch upper(o.OWF.expType)
    
    case 'HVAC'; 
    
        %calculate HVAC export system supply and install costs%
        o = calculateHVACexportDecomCosts(o, data, stocVar, markMods);
        
    case 'HVDC'; 
        
        %calculate HVDC export system supply and install costs%
        o = calculateHVDCexportDecomCosts(o, data, stocVar, markMods);
        
end