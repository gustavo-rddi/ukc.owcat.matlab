function o = designSubstationArrayCables(o, data)

%conductor material%
switch lower(o.design.arrCond)
    
    case {'cu', 'copper'}
        
        %calculate rated current of copper cable sections%
        Asect = data.array.Asect(data.array.Asect <= data.array.AmaxCu);
        Isect = subseaACcableProperties('Irate', Asect, 'Cu');
        
    case {'al', 'aluminium'}
        
        %calculate rated current of aluminium cable sections%
        Asect = data.array.Asect(data.array.Asect <= data.array.AmaxAl);
        Isect = subseaACcableProperties('Irate', Asect, 'Al');
        
end

%determine current limit%
ImaxCable = max(Isect);

%initialise%
nStrCum = 0;

for i = 1 : o.OWF.nOSS

    %get WTG in current array%
    nWTGarray = numel(o.offshoreSS(i).iWTGcon);
    
    %determine the minimum number of WTG per string%
    nMinWTGstring = floor((sqrt(3)*ImaxCable*o.design.Varray)/(max([o.WTG(o.offshoreSS(i).iWTGcon).cap])));
    
    %calculate required number of strings for this SS%
    o.offshoreSS(i).nString = ceil(nWTGarray/nMinWTGstring);
    
    %force string pairs for ring layout%
    if strcmpi(o.design.arrConf, 'ring')
        o.offshoreSS(i).nString = 2*ceil(o.offshoreSS(i).nString/2);
    end
    
    %maximum potential WTG positions on string%
    nPosMax = ceil(nWTGarray/o.offshoreSS(i).nString);
    
    %initialise string current%
    IstringCum = zeros(1, o.offshoreSS(i).nString);
    
    %initialise string design%
    Acond = zeros(o.offshoreSS(i).nString, nPosMax); 
    iWTGstring = zeros(o.offshoreSS(i).nString, nPosMax); 
    
    %initialise calculation%
    iString = 1; iPosWTG = 1;
    
    for j = fliplr(o.offshoreSS(i).iWTGcon)

        %determine cumulative current in string at full WTG load%
        IstringCum(iString) = IstringCum(iString) + o.WTG(j).cap/(sqrt(3)*o.design.Varray);
            
        %find smallest possible cable conductor cross-section for cumulative current%
        Acond(iString, iPosWTG) = Asect(find(Isect >= IstringCum(iString), 1, 'first'));
        
        %store current WTG in string%
        iWTGstring(iString, iPosWTG) = j;
        o.WTG(j).stringCon = nStrCum + iString;
        
        %move to next string%
        iString = iString + 1;
        
        if iString > o.offshoreSS(i).nString
            
            %WTG added to all strings, move to next position%
            iString = 1; iPosWTG = iPosWTG + 1;
        
        end
            
    end
    
    if strcmpi(o.design.arrConf, 'ring')
       
        for k = 1 : o.offshoreSS(i).nString/2
            
            %force equal cross-sections in ring configuration%
            Aring = max(max(Acond(2*k-1:2*k, :)));
            Acond(2*k-1:2*k, :) = Aring * (Acond(2*k-1:2*k, :) ~= 0);
            
        end
        
    end
    
    for n = 1 : o.offshoreSS(i).nString
        
        %store array configuration%
        o.arrayString(nStrCum + n).type = o.design.arrConf;
        
        %determine number of WTGs in string%
        o.arrayString(nStrCum + n).nWTG = nnz(Acond(n, :));
        o.arrayString(nStrCum + n).iWTGstring = iWTGstring(n, iWTGstring(n, :) ~= 0);
        
        %store cable conductor cross-sections%
        o.arrayString(nStrCum + n).Acond = Acond(n, Acond(n, :) ~= 0);
        
        %get WTG rotor diameters and water depths%
        dRotWTG = [o.WTG(o.arrayString(nStrCum + n).iWTGstring).dRot];
        dWaterWTG = [o.WTG(o.arrayString(nStrCum + n).iWTGstring).dWater];
        
        %get horizontal spacing between WTGs and vertical spacing to seabed%
        dHorzWTG = ([dRotWTG(1:end-1) + dRotWTG(2:end), sqrt(2)*dRotWTG(end)]/2) * o.design.fSpace;
        dVertWTG = [dWaterWTG(1:end-1) + dWaterWTG(2:end), dWaterWTG(end) + o.offshoreSS(i).dWater];
        
        if strcmpi(o.design.expConf, 'OTM') && o.OWF.fndShare
        
            if any(o.arrayString(nStrCum + n).iWTGstring == o.offshoreSS(i).iWTGshare)
            
                %no cable required for WTG on the OTM
                dHorzWTG(end) = 0; dVertWTG(end) = 0;
                
            else
                
                %increase spacing to account for OTM position in array%
                dRotWTGonOTM = o.WTG(o.offshoreSS(i).iWTGshare).dRot;
                dHorzWTG(end) = (dRotWTG(end)+dRotWTGonOTM/2) * o.design.fSpace;
            
            end
        
        end
        
        %store total array cable lengths (including slack and interface lengths)%
        o.arrayString(nStrCum + n).lCableTot = (dHorzWTG + dVertWTG)*(1 + data.array.fSlack) + 2*data.array.lInt;
        o.arrayString(nStrCum + n).lCableSeabed = dHorzWTG;
        
        %store SS to which string connects%
        o.arrayString(nStrCum + n).SScon = i;
                
    end
    
    if strcmpi(o.design.arrConf, 'ring')
        
        for n = 1 : o.offshoreSS(i).nString
                  
            %determine link ID%
            nLink = n - 1 + 2*rem(n,2);
            
            %store linked string ID%
            o.arrayString(nStrCum + n).linkString = nStrCum + nLink;
            
            %determine link conductor cross-section%
            o.arrayString(nStrCum + n).AcondLink = max(o.arrayString(nStrCum + n).Acond);
        
            %find the WTGs to which link connects%
            iWTGlink = [o.arrayString(nStrCum + n).iWTGstring(1), o.arrayString(nStrCum + nLink).iWTGstring(1)];
            
            %calculate spacing for ring link%
            dHorzWTG = sum([o.WTG(iWTGlink).dRot]/2) * o.design.fSpace;
            dVertWTG = sum([o.WTG(iWTGlink).dWater]);
            
            %determine total link cable lengths (including slack and interface lengths)%
            o.arrayString(nStrCum + n).lLinkTot = (dHorzWTG + dVertWTG)*(1 + data.array.fSlack) + 2*data.array.lInt;
            o.arrayString(nStrCum + n).lLinkSeabed = dHorzWTG;
            
        end
            
    end
    
    %increment to next SS%
    nStrCum = nStrCum + o.offshoreSS(i).nString;
    
end

%determine total OWF strings%
o.OWF.nString = sum([o.offshoreSS.nString]);