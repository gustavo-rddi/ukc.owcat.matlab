function o = sizeHVACexportComponents(o, data)

switch upper(o.design.expConf)
    
    case 'OHVS'; 
    
        %design OHVS export system%
        o = sizeOHVScomponents(o, data);
    
    case 'OTM'; 
        
        %design OTM export system%
        o = sizeOTMcomponents(o, data);
        
end

%design HVAC onshore substation%
o = sizeHVACgridSubstationComponents(o, data);

%design HVAC landfall compensation substation%
if o.design.lfComp
    o = sizeHVAClandfallSubstationComponents(o, data);
end

%design offshore compensation platform%
if o.design.osComp
    o = sizeHVACoffshoreCompensationPlatform(o, data);
end

%design substation interconnectors%
if o.design.intConSS
    o = sizeHVACinterconnectorCables(o, data);
end