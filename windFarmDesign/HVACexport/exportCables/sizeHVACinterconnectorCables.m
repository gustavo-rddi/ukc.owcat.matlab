function o = sizeHVACinterconnectorCables(o, data, ~)

if o.OWF.nOSS == 1
    
    %no interconnector for single OSS%
    o.offshoreSS.nInterConnect = 0;
    
else
    
    %calculate rated current of available cable sections%
    IsectSB = subseaACcableProperties('Irate', data.HVAC.AsectSB, 'Cu');
    
    %determine total area covered by OWF%
    areaOWF = sum([o.zone(:).nWTG].*[o.zone(:).dSpace].^2);

    for i = 1 : o.OWF.nOSS
        
        %interconnector capacity%
        if o.OWF.nOSS == 2
            o.offshoreSS(i).nInterConnect = 1;
            capInterConnect = o.offshoreSS(i).capExport/o.offshoreSS(i).nExportCable;
        else
            o.offshoreSS(i).nInterConnect = 2;
            capInterConnect = o.offshoreSS(i).capExport/(2*o.offshoreSS(i).nExportCable);
        end
        
        o.offshoreSS(i).nHVswitch = o.offshoreSS(i).nHVswitch + o.offshoreSS(i).nInterConnect + (o.offshoreSS(i).nExportCable == 1);
        
        %determine length of interconnector cables%
        o.offshoreSS(i).lInterConnect = 2*sqrt(areaOWF/(pi*o.OWF.nOSS))*(1+data.HVAC.fRoute) + 2*o.offshoreSS(i).dWater + 2*data.HVAC.lInt;
        
        %determine current transferred per cable%
        IexportCBL = capInterConnect/(sqrt(3)*o.OWF.Vexport);
        
        %select minimum possible export cable section%
        o.offshoreSS(i).AcableIC = data.HVAC.AsectSB(find(IsectSB >= IexportCBL, 1));
        
        %limit to maximum single cable section%
        if isempty(o.offshoreSS(i).AcableIC)
            o.offshoreSS(i).AcableIC = max(data.HVAC.AsectSB);
        end
        
    end
    
end