function o = variableWindFarmDesignElements(o, data, stocVar, markMods)

%design wind turbine foundations%
o = designWTGfoundations(o, data, stocVar, markMods);

switch upper(o.OWF.expType)
    
    %design HVAC or HVDC export system components%
    case 'HVAC'; o = sizeHVACexportComponents(o, data, stocVar, markMods);
    case 'HVDC'; o = sizeHVDCexportComponents(o, data, stocVar, markMods);
        
end
