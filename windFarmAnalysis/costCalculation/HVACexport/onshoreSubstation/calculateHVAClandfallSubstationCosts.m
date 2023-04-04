function o = calculateHVAClandfallSubstationCosts(o, data, stocVar, markMods)

%calculate shunt reactor costs (including inflation and stochastics)%
cComp = shuntReactorCost(o, data, o.landfallSS.capComp, o.design.Vexport, 'onshore', stocVar, markMods);

%calculate switchgear and cable auxiliaries costs (including inflation and stochastics)%
cSwitch = GIScost(o, data, o.design.Vexport, 'onshore', stocVar, markMods) * o.landfallSS.nHVswitch;
cXPLEsets = cableSetCost(o, data, o.design.Vexport, 'onshore', stocVar, markMods) * o.landfallSS.nExportCable;

%calculate total equipment costs%
CequipSS = cComp + cSwitch + cXPLEsets;

%calculate cost of civil engineering works (adj. to ref. year)%
CcivilSS = substationCivilWorksCost(o, data, o.landfallSS.capComp*2/3, stocVar, markMods);

%add costs to current phase%
o.CAPEX.real.onshoreSupply = o.CAPEX.real.onshoreSupply + CequipSS + CcivilSS;