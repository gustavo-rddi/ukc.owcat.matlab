function cExp = calculateExportOMcosts(o, data, nCable, stocVar, markMods)

%cost of balance of plant inspections (Navitus)%
cExp = 60e3 + 125e3 * scenarioModifier('OM.BOPplan', stocVar, markMods);
        
%apply CPI inflation modifier%
cExp = cExp * costScalingFactor(o, data, 2013, 'GBP'); 
   