function o = calculateHVDCgridSubstationCosts(o, data, stocVar, markMods)

cConv = 1054131 * (o.OWF.cap/1e6)^0.6733 * costScalingFactor(o, data, 2012, 'GBP') * scenarioModifier('HVDC.cost', stocVar, markMods);

%calculate cost of onshore transformer (adj. to ref. year)%
cTrans = transformerCost(o, data, o.gridSS.capTrans, data.HVAC.VgridCon, 'onshore', stocVar, markMods);

%calculate switchgear and cable auxiliaries costs (adj. to ref. year)%
cGridSwitch = AIScost(o, data, data.HVAC.VgridCon, stocVar, markMods) * o.gridSS.nUHVswitch;

%calculate total cost of onshore substation equipment%
CequipSS = cTrans*o.gridSS.nTrans + cGridSwitch;

%calculate cost of civil engineering works (adj. to ref. year)%
CcivilSS = substationCivilWorksCost(o, data, o.gridSS.capTrans*o.gridSS.nTrans, stocVar, markMods);

%add costs to current phase%
o.CAPEX.real.onshoreSupply = o.CAPEX.real.onshoreSupply + CequipSS + CcivilSS + cConv;