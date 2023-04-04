function Cfnd = monopileProcurementCost(o, data, obj, nSupply, stocVar, markMods)

%calculate monopile and transition piece primary steel costs%
CpsMP = primarySteelCost(o, data, obj.mMP, 'MP', nSupply, stocVar, markMods);
CpsTP = primarySteelCost(o, data, obj.mTP, 'TP', nSupply, stocVar, markMods);

%calculate secondary steel costs (ladders, J-tubes, etc.)%
Css = secondarySteelCost(o, data, 'MP', nSupply, stocVar, markMods);

%calculate corrosion protection costs (coatings and cathodic protection)%
Cprot = corrosionProtectionCost(o, data, stocVar, markMods);

%calculate foundation fittings costs (cranes, electrical system, etc.)%
Cfit = foundationFittingsCost(o, data, 'MP', stocVar, markMods);

%calculate monopile load-out costs%
Cload = monopileLoadOutCost(o, data, stocVar, markMods);

%calculate final per-unit foundation costs%
Cfnd = CpsMP + CpsTP + Css + 0*Cprot + Cfit + Cload;