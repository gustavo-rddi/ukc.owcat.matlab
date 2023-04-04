function cCharter = vesselCharterCost(o, data, hCharter, vType, vEquip, stocVar, markMods) 

%calculate vessel mobilisation cost%
cCharter = hCharter * data.vessel.(vType).dayRate;

%add additional equipment costs%
for i = 1 : length(vEquip)
    cCharter = cCharter + hCharter * data.equip.(vEquip{i});
end

%add vessel tug costs%
if isfield(data.vessel.(vType), 'Ntug')
   cCharter = cCharter + vesselCharterCost(o, data, hCharter, 'AHT', [], markMods, stocVar) * data.vessel.(vType).Ntug;
end

%apply CPI inflation modifier and currency conversion%
cCharter = cCharter * costScalingFactor(o, data, data.vessel.yrRef, data.vessel.curr);
                
%apply any stochastic and market modifiers to vessel cost%
cCharter = cCharter * scenarioModifier('vessels.cost', stocVar, markMods);