function displayYieldResults(o, modes)

if any(strcmpi(o.runMode, modes))
    
    %display  results of yield calculation%
    fprintf(1, '  Net Wind Farm Yield:     %5.0f [GWh/yr]\n', o.OWF.AEPnet/3.6e12);
    fprintf(1, '  Net Capacity Factor:     %5.1f [%%]\n', o.OWF.fCap*100);
    
    disp(' ');
    
end
