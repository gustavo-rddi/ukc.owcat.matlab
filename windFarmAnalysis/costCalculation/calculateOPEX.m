function o = calculateOPEX(o, data, stocVar, markMods)
    
%determine mean distances from port%
dPortMean = mean([o.WTG.dPortOM]);

%calculate OWF operation costs%
o.OPEX.real.operation = calculateOperationCosts(o, data, o.OWF.cap, o.OWF.nWTG, stocVar, markMods);

% 
% %calculate WTG maintenance costs%
o.OPEX.real.turbMaint = calculateWTGmaintCosts(o, data, o.OWF.cap, o.OWF.nWTG, dPortMean, stocVar, markMods);
%     
% %calculate BOP maintenance costs%
o.OPEX.real.BOPmaint = calculateBOPOMcosts(o, data, o.OWF.nWTG, stocVar, markMods);

% FCOW 2019 OpEx correlation in calculateOperationCosts is based on EDf-R simulations
% which exclude OFTO assets. Hence FCOW 2017 logic for OFTO OpEx is to kept as before 

%calculate export system maintenance costs%
o.OPEX.real.SSmaint = calculateSubstationOMcosts(o, data, o.OWF.nOSS, stocVar, markMods);
o.OPEX.real.expMaint = calculateExportOMcosts(o, data, o.OWF.nExportCable, stocVar, markMods);
    
o.OPEX.real.gridConnection = gridConnectionCharges(o, data, stocVar, markMods);