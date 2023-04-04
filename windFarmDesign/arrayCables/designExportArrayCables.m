function o = designExportArrayCables(o, data)

o.OWF.nOSS = 0;

o.design.Vexport = o.design.Varray;

%conductor material%
switch lower(o.design.arrCond)
    
    case {'cu', 'copper'}
        
        %calculate rated current of copper cable sections%
        AsectSB = data.array.Asect(data.array.Asect <= data.array.AmaxCu);
        IsectSB = subseaACcableProperties('Irate', AsectSB, 'Cu');
        
    case {'al', 'aluminium'}
        
        %calculate rated current of aluminium cable sections%
        AsectSB = data.array.Asect(data.array.Asect <= data.array.AmaxAl);
        IsectSB = subseaACcableProperties('Irate', AsectSB, 'Al');
        
end

lCableOffshore = mean([o.WTG.dLandfall])*(1 + data.HVAC.fRoute) + mean([o.WTG.dWater]) + data.HVAC.lInt;


%calculate rated current of underground cable sections%
IsectUG = undergroundACcableProperties('Irate', data.HVAC.AsectUG, 'Al');

AcableUG = data.HVAC.AsectUG(find(IsectUG >= max(IsectSB), 1));

[IchargeSBmax, ~, ~, ~, Qlf, Qgrid] = calculateChargingCurrents(o, lCableOffshore, max(AsectSB), o.OWF.lOnshore, AcableUG, 0, 0);

ImaxWTG = sqrt(max(IsectSB)^2 - IchargeSBmax^2);

nMinWTGstring = floor((sqrt(3)*ImaxWTG*o.design.Varray)/(max([o.WTG.cap])));

%calculate required number of strings for this SS%
o.OWF.nString = ceil(o.OWF.nWTG/nMinWTGstring);

%force string pairs for ring layout%
if strcmpi(o.design.arrConf, 'ring')
    o.OWF.nString = 2*ceil(o.OWF.nString/2);
end

%maximum potential WTG positions on string%
nPosMax = ceil(o.OWF.nWTG/o.OWF.nString);

%initialise string current%
IstringCum = zeros(1, o.OWF.nString);

%initialise string design%
Acond = zeros(o.OWF.nString, nPosMax);
iWTGstring = zeros(o.OWF.nString, nPosMax);

%initialise calculation%
iString = 1; iPosWTG = 1;

for i = o.OWF.nWTG : -1 : 1
    
    %determine cumulative current in string at full WTG load%
    IstringCum(iString) = IstringCum(iString) + o.WTG(i).cap/(sqrt(3)*o.design.Varray);
    
    %find smallest possible cable conductor cross-section for cumulative current%
    Acond(iString, iPosWTG) = AsectSB(find(IsectSB >= IstringCum(iString), 1, 'first'));
    
    %store current WTG in string%
    iWTGstring(iString, iPosWTG) = i;
    o.WTG(i).stringCon = iString;
    
    %move to next string%
    iString = iString + 1;
    
    if iString > o.OWF.nString
        
        %WTG added to all strings, move to next position%
        iString = 1; iPosWTG = iPosWTG + 1;
        
    end
    
end

Aonshore = zeros(1, o.OWF.nString);

for i = 1 : o.OWF.nString
    
    %intialise cable design%
    IchargeSBmax = 0; IchargeUGmax = 0;
    
    iEnd = find(Acond(i,:) ~= 0, 1, 'last');
    
    for j = 1 : data.model.maxIter
        
        ImaxSB = sqrt(IstringCum(i)^2 + IchargeSBmax^2);
        ImaxUG = sqrt(IstringCum(i)^2 + IchargeUGmax^2);
        
        %select minimum possible export cable sections%
        AcableSB = data.array.Asect(find(IsectSB >= ImaxSB, 1));
        AcableUG = data.HVAC.AsectUG(find(IsectUG >= ImaxUG, 1));
        
        [IchargeSBmaxNew, IchargeUGmaxNew, ~, ~, Qlf(i), Qgrid(i)] = calculateChargingCurrents(o, lCableOffshore, AcableSB, o.OWF.lOnshore, AcableUG, 0, 0);
        
        %check for change in cable rating and iterate%
        if (IchargeSBmaxNew == IchargeSBmax) && (IchargeUGmaxNew == IchargeUGmax)
            break
        else
            IchargeSBmax = IchargeSBmaxNew;
            IchargeUGmax = IchargeUGmaxNew;
        end
        
    end
    
    Acond(i, iEnd) = AcableSB;
    Aonshore(i) = AcableUG;
    
end

if strcmpi(o.design.arrConf, 'ring')
    
    for i = 1 : o.OWF.nString/2
        
        %force equal cross-sections in ring configuration%
        Aring = max(max(Acond(2*i-1:2*i, :)));
        Acond(2*i-1:2*i, :) = Aring * (Acond(2*i-1:2*i, :) ~= 0);
        
    end
    
end

for i = 1 : o.OWF.nString
    
    %store array configuration%
    o.arrayString(i).type = o.design.arrConf;
    
    %determine number of WTGs in string%
    o.arrayString(i).nWTG = nnz(Acond(i, :));
    o.arrayString(i).iWTGstring = iWTGstring(i, iWTGstring(i, :) ~= 0);
    
    %store cable conductor cross-sections%
    o.arrayString(i).Acond = Acond(i, Acond(i, :) ~= 0);
    
    %get WTG rotor diameters and water depths%
    dRotWTG = [o.WTG(o.arrayString(i).iWTGstring).dRot];
    dWaterWTG = [o.WTG(o.arrayString(i).iWTGstring).dWater];
    
    %get horizontal spacing between WTGs and vertical spacing to seabed%
    dHorzWTG = [o.design.fSpace*(dRotWTG(1:end-1) + dRotWTG(2:end))/2, lCableOffshore];
    dVertWTG = [dWaterWTG(1:end-1) + dWaterWTG(2:end), dWaterWTG(end)];
    
    %store total array cable lengths (including slack and interface lengths)%
    o.arrayString(i).lCableTot = (dHorzWTG + dVertWTG)*(1 + data.array.fSlack) + 2*data.array.lInt;
    o.arrayString(i).lCableSeabed = dHorzWTG*(1 + data.array.fSlack);
    
    o.arrayString(i).Aonshore = Aonshore(i);
    o.arrayString(i).lCableOnshore = o.OWF.lOnshore;
    
end

if strcmpi(o.design.arrConf, 'ring')
    
    for i = 1 : o.OWF.nString
        
        %determine link ID%
        nLink = i - 1 + 2*rem(i,2);
        
        %store linked string ID%
        o.arrayString(i).linkString = nStrCum + nLink;
        
        %determine link conductor cross-section%
        o.arrayString(i).AcondLink = max(o.arrayString(i).Acond);
        
        %find the WTGs to which link connects%
        iWTGlink = [o.arrayString(i).iWTGstring(1), o.arrayString(nStrCum + nLink).iWTGstring(1)];
        
        %calculate spacing for ring link%
        dHorzWTG = sum([o.WTG(iWTGlink).dRot]/2) * o.design.fSpace;
        dVertWTG = sum([o.WTG(iWTGlink).dWater]);
        
        %determine total link cable lengths (including slack and interface lengths)%
        o.arrayString(i).lLinkTot = (dHorzWTG + dVertWTG)*(1 + data.array.fSlack) + 2*data.array.lInt;
        o.arrayString(i).lLinkSeabed = dHorzWTG;
        
    end
    
end

o.OWF.nExportCable = o.OWF.nString;