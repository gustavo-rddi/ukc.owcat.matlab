function o = sizeOTMexportCables(o, data, ~)

%conductor material%
switch lower(o.design.expCond)
    
    case {'cu', 'copper'}
        
        %calculate rated current of copper cable sections%
        IsectSB = subseaACcableProperties('Irate', data.HVAC.AsectSB, 'Cu');
        
    case {'al', 'aluminium'}
        
        %calculate rated current of aluminium cable sections%
        IsectSB = subseaACcableProperties('Irate', data.HVAC.AsectSB, 'Al');
        
end

%calculate rated current of underground cable sections%
IsectUG = undergroundACcableProperties('Irate', data.HVAC.AsectUG, 'Al');
    
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
     
    %determine reactive power supplied to the OTM by the WTGs%
    QsupplyWTG = o.offshoreSS(i).capWTG * sqrt(1/data.OTM.cosPhi^2 - 1);
    
    %intialise cable design%
    IchargeSBmax = 0; IchargeUGmax = 0;
    
    %determine active export current per cable%
    IexportCBL = o.offshoreSS(i).capExport/(sqrt(3)*o.design.Vexport);
    
    for j = 1 : data.model.maxIter
        
        %calculate maximum current in cable sections%
        ImaxSB = sqrt(IexportCBL^2 + IchargeSBmax^2);
        ImaxUG = sqrt(IexportCBL^2 + IchargeUGmax^2);
        
        %select minimum possible export cable sections%
        AcableSB = data.HVAC.AsectSB(find(IsectSB >= ImaxSB, 1));
        AcableUG = data.HVAC.AsectUG(find(IsectUG >= ImaxUG, 1));
        
        %insufficient cable capacity%
        if isempty(AcableSB) || isempty(AcableUG)
            
            %only 1 cable for OTM%
            o.success = 0;
            return;
            
        else
            
            %calculate charging current for HVAC cables%
            [IchargeSBmaxNew, IchargeUGmaxNew, ~, Qop, Qlf, Qgrid] = calculateChargingCurrents(o, o.offshoreSS(i).lCableOffshore, AcableSB, o.offshoreSS(i).lCableOnshore, AcableUG, 0, QsupplyWTG);
            
        end
        
        %check for change in cable rating and iterate%
        if (IchargeSBmaxNew == IchargeSBmax) && (IchargeUGmaxNew == IchargeUGmax)
            break
        else
            IchargeSBmax = IchargeSBmaxNew;
            IchargeUGmax = IchargeUGmaxNew;
        end
        
    end
    
    %store number of export cables%
    o.offshoreSS(i).nExportCable = 1;
    
    %store export cable sections%
    o.offshoreSS(i).AcableSB = AcableSB;
    o.offshoreSS(i).AcableUG = AcableUG;
    
    %store grid-side reactive power requirement%
    o.offshoreSS(i).QgridSS = Qgrid;
    
    %store reactive power requirement at landfall substation%
    if o.design.lfComp; o.offshoreSS(i).QlandfallSS = Qlf; end;
    
    %store reactive power requirement at offshore compensation platform%
    if o.design.osComp; o.offshoreSS(i).QcompPlat = Qop; end;
    
end

%store overall OWF export cable number%
o.OWF.nExportCable = o.OWF.nOSS;