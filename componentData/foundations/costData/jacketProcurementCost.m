function Cfnd = jacketProcurementCost(o, data, obj, JKTtype, nJKTsupply, nPPsupply, stocVar, markMods)

%calculate monopile and transition piece primary steel costs%
CpsJKT = primarySteelCost(o, data, obj.mJKT, JKTtype, nJKTsupply, stocVar, markMods);
CpsPP = primarySteelCost(o, data, obj.mPP, 'PP', nPPsupply, stocVar, markMods);

%calculate secondary steel costs (ladders, J-tubes, etc.)%
Css = secondarySteelCost(o, data, nJKTsupply, stocVar, markMods);

%calculate corrosion protection costs (coatings and cathodic protection)%
Cprot = corrosionProtectionCost(o, data, stocVar, markMods);

%calculate foundation fittings costs (cranes, electrical system, etc.)%
Cfit = foundationFittingsCost(o, data, stocVar, markMods);

%calculate jacket load-out costs%
Cload = jacketLoadOutCost(o, data, stocVar, markMods);

%calculate final per-unit foundation costs%
Cfnd = CpsJKT + CpsPP + Css + Cprot + Cfit + Cload;