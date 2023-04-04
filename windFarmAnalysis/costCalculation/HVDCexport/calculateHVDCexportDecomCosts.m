function o = calculateHVDCexportDecomCosts(o, data, stocVar, markMods)
    
%determine the number of PPs to be installed%
nPPinstall = getProcurementRequirement(o, data, 'fndComp', 'pinpile');

%determine PP installation vessel charter duration%
[~, ~, CinstPP_SS] = vesselCharterModel(o, data, o.offshoreSS, 'decom', 'PP', nPPinstall, stocVar, markMods);
[~, ~, CinstPP_Conv] = vesselCharterModel(o, data, o.offshoreConv, 'decom', 'PP', nPPinstall, stocVar, markMods);

%determine the number of heavy SS jackets to be installed%
nJKTinstall = getProcurementRequirement(o, data, 'fndComp', 'hvyJacket');
    
%determine SS foundation installation vessel charter duration%
[~, ~, CinstJKT_SS] = vesselCharterModel(o, data, o.offshoreSS, 'decom', 'hJKT', nJKTinstall, stocVar, markMods);
[~, ~, CinstJKT_Conv] = vesselCharterModel(o, data, o.offshoreConv, 'decom', 'hJKT', nJKTinstall, stocVar, markMods);
  
%determine JKT installation vessel charter duration%
[~, ~, CinstSS] = vesselCharterModel(o, data, o.offshoreSS, 'decom', 'OHVS', o.OWF.nOSS, stocVar, markMods);

[~, ~, CinstConv] = vesselCharterModel(o, data, o.offshoreConv, 'decom', 'VSC', o.OWF.nConv, stocVar, markMods);

o.DECEX.real.substationDecom = o.DECEX.real.substationDecom + CinstPP_SS + CinstJKT_SS + CinstSS + CinstPP_Conv + CinstJKT_Conv + CinstConv;

for i = 1 : numel(o.vessels.SSinst.type)
    
    %add vessel mobilisation costs to installation total%
    o.DECEX.real.substationDecom = o.DECEX.real.substationDecom + vesselMobilisationCost(o, data, o.vessels.SSinst.type{i}, stocVar, markMods) * o.vessels.SSinst.nVesMob(i);
    
end