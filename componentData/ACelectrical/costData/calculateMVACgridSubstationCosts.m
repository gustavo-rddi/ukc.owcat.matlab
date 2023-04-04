function o = calculateMVACgridSubstationCosts(o, data, stocVar, markMods)
 
o.CAPEX.real.onshoreSupply_onsubstation=0;
%calculate switchgear and cable auxiliaries costs (adj. to ref. year)%
cExportSwitch = GIScost(o, data, o.design.Vexport, 'onshore', stocVar, markMods) * 2 * o.OWF.nExportCable;
cXPLEsets = cableSetCost(o, data, o.design.Vexport, 'onshore', stocVar, markMods) * 2 * o.OWF.nExportCable;

%calculate total cost of onshore substation equipment%
CequipSS = cExportSwitch + cXPLEsets;

%calculate cost of civil engineering works (adj. to ref. year)%
CcivilSS = substationCivilWorksCost(o, data, o.OWF.cap, stocVar, markMods);

%add costs to current phase%
o.CAPEX.real.onshoreSupply = o.CAPEX.real.onshoreSupply + CequipSS + CcivilSS;
o.CAPEX.real.onshoreSupply_onsubstation = o.CAPEX.real.onshoreSupply_onsubstation + CequipSS + CcivilSS;