function o = determineHVACconnections(o, data)

%set export type%
o.OWF.expType = 'HVAC';

if strcmpi(o.design.expConf, 'OTM')
    
    capMaxOTM = data.OTM.capMax * o.design.Vexport/220e3;
    
    %increase number of SS if OTM capacity insufficient (min. 2 for SQSS)%
    o.OWF.nOSS = max([o.OWF.nOSS, ceil(o.OWF.cap / capMaxOTM), 2]);
    
end

%determine cumulative SS and WTG capacities%
capCumulSS = (1:o.OWF.nOSS)*(o.OWF.cap/o.OWF.nOSS);
capCumulWTG = cumsum([o.WTG.cap]);

for  i = 1 : o.OWF.nWTG
    
    %determine to which SS each WTG is connected%
    o.WTG(i).iSScon = find(capCumulWTG(i) <= capCumulSS, 1, 'first');
    
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
    o.offshoreSS(i).soilType  = mean([o.WTG(o.offshoreSS(i).iWTGcon).soilType]);
    
    if o.OWF.nOSS > 1
    
        %determine average spacing between SS within the OWF zones%
        o.offshoreSS(i).dSpace = 2*sqrt(sum([o.WTG.dSpace].^2)/(pi*o.OWF.nOSS));
    
    else
        
        %no spacing for single unit%
        o.offshoreSS(i).dSpace = 0;
        
    end        
        
    %calculate total OSS export cable offshore length (sea-bed snaking and water depth)%
    o.offshoreSS(i).lCableOffshore = o.offshoreSS(i).dLandfall*(1 + data.HVAC.fRoute) + (o.offshoreSS(i).dWater + data.HVAC.lInt)*(1 + 2*o.design.osComp);
    
    %store onshore cable distance%
    o.offshoreSS(i).lCableOnshore = o.OWF.lOnshore;
    
    if strcmpi(o.design.expConf, 'OTM') && o.OWF.fndShare
        
        %determine which turbine is mounted on the OTM%
        o.offshoreSS(i).iWTGshare = o.offshoreSS(i).iWTGcon(1);
        
    end
    
end