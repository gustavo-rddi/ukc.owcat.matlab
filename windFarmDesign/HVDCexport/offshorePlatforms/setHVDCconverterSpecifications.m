function o = setHVDCconverterSpecifications(o, data)

for i = 1 : o.OWF.nConv
    
    %cumulative capacity of all WTGs%
    capCumulColl = cumsum([o.offshoreColl(:).capWTG]);
        
    %initialise marginal WTG vector%
    if i == 1; iCollMarg = zeros(1, o.OWF.nConv); end
    
    %determine marginal WTG for current OSS%
    iCollMarg(i) = find(capCumulColl >= o.OWF.cap * i/o.OWF.nConv, 1);
    
    if i == 1
        
        %calculate first OSS export capacity%
        o.offshoreConv(i).capWTG = capCumulColl(iCollMarg(i));
        o.offshoreConv(i).nInput = iCollMarg(i);
        
    else
        
        %calculate subsequent OSS export capacities%
        o.offshoreConv(i).capWTG = capCumulColl(iCollMarg(i)) - capCumulColl(iCollMarg(i-1));
        o.offshoreConv(i).nInput = iCollMarg(i) - iCollMarg(i-1);
        
    end
    
    o.offshoreConv(i).nConv = ceil(o.offshoreConv(i).capWTG/data.HVDC.capMaxConv);
    o.offshoreConv(i).capConv = o.offshoreConv(i).capWTG/o.offshoreConv(i).nConv;
        
    o.offshoreConv(i).nHVswitch = o.offshoreConv(i).nInput + o.offshoreConv(i).nConv;
    
    if rem(o.OWF.nColl, o.OWF.nZones) == 0
        
        %determine in which zone OSS is located%
        iZone = ceil(i*o.OWF.nZones/o.OWF.nConv);
        
        %replicate zone properties for OSS%
        o.offshoreConv(i).lOffshore = o.zone(iZone).dOffshore;
        o.offshoreConv(i).dPortCon = o.zone(iZone).dPortCon;
        o.offshoreConv(i).dWater = o.zone(iZone).dWater;
        
    else
        
        %vector of zones to perform property averaging%
        iZone = round(linspace(1,o.OWF.nZones,o.OWF.nColl+1));
        
        %initialise zonal properties%
        o.offshoreConv(i).lOffshore = 0;
        o.offshoreConv(i).dPortCon = 0;
        o.offshoreConv(i).dWater = 0;
        
        for j = iZone(i) : iZone(i+1)
            
            %sum properties for zones covered by each OHVSS%
            o.offshoreConv(i).lOffshore = o.offshoreConv(i).lOffshore + o.zone(j).dOffshore;
            o.offshoreConv(i).dPortCon = o.offshoreConv(i).dPortCon + o.zone(j).dPortCon;
            o.offshoreConv(i).dWater = o.offshoreConv(i).dWater + o.zone(j).dWater;
            
        end
        
        %determine average properties per OSS%
        o.offshoreConv(i).lOffshore = o.offshoreConv(i).lOffshore / (1 + iZone(i+1)-iZone(i));
        o.offshoreConv(i).dPortCon = o.offshoreConv(i).dPortCon / (1 + iZone(i+1)-iZone(i));
        o.offshoreConv(i).dWater = o.offshoreConv(i).dWater / (1 + iZone(i+1)-iZone(i));
        
    end
    
    %calculate total OSS export cable offshore length (snacking and water depth)%
    o.offshoreConv(i).lOffshore = o.offshoreConv(i).lOffshore*(1 + data.HVDC.fRoute) + (o.offshoreConv(i).dWater + data.HVDC.lInt);
    
    %store onshore cable distance%
    o.offshoreConv(i).lOnshore = o.OWF.lOnshore;
    
    o.offshoreConv(i).mTopside = 1.346e-3 * o.offshoreConv(i).capWTG.^1.0894;
    [o.offshoreConv(i).mJKT, o.offshoreConv(i).mPP] = JKTfoundationMass(o.offshoreConv(i).mTopside, o.offshoreConv(i).dWater);
    
        
end