function o = determineHVDCconnections(o, data, ~, ~)

%set export type%
o.OWF.expType = 'HVDC';

%determine target and cumulative SS and WTG capacities%
capTargSS = (1:o.OWF.nOSS)*(o.OWF.cap/o.OWF.nOSS);
capCumulWTG = cumsum([o.WTG.cap]);

for  i = 1 : o.OWF.nWTG
    
    %determine to which SS each WTG is connected%
    o.WTG(i).iSScon = find(capCumulWTG(i) <= capTargSS, 1, 'first');
    
end

for i = 1 : o.OWF.nOSS
    
    %get WTG connected to current SS%
    o.offshoreSS(i).iWTGcon = find([o.WTG.iSScon] == i);
    
    %set SS characteristics%
    o.offshoreSS(i).nWTG = numel(o.offshoreSS(i).iWTGcon);
    o.offshoreSS(i).capWTG = sum([o.WTG(o.offshoreSS(i).iWTGcon).cap]);

    %assumed position at center of connected WTGs%
    o.offshoreSS(i).dWater    = mean([o.WTG(o.offshoreSS(i).iWTGcon).dWater]);
    o.offshoreSS(i).dLandfall = mean([o.WTG(o.offshoreSS(i).iWTGcon).dLandfall]);
    o.offshoreSS(i).dPortCon  = mean([o.WTG(o.offshoreSS(i).iWTGcon).dPortCon]);
    o.offshoreSS(i).dPortOM   = mean([o.WTG(o.offshoreSS(i).iWTGcon).dPortCon]);
    o.offshoreSS(i).pDrill    = mean([o.WTG(o.offshoreSS(i).iWTGcon).pDrill]);
    
    if o.OWF.nOSS > 1
    
        dSpaceSS = 2*sqrt(sum([o.WTG.dSpace].^2)/(pi*o.OWF.nOSS));
        
        %determine average spacing between SS within the OWF zones%
        o.offshoreSS(i).dSpace = dSpaceSS;
    
    else
        
        %no spacing for single unit%
        o.offshoreSS(i).dSpace = 0;
        
    end        
    
end

capTargConv = (1:o.OWF.nConv)*(o.OWF.cap/o.OWF.nConv);
capCumulSS = cumsum([o.offshoreSS.capWTG]);

for  i = 1 : o.OWF.nOSS
    
    %determine to which SS each WTG is connected%
    o.offshoreSS(i).iConvCon = find(capCumulSS(i) <= capTargConv, 1, 'first');
    
end

for i = 1 : o.OWF.nConv
    
    %get WTG connected to current SS%
    o.offshoreConv(i).iSScon = find([o.offshoreSS.iConvCon] == i);
    
    %set SS characteristics%
    o.offshoreConv(i).nSScon = numel(o.offshoreConv(i).iSScon);
    o.offshoreConv(i).capConv = sum([o.offshoreSS(o.offshoreConv(i).iSScon).capWTG]);
    
    %assumed position at center of connected WTGs%
    o.offshoreConv(i).dWater    = mean([o.offshoreSS(o.offshoreConv(i).iSScon).dWater]);
    o.offshoreConv(i).dLandfall = mean([o.offshoreSS(o.offshoreConv(i).iSScon).dLandfall]);
    o.offshoreConv(i).dPortCon  = mean([o.offshoreSS(o.offshoreConv(i).iSScon).dPortCon]);
    o.offshoreConv(i).dPortOM   = mean([o.offshoreSS(o.offshoreConv(i).iSScon).dPortCon]);
    o.offshoreConv(i).pDrill    = mean([o.offshoreSS(o.offshoreConv(i).iSScon).pDrill]);
    
    %calculate total OSS export cable offshore length (sea-bed snaking and water depth)%
    o.offshoreConv(i).lCableOffshore = o.offshoreConv(i).dLandfall*(1 + data.HVDC.fRoute) + o.offshoreConv(i).dWater + data.HVDC.lInt;
    
    %store onshore cable distance%
    o.offshoreConv(i).lCableOnshore = o.OWF.lOnshore;
    
    if o.offshoreConv(i).nSScon == 1
        
        o.offshoreSS(o.offshoreConv(i).iSScon).lCable = o.offshoreConv(i).dWater + o.offshoreSS(o.offshoreConv(i).iSScon).dWater + 2*data.HVAC.lInt;
        
    else
        
        lSSconnect = (dSpaceSS/2) / sin(pi/o.offshoreConv(i).nSScon);
       
        for j = 1 : o.offshoreConv(i).nSScon
            
            o.offshoreSS(o.offshoreConv(i).iSScon(j)).lCable = lSSconnect + o.offshoreConv(i).dWater + o.offshoreSS(o.offshoreConv(i).iSScon(j)).dWater + 2*data.HVAC.lInt;
            
        end
        
    end
    
    if o.OWF.nConv > 1
    
        dSpaceConv = 2*sqrt(sum([o.WTG.dSpace].^2)/(pi*o.OWF.nConv));
        
        %determine average spacing between SS within the OWF zones%
        o.offshoreConv(i).dSpace = dSpaceConv;
    
    else
        
        %no spacing for single unit%
        o.offshoreConv(i).dSpace = 0;
        
    end
    
    o.offshoreConv(i).nExportCable = 2;
    
end