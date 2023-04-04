function fMult = SImultiplier(unit)

switch lower(unit)
    
    case {'km', 'kv', 't'}; fMult = 1e3;
    
    case 'mw'; fMult = 1e6;
        
    case '%'; fMult = 1 / 1e2;
     
    case 'h'; fMult = 3600;
        
    case 'kn'; fMult = 1.852 / 3.6;
    
    case 'day'; fMult = 3600 * 24;    
      
    case 'yr'; fMult = 365 * 3600 * 24;       
        
    case 'm/h'; fMult = 1 / 3600;
        
    case 't/h'; fMult = 1e3 / 3600;
    
    case {strcat(char(8364),'/t'), '£/t', '¤/t'}; fMult = 1 / 1e3;    
    
    case {strcat(char(8364),'/mw'), '£/mw', '¤/mw'}; fMult = 1 / 1e6;
        
    case {strcat(char(8364),'/kw'), '£/kw', '¤/kw'}; fMult = 1 / 1e3;        
        
    case {strcat(char(8364),'/mwh'), '£/mwh', '¤/mwh'}; fMult = 1 / (3600 * 1e6);
        
    case {strcat(char(8364),'/day'), '£/day', '¤/day'}; fMult = 1 / (3600*24);
      
    case {'-', 'm', 'm/s', 'kg/m3'}
        
        fMult = 1;
        
    otherwise

        error('SImultiplier: unrecognised unit [%s] for conversion', unit);
        
end