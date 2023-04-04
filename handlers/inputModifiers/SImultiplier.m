function fMult = SImultiplier(unit)

switch lower(unit)
    
    case {'km', 'kv', 't'}; fMult = 1e3;
    
    case 'mw'; fMult = 1e6;
        
    case '%'; fMult = 1 / 1e2;
     
    case 'h'; fMult = 3600;
        
    case 'kn'; fMult = 1.852 / 3.6;
    
    case 'day'; fMult = 3600 * 24;    
      
    case 'yr'; fMult = 365 * 3600 * 24;
        
    case 'pmonth'; fMult = 20 * 8 * 3600;    %20 working days per month, 8 hour shift
        
    case 'm/h'; fMult = 1 / 3600;
        
    case 't/h'; fMult = 1e3 / 3600;
    
    case {'€/t', '£/t', '¤/t'}; fMult = 1 / 1e3;    
    
    case {'€/mw', '£/mw', '¤/mw'}; fMult = 1 / 1e6;
        
    case {'€/kw', '£/kw', '¤/kw'}; fMult = 1 / 1e3;  
        
    case {'€/kn', '£/kn', '¤/kn'}; fMult = 1 / 1e3;
        
    case {'€/mwh', '£/mwh', '¤/mwh'}; fMult = 1 / (3600 * 1e6);
        
    case {'€/day', '£/day', '¤/day'}; fMult = 1 / (3600*24);
      
    case {'-', 'm', 'm/s', 'kg/m3', '€/m', 'n', '€', '£', '¤' , '¤/m2'}
        
        fMult = 1;
        
    otherwise
        
        error('SImultiplier: unrecognised unit [%s] for conversion', unit);
        
end