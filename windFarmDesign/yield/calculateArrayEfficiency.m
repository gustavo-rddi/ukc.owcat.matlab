
function o = calculateArrayEfficiency(o, data, ~, ~)

for i = 1 : o.OWF.nString
    
    %initialise%
    IstringCum = 0;
        
    for j = 1 : o.arrayString(i).nWTG
        
        %identify current WTG%
        iWTG = o.arrayString(i).iWTGstring(j);
        
        %determine active and reactive output of the WTG at all wind speeds%
        activeWTGoutput = o.WTG(iWTG).cap * o.WTG(iWTG).loadCurve;
        reactiveWTGoutput = o.WTG(iWTG).cap * sqrt(1/data.(o.design.expConf).cosPhi^2 - 1);
        
        %determine effective load and power output of the WTG at all wind speeds%
        effWTGload = sqrt(o.WTG(iWTG).loadCurve.^2 + (1/data.(o.design.expConf).cosPhi^2 - 1));
        effWTGoutput = sqrt(activeWTGoutput.^2 + reactiveWTGoutput.^2);
        
        %calculate WTG transformer losses at all wind speeds%
        lossTrans = WTGtransformerLosses(o.WTG(iWTG).cap, o.design.Varray, effWTGload);
        
        %determine cumulative current in array string at all wind speeds%
        IstringCum = IstringCum + effWTGoutput/(sqrt(3)*o.design.Varray);
        
        %deter array cable electrical losses at all wind speeds%
        lossCable = subseaACcableLosses(o.arrayString(i).Acond(j), o.design.Varray, o.design.arrCond, IstringCum) * o.arrayString(i).lCableTot(j);
        
        for k = 1 : length(o.zone(o.WTG(iWTG).zone).vWind)
        
            if j == 1 && k ==1
                
                %initialise once required size is known%
                PstringCum = zeros(size(o.zone(o.WTG(iWTG).zone).vWind));
                lossStringCum = zeros(size(o.zone(o.WTG(iWTG).zone).vWind));
                
                if strcmpi(o.finance.type, 'project')
                
                    %initialise once required size is known%
                    PstringCumP90 = zeros(size(o.zone(o.WTG(iWTG).zone).vWind));
                    lossStringCumP90 = zeros(size(o.zone(o.WTG(iWTG).zone).vWind));
                    
                end
                
            end
            
            %sum cumulative active power production by wind turbines%
            PstringCum(k) = PstringCum(k) + sum(activeWTGoutput.*o.WTG(iWTG).pWind(k,:));
            
            %sum cumulative losses in array string%
            lossStringCum(k) = lossStringCum(k) + sum((lossTrans + lossCable).*o.WTG(iWTG).pWind(k,:));

            if strcmpi(o.finance.type, 'project')
            
                %sum cumulative active power production by wind turbines%
                PstringCumP90(k) = PstringCumP90(k) + sum(activeWTGoutput.*o.WTG(iWTG).pWindP90(k,:));
            
                %sum cumulative losses in array string%
                lossStringCumP90(k) = lossStringCumP90(k) + sum((lossTrans + lossCable).*o.WTG(iWTG).pWindP90(k,:));
                
            end
            
        end
         
    end
    
    %determine overall efficiency of array string%
    o.arrayString(i).effString = 1 - lossStringCum./PstringCum;
    
    o.arrayString(i).effString = o.arrayString(i).effString .* (o.OWF.yrProj >= o.OWF.yrOper-o.OWF.nComm) .* (o.OWF.yrProj - o.OWF.yrOper < o.OWF.nOper);
    
    if strcmpi(o.finance.type, 'project')
       
        %determine overall efficiency of array string%
        o.arrayString(i).effStringP90 = 1 - lossStringCumP90./PstringCumP90;
    
        o.arrayString(i).effStringP90 = o.arrayString(i).effStringP90 .* (o.OWF.yrProj >= o.OWF.yrOper-o.OWF.nComm) .* (o.OWF.yrProj - o.OWF.yrOper < o.OWF.nOper);
        
    end
    
end
