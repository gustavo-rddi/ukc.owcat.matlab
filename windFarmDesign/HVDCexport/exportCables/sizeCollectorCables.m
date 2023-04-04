function o = sizeCollectorCables(o, data)

%conductor material%
switch lower(o.design.collCond)
    
    case {'cu', 'copper'}
        
        %calculate rated current of copper cable sections%
        Isect = subseaACcableProperties('Irate', data.HVAC.AsectSB, 'Cu');
        
    case {'al', 'aluminium'}
        
        %calculate rated current of aluminium cable sections%
        Isect = subseaACcableProperties('Irate', data.HVAC.AsectSB, 'Al');
        
end

for i = 1 : o.OWF.nOSS
    
    if o.design.intConSS && o.OWF.nOSS > 1
        
        %calculate minimum export capacity for interconnected substations%
        capExportMin = o.OWF.cap * max(data.HVAC.fRedund/(o.OWF.nOSS - 1), 1/o.OWF.nOSS);
        
        %determine OHVS export capacity with redundancy%
        o.offshoreSS(i).capExport = max(capExportMin, max([o.offshoreSS(:).capWTG]));
        
    else
        
        %no redundancy possible%
        o.offshoreSS(i).capExport = o.offshoreSS(i).capWTG;
         
    end
    
    o.offshoreSS(i).Qoffshore = 0;
    
    Ncable = 1;
    
    for j = 1 : data.model.maxIter
    
        %determine active export current per cable%
        Icable = o.offshoreSS(i).capExport/(Ncable*sqrt(3)*o.design.Vcoll);
    
        %select minimum possible export cable sections%
        Acable = data.HVAC.AsectSB(find(Isect >= Icable, 1));

        %insufficient cable capacity%
        if isempty(Acable)
            Ncable = Ncable + 1;
        else
            break;
        end
        
    end
    
    o.offshoreSS(i).nExportCable = Ncable;
    o.offshoreSS(i).Acable = Acable;
    
end

o.OWF.nCollCable = sum([o.offshoreSS.nExportCable]);