function CF = generateCashFlow(o, data, totalAmount, projStage, modField, stocVar, markMods)

CF = zeros(1, 8 + o.OWF.nComm + data.WTG.nOper);

switch lower(projStage)
    
    case 'dev'
        
        CF(1:4) = totalAmount/4;
        
    case {'cononshore', 'atfid'}
        
        CF(5) = totalAmount;
        
    case 'conexport';
        
        CF(6) = totalAmount;
        
    case 'conbop'
        
        CF(5+(1:o.OWF.nComm)) = totalAmount/o.OWF.nComm;
        
    case 'conturb'
        
        CF(6+(1:o.OWF.nComm)) = totalAmount/o.OWF.nComm;
        
    case 'conall'
        
        CF(4+(1:(2+o.OWF.nComm))) = totalAmount/(2+o.OWF.nComm);
    
    case 'oper'
        
        CF(6+o.OWF.nComm+(1:data.WTG.nOper)) = totalAmount;
        
    case 'decomturb'
        
        CF(6+o.OWF.nComm+data.WTG.nOper+1) = totalAmount;    
    
   case 'decombop'
        
        CF(6+o.OWF.nComm+data.WTG.nOper+2) = totalAmount; 
        
end 

if nargin > 4

    CF = CF .* scenarioModifier(modField, stocVar, markMods);
    
end