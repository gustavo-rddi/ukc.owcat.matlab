function o = calculateHVACgridSubstationCosts(o, data, stocVar, markMods)
o.CAPEX.real.onshoreSupply_onsubstation=0;
%calculate cost of onshore transformer (adj. to ref. year)%
cTrans = transformerCost(o, data, o.gridSS.capTrans, data.HVAC.VgridCon, 'onshore', stocVar, markMods);
cSVC = SVCcost(o, data, o.gridSS.capSVCtrans, stocVar, markMods);

cComp = 0;

for i = 1 : o.OWF.nOSS
    
    
    %determine number of reactors%
    nComp = o.offshoreSS(i).nExportCable;
    
    %calculate total cost of onshore shunt reactors%
    cComp = cComp + shuntReactorCost(o, data, o.offshoreSS(i).QgridSS/nComp, o.design.Vexport, 'onshore', stocVar, markMods) * nComp;
    
end
            
%calculate switchgear and cable auxiliaries costs (adj. to ref. year)%
cExportSwitch = GIScost(o, data, o.design.Vexport, 'onshore', stocVar, markMods) * o.gridSS.nHVswitch;
cGridSwitch = AIScost(o, data, data.HVAC.VgridCon, stocVar, markMods) * o.gridSS.nUHVswitch;
cXPLEsets = cableSetCost(o, data, o.design.Vexport, 'onshore', stocVar, markMods) * o.gridSS.nExportCable;

%calculate total cost of onshore substation equipment%
CequipSS = (cTrans + cSVC)*o.gridSS.nTrans + cComp + cExportSwitch + cGridSwitch + cXPLEsets;

%calculate cost of civil engineering works (adj. to ref. year)%
CcivilSS = substationCivilWorksCost(o, data, o.gridSS.capTrans*o.gridSS.nTrans, stocVar, markMods);

%add costs to current phase%
o.CAPEX.real.onshoreSupply = o.CAPEX.real.onshoreSupply + CequipSS + CcivilSS;
o.CAPEX.real.onshoreSupply_onsubstation = o.CAPEX.real.onshoreSupply_onsubstation + CequipSS + CcivilSS;