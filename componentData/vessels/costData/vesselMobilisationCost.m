function cMob = vesselMobilisationCost(o, data, vType, stocVar, markMods) 

%calculate vessel mobilisation cost%
cMob = data.vessel.(vType).nMob * data.vessel.(vType).dayRate;

%apply CPI inflation modifier and currency conversion%
cMob = cMob * costScalingFactor(o, data, data.vessel.yrRef, data.vessel.curr);
                
%apply any stochastic and market modifiers to vessel cost%
cMob = cMob * scenarioModifier('vessels.cost', stocVar, markMods);