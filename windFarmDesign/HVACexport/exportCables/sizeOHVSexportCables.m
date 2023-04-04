function o = sizeOHVSexportCables(o, data)

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
IsectUG = undergroundACcableProperties('Irate', data.HVAC.AsectUG, 'Cu');

%initialise number of cables per SS%
NminCable = ceil(o.OWF.cap/data.HVAC.capMaxCBL);
NcableSS = ceil(NminCable/o.OWF.nOSS);

for k = 1 : data.model.maxIter
    
    for i = 1 : o.OWF.nOSS
        
        if o.design.intConSS
            
            %calculate minimum export capacity for interconnected substations%
            capExportMin = o.OWF.cap * NcableSS * max(data.HVAC.fRedund/(NcableSS*o.OWF.nOSS - 1), 1/(NcableSS*o.OWF.nOSS));
            
            %determine OHVS export capacity with redundancy%
            o.offshoreSS(i).capExport = max(capExportMin, max([o.offshoreSS(:).capWTG]));
            
        else
        
            if NcableSS == 1;
                
                %no redundancy for single-cable OHVS designs%
                o.offshoreSS(i).capExport = o.offshoreSS(i).capWTG;
                
            else
            
                %determine OHVS export capacity with redundancy%
                o.offshoreSS(i).capExport = o.offshoreSS(i).capWTG * NcableSS * max(data.HVAC.fRedund/(NcableSS - 1), 1/NcableSS);
                
            end
            
        end
        
        %determine reactive power supplied to the OTM by the WTGs%
        QsupplyWTG = o.offshoreSS(i).capWTG * sqrt(1/data.OHVS.cosPhi^2 - 1);
                
        %intialise cable design%
        IchargeSBmax = 0; IchargeUGmax = 0;
        
        %determine active export current per cable%
        IexportCBL = o.offshoreSS(i).capExport/(sqrt(3)*o.design.Vexport*NcableSS);
        
        for j = 1 : data.model.maxIter
            
            %calculate maximum current in cable sections%
            ImaxSB = sqrt(IexportCBL^2 + IchargeSBmax^2);
            ImaxUG = sqrt(IexportCBL^2 + IchargeUGmax^2);
            
            %select minimum possible export cable sections%
            AcableSB = data.HVAC.AsectSB(find(IsectSB >= ImaxSB, 1));
            AcableUG = data.HVAC.AsectUG(find(IsectUG >= ImaxUG, 1));
            
            %insufficient cable capacity%
            if isempty(AcableSB) || isempty(AcableUG)
                
                %increment number of cables%
                NcableSSnew = NcableSS + 1;
                
            else
                
                %calculate charging current for HVAC cables%
                [IchargeSBmaxNew, IchargeUGmaxNew, Qss, Qop, Qlf, Qgrid] = calculateChargingCurrents(o, o.offshoreSS(i).lCableOffshore, AcableSB, o.offshoreSS(i).lCableOnshore, AcableUG, data.OHVS.fCompOff, QsupplyWTG/NcableSS);
                
                %keep cable number%
                NcableSSnew = NcableSS;
                
            end
            
            %check for change in cable rating and iterate%
            if (NcableSSnew ~= NcableSS)
                break;
            elseif (IchargeSBmaxNew == IchargeSBmax) && (IchargeUGmaxNew == IchargeUGmax)
                break
            else
                IchargeSBmax = IchargeSBmaxNew;
                IchargeUGmax = IchargeUGmaxNew;
            end
            
        end
        
        %check design success%
        if (NcableSSnew ~= NcableSS)
            break;
        else
                    
            %store number of export cables%
            o.offshoreSS(i).nExportCable = NcableSS;
            
            %store export cable sections%
            o.offshoreSS(i).AcableSB = AcableSB;
            o.offshoreSS(i).AcableUG = AcableUG;
            
            o.offshoreSS(i).Qoffshore = Qss * o.offshoreSS(i).nExportCable;
            
            %store grid-side reactive power requirement%
            o.offshoreSS(i).QgridSS = Qgrid * o.offshoreSS(i).nExportCable;
            
            %store reactive power requirement at landfall substation%
            if o.design.lfComp; o.offshoreSS(i).QlandfallSS = Qlf * o.offshoreSS(i).nExportCable; end;
            
            %store reactive power requirement at offshore compensation platform%
            if o.design.osComp; o.offshoreSS(i).QcompPlat = Qop * o.offshoreSS(i).nExportCable; end;
    
        end
        
    end
    
    %check convergence%
    if (NcableSSnew ~= NcableSS)
        NcableSS = NcableSSnew;
    else
        break
    end
    
end

%store overall OWF export cable number%
% o.OWF.nExportCable = NcableSS*o.OWF.nOSS;
o.OWF.nExportCable = 2;