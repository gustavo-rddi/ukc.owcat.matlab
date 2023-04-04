function cDev = developmentCosts(o, data, capOWF, nPos, stocVar, markMods)

%Consenting costs: environmental studies and impact on fisheries
cConsent = 6.32e6 * (capOWF/450e6)^0.5 * scenarioModifier('dev.staff', stocVar, markMods);

%Design of WTG, foundations, cables and OSS
cDesign = 11.3e6 * (nPos/75)^0.5;

%Wind assessment studies
cWind = 2e6;

%Local electricity grid access
cElec = 6.174e6 * (capOWF/450e6)^0.5;


%Geotechnical studies odepending on whether soil is simple or complex
if mean([o.WTG.pDrill]) == 1
    cGeo = 20.94e6 * (nPos/75)^0.5 * scenarioModifier('dev.geo', stocVar, markMods);
else
    cGeo = 7e6 * (nPos/46)^0.5 * scenarioModifier('dev.geo', stocVar, markMods);
end

%Staff costs. Daily rate depends where staff is geographically located
dEarlyPhase = 7; %years before permit approval
dafterPermit = 2; %years after permit approval for engineering design and procurement
dtoFiD = 3; %years before FiD

rdaily = 850 ; %€

nEarlyPhase = 10; %number staff before permit approval
nafterPermit = 35; %number staff for engineering design and procurement
ntoFiD = 55; %number staff before FiD

cStaff = rdaily*220*(dEarlyPhase*nEarlyPhase + dafterPermit*nafterPermit + dtoFiD*ntoFiD) * (capOWF/450e6)^0.5 * scenarioModifier('dev.staff', stocVar, markMods);


cDev = cConsent + cDesign + cWind + cElec + cGeo + cStaff;

if strcmpi(o.finance.type, 'project')
    %Project finance added costs, €2m before and €2m after financial close
    cDev = cDev + 4e6 * (capOWF/450e6)^0.5;
    
end

cDev = cDev * costScalingFactor(o, data, 2021, 'EUR');