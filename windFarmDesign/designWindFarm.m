function o = designWindFarm(o, data, stocVar, markMods)

%create wind turbine units%
o = populateWindFarmZones(o, data, stocVar, markMods);

%design wind turbine foundations%
o = designWTGfoundations(o, data, stocVar, markMods);

switch upper(o.design.expConf)
    
    %pre-design HVAC or HVDC export system%
    case {'OHVS','OTM'}; o = determineHVACconnections(o, data, stocVar, markMods);
    case {'VSC','DRU'}; o = determineHVDCconnections(o, data, stocVar, markMods);
        
end

%size array cables%
o = designArrayCables(o, data, stocVar, markMods);

switch upper(o.OWF.expType)
    
    %design HVAC or HVDC export system components%
    case 'HVAC'; o = sizeHVACexportComponents(o, data, stocVar, markMods);
    case 'HVDC'; o = sizeHVDCexportComponents(o, data, stocVar, markMods);
        
end

%display design results%
displayDesignResults(o, {'single', 'stoc'})