function o = calculateCAPEX(o, data, stocVar, markMods)

%calculate WTG supply and install costs%
o = calculateWTGsupplyCosts(o, data, stocVar, markMods);
o = calculateWTGinstallCosts(o, data, stocVar, markMods);

%calculate WTG supply and install costs%
o = calculateFoundationSupplyCosts(o, data, stocVar, markMods);
o = calculateFoundationInstallCosts(o, data, stocVar, markMods);

%calculate array supply and install costs%
o = calculateArraySupplyCosts(o, data, stocVar, markMods);
o = calculateArrayInstallCosts(o, data, stocVar, markMods);

switch upper(o.OWF.expType)
    
    case 'HVAC'; 
    
        %calculate HVAC export system supply and install costs%
        o = calculateHVACexportSupplyCosts(o, data, stocVar, markMods);
        o = calculateHVACexportInstallCosts(o, data, stocVar, markMods);
        
    case 'HVDC'; 
        
        %calculate HVDC export system supply and install costs%
        o = calculateHVDCexportSupplyCosts(o, data, stocVar, markMods);
        o = calculateHVDCexportInstallCosts(o, data, stocVar, markMods);
        
    case 'MVAC';
        
        o = calculateHVACexportCableCosts(o, data, stocVar, markMods);
        
        %calculate costs for landfall substation%
        if o.design.lfComp
            o = calculateHVAClandfallSubstationCosts(o, data, stocVar, markMods);
        end

        if o.design.osComp
            o = calculateHVACoffshoreCompensationCosts(o, data, stocVar, markMods);
        end
        
        o = calculateMVACgridSubstationCosts(o, data, stocVar, markMods);
        
        %calculate cost of offshore installation%
        o = calculateMVACexportCableInstallCosts(o, data, stocVar, markMods);
        
end

%calculate indirect project costs%
o = calculateIndirectCosts(o, data, stocVar, markMods);