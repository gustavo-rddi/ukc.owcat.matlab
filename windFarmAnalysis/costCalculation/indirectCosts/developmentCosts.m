function cDev = developmentCosts(o, data, capOWF, nPos, stocVar, markMods)

cConsent = 6.32e6 * (capOWF/450e6)^0.5 * scenarioModifier('dev.staff', stocVar, markMods);

cDesign = 11.3e6 * (nPos/75)^0.5;

cWind = 2e6;

cElec = 6.174e6 * (capOWF/450e6)^0.5;

cGeo = 20.94e6 * (nPos/75)^0.5 * scenarioModifier('dev.geo', stocVar, markMods);

cStaff = 23.53e6 * (capOWF/450e6)^0.5 * scenarioModifier('dev.staff', stocVar, markMods);

cDev = cConsent + cDesign + cWind + cElec + cGeo + cStaff;

if strcmpi(o.finance.type, 'project')
    
    cDev = cDev + 2.75e6 * (capOWF/450e6)^0.5;
    
end

cDev = cDev * costScalingFactor(o, data, 2015, 'EUR');