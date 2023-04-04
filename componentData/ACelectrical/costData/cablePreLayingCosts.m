function Cprelay = cablePreLayingCosts(o, data, lCable, stocVar, markMods)

%survey costs [GBP]%
Csurvey = 5.8*lCable;

%pre-lay grapnel run [GBP]%
Cgrapnel = 3.9*lCable;

%sum pre-laying costs%
Cprelay = Csurvey + Cgrapnel;

%apply CPI inflation modifier and currency conversion%
Cprelay = Cprelay * costScalingFactor(o, data, 2019, 'GBP');

%apply any stochastic and market modifiers to vessel cost%
Cprelay = Cprelay * scenarioModifier('vessels.cost', stocVar, markMods);
