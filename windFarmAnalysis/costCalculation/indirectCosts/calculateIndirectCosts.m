function o = calculateIndirectCosts(o, data, stocVar, markMods)
    
o.CAPEX.real.development = developmentCosts(o, data, o.OWF.cap, o.OWF.nWTG + o.OWF.nOSS + o.design.osComp, stocVar, markMods);

o.CAPEX.real.projManagement = projectManagementCosts(o, data, o.OWF.cap, o.OWF.nWTG + o.OWF.nOSS + o.design.osComp, stocVar, markMods);

% o.CAPEX.real.portFacilities = harbourUpgradeCosts(o, data, o.OWF.nWTG, stocVar, markMods);
o.CAPEX.real.portFacilities = 0;