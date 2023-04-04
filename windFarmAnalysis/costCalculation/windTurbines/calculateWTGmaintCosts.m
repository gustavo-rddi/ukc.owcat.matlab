function cTurb = calculateWTGmaintCosts(o, data, capOWF, nWTG, dPortMean, stocVar, markMods)

%cost of inspection, painting and greasing activities%
cFirstLine = (7.13e6 + 3.57e6*(dPortMean/80e3)*scenarioModifier('vessels.cost', stocVar, markMods)).*(nWTG/138).^(log(1.93)/log(2));

%cost of manual resets of turbine components%
cManResets = 1.5e6*(dPortMean/80e3).*(nWTG/138).^(log(1.93)/log(2)) * scenarioModifier('vessels.cost', stocVar, markMods);           
         
%calculate cost of small-scale repairs to WTG components%
cSecondLine = (0.48e6 + 1.92e6*(dPortMean/80e3) * scenarioModifier('vessels.cost', stocVar, markMods)).*(nWTG/138).^(log(1.87)/log(2));

%calculate cost of large-scale repairs to WTG components%
cThirdLine = (9e6*(capOWF/500e6).^(log(1.94)/log(2)) + 6e6*(nWTG/138).^(log(1.93)/log(2)) * scenarioModifier('vessels.cost', stocVar, markMods));
       
%sum O&M costs%
cTurb = cFirstLine * scenarioModifier('OM.turbInsp', stocVar, markMods) ... 
      + cManResets * scenarioModifier('OM.turbInsp', stocVar, markMods) ... 
      + cSecondLine * scenarioModifier('OM.turbMaint', stocVar, markMods) ... 
      + cThirdLine * scenarioModifier('OM.turbMaint', stocVar, markMods);
        
%apply CPI inflation modifier%
cTurb = cTurb * costScalingFactor(o, data, 2009, 'GBP');%2009 originally

