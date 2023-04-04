function Cfnd = semiSubProcurementCost(o, data, obj, nSSsupply, stocVar, markMods)

%calculate monopile and transition piece primary steel costs%
Cps = primarySteelCost(o, data, obj.mSS, 'semi', nSSsupply, stocVar, markMods);

% %calculate secondary steel costs (ladders, J-tubes, etc.)%
% Css = secondarySteelCost(o, data, nSSsupply, stocVar, markMods);
% 
% %calculate corrosion protection costs (coatings and cathodic protection)%
% Cprot = corrosionProtectionCost(o, data, stocVar, markMods);
% 
% %calculate foundation fittings costs (cranes, electrical system, etc.)%
% Cfit = foundationFittingsCost(o, data, stocVar, markMods);
% 
% %calculate jacket load-out costs%
% Cload = jacketLoadOutCost(o, data, stocVar, markMods);

%calculate final per-unit foundation costs%
% Cfnd = Cps + Css + Cprot + Cfit + Cload;
Cfnd = Cps;