function o = vesselCharterPlanning(o, data, stocVar, markMods)

%WTG procurement and installation%
o = windTurbineInstallation(o, data, stocVar, markMods);
o = windTurbineDecommissioning(o, data, stocVar, markMods);

%foundation procurement and installation%
o = foundationInstallation(o, data, stocVar, markMods);
o = foundationDecommissioning(o, data, stocVar, markMods);

%array procurement and installation%
o = arrayCableInstallation(o, data, stocVar, markMods);

switch upper(o.OWF.expType)
    
    case 'HVAC'; 
        
        %HVAC system procurement requirements%
        o = HVACexportCableInstallation(o, data, stocVar, markMods);
        o = HVACsubstationInstallation(o, data, stocVar, markMods);
        o = HVACsubstationDecommissioning(o, data, stocVar, markMods);
    
    case 'HVDC'; 
        
        %HVDC system procurement requirements%
        o = HVDCexportCableInstallation(o, data, stocVar, markMods);
        o = HVDCsubstationInstallation(o, data, stocVar, markMods);
        o = HVDCsubstationDecommissioning(o, data, stocVar, markMods);
                    
    case 'MVAC';
        
        o = MVACexportCableInstallation(o, data, stocVar, markMods);
        
end

%determine required vessel mobilisation%
o = vesselMobilisation(o, data, stocVar, markMods);