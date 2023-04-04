function Cfit = foundationFittingsCost(o, data, objType, stocVar, markMods)

%FCOW21 cost%
switch objType
        
        case 'MP'
            
            Cfit = 900000;
            
        case 'sJKT'
            
            Cfit = 443000;
        
        case 'hJKT'
            
            Cfit = 443000;
                 
end

%calculate cost correction factor%
fCorr = (1 - data.fnd.fManSS) * scenarioModifier('steel.cost', stocVar, markMods) ...
        + data.fnd.fManSS * scenarioModifier('labour.cost', stocVar, markMods);

%sum of secondary costs%
Cfit = Cfit * fCorr;

%apply CPI inflation modifier and currency conversion%
Cfit = Cfit * costScalingFactor(o, data, 2021, 'EUR');
