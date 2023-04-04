function o = setHVDCcollectorSpecifications(o, data)

%determine total area covered by OWF%
areaOWF = sum([o.zone(:).nWTG].*[o.zone(:).dSpace].^2);

for i = 1 : o.OWF.nColl
    
    %cumulative capacity of all WTGs%
    capCumulWTG = cumsum([o.WTG(:).cap]);
    
    %fractional number of strings per WTG%
    nCumStr = cumsum(1./[o.zone([o.WTG(:).zone]).nWTGstr]);
    
    %initialise marginal WTG vector%
    if i == 1; iWTGmarg = zeros(1, o.OWF.nColl); end
    
    %determine marginal WTG for current OSS%
    iWTGmarg(i) = find(capCumulWTG >= o.OWF.cap * i/o.OWF.nColl, 1);
    
    if i == 1
        
        %calculate first OSS export capacity%
        o.offshoreColl(i).capWTG = capCumulWTG(iWTGmarg(i));
        o.offshoreColl(i).nString = ceil(nCumStr(iWTGmarg(i)));
        
    else
        
        %calculate subsequent OSS export capacities%
        o.offshoreColl(i).capWTG = capCumulWTG(iWTGmarg(i)) - capCumulWTG(iWTGmarg(i-1));
        o.offshoreColl(i).nString = ceil(nCumStr(iWTGmarg(i)) - nCumStr(iWTGmarg(i-1)));
        
    end
    
    if rem(o.OWF.nColl, o.OWF.nZones) == 0
        
        %determine in which zone OSS is located%
        iZone = ceil(i*o.OWF.nZones/o.OWF.nColl);
        
        %replicate zone properties for OSS%
        o.offshoreColl(i).dPortCon = o.zone(iZone).dPortCon;
        o.offshoreColl(i).dWater = o.zone(iZone).dWater;
        
    else
        
        %vector of zones to perform property averaging%
        iZone = round(linspace(1,o.OWF.nZones,o.OWF.nColl+1));
        
        %initialise zonal properties%
        o.offshoreColl(i).dPortCon = 0;
        o.offshoreColl(i).dWater = 0;
        
        for j = iZone(i) : iZone(i+1)
            
            %sum properties for zones covered by each OHVSS%
            o.offshoreColl(i).dPortCon = o.offshoreSS(i).dPortCon + o.zone(j).dPortCon;
            o.offshoreColl(i).dWater = o.offshoreSS(i).dWater + o.zone(j).dWater;
            
        end
        
        %determine average properties per OSS%
        o.offshoreColl(i).dPortCon = o.offshoreSS(i).dPortCon / (1 + iZone(i+1)-iZone(i));
        o.offshoreColl(i).dWater = o.offshoreSS(i).dWater / (1 + iZone(i+1)-iZone(i));
        
    end
        
    %determine length of interconnector cables%
    o.offshoreColl(i).lInterConnect = sqrt(areaOWF/(pi*o.OWF.nColl))*(1+data.HVDC.fRoute) + 2*o.offshoreColl(i).dWater + 2*data.HVDC.lInt;

end