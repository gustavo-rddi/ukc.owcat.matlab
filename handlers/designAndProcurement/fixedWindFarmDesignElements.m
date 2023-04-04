function o = fixedWindFarmDesignElements(o, data, markMods)

%create wind turbine units%
o = populateWindFarmZones(o, data, markMods);
o = windTurbineProcurement(o, data, markMods);

switch upper(o.design.expConf)
    
    %pre-design HVAC or HVDC export system%
    case {'OHVS','OTM'}; 
        
        o = determineHVACconnections(o, data, markMods);
        
        switch upper(o.design.expConf)
            
            case 'OHVS';
                
                %design OHVS export system%
                o = sizeOHVSexportCables(o, data, markMods);
                
            case 'OTM';
                
                %design OTM export system%
                o = sizeOTMexportCables(o, data, markMods);
                
        end
        
        o = HVACexportCableProcurement(o, data, markMods);
                
    case {'VSC','DRU'}; 
        
        o = determineHVDCconnections(o, data, markMods);
                
        o = HVDCexportCableProcurement(o, data, markMods);
        
end

o = foundationProcurement(o, data, markMods);

%size array cables%
o = designArrayCables(o, data, markMods);
o = arrayCableProcurement(o, data, markMods);

%design substation interconnectors%
if o.design.intConSS
    o = sizeHVACinterconnectorCables(o, data, markMods);
end

%determine operational lifetime%
o.OWF.nOper = data.WTG.nOper;
o.OWF.nProj = 6+o.OWF.nComm+data.WTG.nOper+2;

%get WTG lifetime%
o.OWF.yrProj = o.OWF.yrOper + (-(6+o.OWF.nComm) : data.WTG.nOper+1);

%display design results%
displayDesignResults(o, {'single', 'stoc'})