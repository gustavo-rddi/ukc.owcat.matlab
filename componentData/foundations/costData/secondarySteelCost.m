function Css = secondarySteelCost(o, data, objType, nSupply, stocVar, markMods)

%FCOW21 mid case cost for lower_C%
switch objType
        
        case 'MP'
            
            Css = 750000;
            
        case 'sJKT'
            
            Css = 195000;
        
        case 'hJKT'
            
            Css = 195000;
                 
end

%calculate cost correction factor%
fCorr = (1 - data.fnd.fManSS) * scenarioModifier('steel.cost', stocVar, markMods) ...
        + data.fnd.fManSS * scenarioModifier('labour.cost', stocVar, markMods);

%sum of secondary costs%
Css = Css * fCorr;

%apply CPI inflation modifier and currency conversion%
Css = Css * costScalingFactor(o, data, 2021, 'EUR');