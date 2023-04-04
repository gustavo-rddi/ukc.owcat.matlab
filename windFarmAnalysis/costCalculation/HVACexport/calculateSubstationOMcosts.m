function cSS = calculateSubstationOMcosts(o, data, nOSS, stocVar, markMods)

%cost of balance of plant inspections%
cSS = 125e3 * nOSS^0.65  * scenarioModifier('OM.BOPplan', stocVar, markMods);  
        
%apply CPI inflation modifier%
cSS = cSS * costScalingFactor(o, data, 2013, 'GBP');   