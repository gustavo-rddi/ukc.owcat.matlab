function o = designOffshoreWindFarm(o, data)

%create wind turbine units%
o = populateWindFarmZones(o, data);

switch upper(o.OWF.expType)
    
    %pre-design HVAC or HVDC export system%
    case 'HVAC'; 
        
        o = determineHVACconnections(o, data);
        
        switch upper(o.design.expConf)
            
            case 'OHVS';
                
                %design OHVS export system%
                o = sizeOHVSexportCables(o, data);
                
            case 'OTM';
                
                %design OTM export system%
                o = sizeOTMexportCables(o, data);
                
        end
        
        %size array cables%
        o = designSubstationArrayCables(o, data);
        
                
    case 'HVDC'; 
        
        o = determineHVDCconnections(o, data);
        
        %size array cables%
        o = designSubstationArrayCables(o, data);
        
        o = sizeCollectorCables(o, data);
        
        o = sizeHVDCBipoleCables(o, data);
   
    case 'MVAC'
        
        o = designExportArrayCables(o, data);
        
end

switch upper(o.OWF.expType)
    
    %design HVAC or HVDC export system components%
    case 'HVAC'; o = sizeHVACexportComponents(o, data);
    case 'HVDC'; o = sizeHVDCexportComponents(o, data);
        
end

%display design results%
displayDesignResults(o, {'single', 'stoc'})