function o = calculateOPEX(o, data, stocVar, markMods)
    
%determine mean distances from port%
dPortMean = mean([o.WTG.dPortOM]);
% 
% %calculate OWF operation costs%
% o.OPEX.real.operation = calculateOperationCosts(o, data, o.OWF.cap, o.OWF.nWTG, stocVar, markMods);
% 
% % 
% % %calculate WTG maintenance costs% FIX WITH MANUAL
% o.OPEX.real.turbMaint = calculateWTGmaintCosts(o, data, o.OWF.cap, o.OWF.nWTG, dPortMean, stocVar, markMods);
% %     
% % %calculate BOP maintenance costs%
% o.OPEX.real.BOPmaint = calculateBOPOMcosts(o, data, o.OWF.nWTG, stocVar, markMods);
% 
% % FCOW 2019 OpEx correlation in calculateOperationCosts is based on EDf-R simulations
% % which exclude OFTO assets. Hence FCOW 2017 logic for OFTO OpEx is to kept as before 
% 
% %calculate export system maintenance costs%
% o.OPEX.real.SSmaint = calculateSubstationOMcosts(o, data, o.OWF.nOSS, stocVar, markMods);
% o.OPEX.real.expMaint = calculateExportOMcosts(o, data, o.OWF.nExportCable, stocVar, markMods);
%     
% o.OPEX.real.gridConnection = gridConnectionCharges(o, data, stocVar, markMods);

%FCOW 2021 Fix%

%convert annual cost to euros%
% switch lower(o.WTG(1).fndType)
%     case {'monopile','jacket'}
%         
%         %msgbox('I am calculating OPEX for bottom-fixed WFs!');
%         %OPEX for bottom-fixed wind farms using correlations based on FCOW2021 EDF R OPEX data%
%         cOperation = 1000000 + 999995.119177722 *(o.OWF.nWTG^0.650010242844826)*((dPortMean*0.001)^0.200139596872224);
%         
%         %%apply any stochastic and market modifiers to WTG cost%
%         cOperation = cOperation * scenarioModifier('OM.turbInsp', stocVar, markMods);
%         
%         o.OPEX.real.operation = cOperation * costScalingFactor(o, data, 2021, 'EUR');
%             
%     otherwise
%         
%         %msgbox('I am calculating OPEX for floating WFs!');
%         %OPEX for floating wind farms using correlations based on FCOW2021 EDF R OPEX data%
%         o.OPEX.real.operation = (0.35/0.63)*(o.CAPEX.real.development + o.CAPEX.real.turbSupply + o.CAPEX.real.arraySupply + o.CAPEX.real.fndSupply + o.CAPEX.real.turbInstall + o.CAPEX.real.fndInstall + o.CAPEX.real.arrayInstall + o.CAPEX.real.portFacilities + o.CAPEX.real.substationSupply + o.CAPEX.real.substationInstall + o.CAPEX.real.exportSupply + o.CAPEX.real.onshoreSupply + o.CAPEX.real.exportInstall + o.CAPEX.real.onshoreInstall + o.CAPEX.real.projManagement + o.CAPEX.real.conInsurance);
%         o.OPEX.real.operation = o.OPEX.real.operation * costScalingFactor(o, data, 2021, 'EUR');
%             
% end

%calculate OpEx based on EDF-R data, applicable to bottom-fixed and floating%
cOperation = 1000000 + 999995.119177722 *(o.OWF.nWTG^0.650010242844826)*((dPortMean*0.001)^0.200139596872224);

%%apply any stochastic and market modifiers to WTG cost%
cOperation = cOperation * scenarioModifier('OM.turbInsp', stocVar, markMods);

o.OPEX.real.operation = cOperation * costScalingFactor(o, data, 2021, 'EUR');
        
%calculate WTG maintenance costs% FIX WITH MANUAL
o.OPEX.real.turbMaint = 0;
%     
% %calculate BOP maintenance costs%
o.OPEX.real.BOPmaint = 0;

% FCOW 2019 OpEx correlation in calculateOperationCosts is based on EDf-R simulations
% which exclude OFTO assets. Hence FCOW 2017 logic for OFTO OpEx is to kept as before 

%calculate export system maintenance costs%
o.OPEX.real.SSmaint = 0;
o.OPEX.real.expMaint = 0;
    
o.OPEX.real.gridConnection = 0;