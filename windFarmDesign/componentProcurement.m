function o = componentProcurement(o, data)

%WTG procurement and installation%
o = windTurbineProcurement(o, data);

%foundation procurement and installation%
o = foundationProcurement(o, data);

%array procurement and installation%
o = arrayCableProcurement(o, data);

switch upper(o.OWF.expType)
    
    %export cable procurement requirements%
    case 'HVAC'; o = HVACexportCableProcurement(o, data);
    case 'HVDC'; o = HVDCexportCableProcurement(o, data);
        
end