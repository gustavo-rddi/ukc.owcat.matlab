function Cfnd = gbfProcurementCost(o, data, obj, nGBFsupply, stocVar, markMods)

%obj.mGBF not implemented yet

%calculate monopile and transition piece primary steel costs%
Cps = primarySteelCost(o, data, obj.mGBF, 'gbf', nGBFsupply, stocVar, markMods);

%calculate secondary steel costs (ladders, J-tubes, etc.)%
Css = secondarySteelCost(o, data, nGBFsupply, stocVar, markMods);

%calculate corrosion protection costs (coatings and cathodic protection)%
Cprot = corrosionProtectionCost(o, data, stocVar, markMods);

%calculate foundation fittings costs (cranes, electrical system, etc.)%
Cfit = foundationFittingsCost(o, data, stocVar, markMods);

%calculate jacket load-out costs%
Cload = gbfLoadOutCost(o, data, stocVar, markMods);

%calculate final per-unit foundation costs%
Cfnd = Cps + Css + Cprot + Cfit + Cload;