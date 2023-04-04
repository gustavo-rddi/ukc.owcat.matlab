function cGrid = gridConnectionCharges(o, data, ~, ~)

switch upper(o.OWF.loc)
    
    case 'UK'

        %get average BSUoS charge%
        cBSUoS = getBSUoScharge(o, data);
        
        %get regional TNUoS charge%
        cTNUoS = getTNUoScharge(o, data, o.OWF.zTNUoS, o.OWF.fCap);
        
        %determine TNUoS and BSUoS connection charges%
        cGrid = cTNUoS.*o.OWF.cap + cBSUoS*o.OWF.AEPnet;
        
    case 'FR'
        
        CG = 7782.30;
        
        CC = 483.07*o.OWF.nOSS;
        
        CI = 0.19*o.OWF.AEPnet/3.6e9;
   
        CACS = 92982.29;
        
        cGrid = CG + CC + CI + CACS;
        
        cGrid = cGrid * costScalingFactor(o, data, 2014, 'EUR');
        
end