function cOperation = calculateOperationCosts(o, data, capOWF, nWTG, stocVar, markMods)

% %wind farm project management costs%
 cProjManagement = 1.5e6 * (capOWF/500e6).^(log(1.5)/log(2)) * scenarioModifier('OM.turbInsp', stocVar, markMods);
% 
% %wind farm asset management team costs%
 cAssetManagement = 2.1e6 * (capOWF/500e6).^(log(1.5671)/log(2)) * scenarioModifier('OM.turbInsp', stocVar, markMods);
% 
% %onshore office, port and training facilities%
 cOnshoreFacilities = 0.2e6 * (capOWF/500e6).^(log(1.5)/log(2)) ...
                    + 0.5e6 * (nWTG/138).^(log(1.5)/log(2)) ...
                    + 0.5e6;

 cOnshoreFacilities = cOnshoreFacilities * scenarioModifier('OM.turbMaint', stocVar, markMods);
%                
% %ongoing environmental monitoring%
 cEnvMonitoring = 0.6e6 * (nWTG/138).^(log(1.75)/log(2));
% 
% %HSE monitoring%
 cHealthSafety = 0.5e6 * (nWTG/138);
% 
% %contribution to offshore emergency services%
 cEmergency = 0.5e6 * (nWTG/138).^(log(1.5)/log(2));

if o.OWF.loc=='UK' 
    cCommunityFees = 2000*capOWF*1e-6; % £2000/mw
else
    cCommunityFees=0; 
end
%sum operation costs%
cOperation = cProjManagement ...
           + cAssetManagement ...
           + cOnshoreFacilities ...
           + cEnvMonitoring ...
           + cHealthSafety ...
           + cEmergency + cCommunityFees;

dPortMean = mean([o.WTG.dPortOM]);

cOperation = 1000000 + 190965 *(nWTG^1.1)*((dPortMean*0.001)^0.06883);

%apply CPI inflation modifier%
cOperation = cOperation * costScalingFactor(o, data, 2019, 'EUR');

%apply any stochastic and market modifiers to WTG cost%
cOperation = cOperation * scenarioModifier('OM.operation', stocVar, markMods);