function displayDesignResults(o, modes)

if any(strcmpi(o.runMode, modes))
    
    %display results of OWF design calculation%
    fprintf(1, '  Wind Farm Capacity:      %5.0f [MW]\n', o.OWF.cap/1e6);
    fprintf(1, '  Number of Turbine Units: %5.0f [#]\n', o.OWF.nWTG);

    switch upper(o.OWF.expType)
        
        case 'HVAC'
    
        %display results of HVAC system design calculation%
        fprintf(1, '  Number of Substations:   %5.0f [#]\n', o.OWF.nOSS);
        fprintf(1, '  Number of Export Cables: %5.0f [#]\n', o.OWF.nExportCable);
    
        case 'HVDC'
        
        %display results of HVDC system design calculation%
        fprintf(1, '  Number of AC Collectors: %5.0f [#]\n', o.OWF.nOSS);
        fprintf(1, '  Number of DC Converters: %5.0f [#]\n', o.OWF.nConv);
        fprintf(1, '  Number of DC Bipoles:    %5.0f [#]\n', o.OWF.nConv);
        
        case 'MVAC'
            
        fprintf(1, '  Number of Export Cables: %5.0f [#]\n', o.OWF.nExportCable);    
        
    end
    
    disp(' ');
    
end
