function o = calculateHVDCoffshoreInstallCosts(o, data, stocVar, markMods)

 o.CAPEX.real.exportInstall_conv=0;


%determine the number of PPs to be installed%
nPPinstall = getProcurementRequirement(o, data, 'fndComp', 'pinpile');

%determine PP installation vessel charter duration%
[~, ~, CinstPP_SS] = vesselCharterModel(o, data, o.offshoreSS, 'install', 'PP', nPPinstall, stocVar, markMods);
[~, ~, CinstPP_Conv] = vesselCharterModel(o, data, o.offshoreConv, 'install', 'PP', nPPinstall, stocVar, markMods);

%determine the number of heavy SS jackets to be installed%
nJKTinstall = getProcurementRequirement(o, data, 'fndComp', 'hvyJacket');
    
%determine SS foundation installation vessel charter duration%
[~, ~, CinstJKT_SS] = vesselCharterModel(o, data, o.offshoreSS, 'install', 'hJKT', nJKTinstall, stocVar, markMods);
[~, ~, CinstJKT_Conv] = vesselCharterModel(o, data, o.offshoreConv, 'install', 'hJKT', nJKTinstall, stocVar, markMods);
  
%determine JKT installation vessel charter duration%
[~, ~, CinstSS] = vesselCharterModel(o, data, o.offshoreSS, 'install', 'OHVS', o.OWF.nOSS, stocVar, markMods);

[~, ~, CinstConv] = vesselCharterModel(o, data, o.offshoreConv, 'install', 'VSC', o.OWF.nConv, stocVar, markMods);
    
%determine SP installation vessel charter duration%
[~, CinstSP] = scourProtectionInstall(o, data, o.offshoreSS, 'hJKT', stocVar, markMods);

o.CAPEX.real.substationInstall = o.CAPEX.real.substationInstall + CinstPP_SS + CinstJKT_SS + CinstSS + CinstSP;
o.CAPEX.real.exportInstall = o.CAPEX.real.exportInstall + CinstPP_Conv + CinstJKT_Conv + CinstConv + CinstSP;
o.CAPEX.real.exportInstall_conv=o.CAPEX.real.exportInstall_conv+ CinstPP_Conv + CinstJKT_Conv + CinstConv + CinstSP;
for i = 1 : numel(o.vessels.SSinst.type)
    
    %add vessel mobilisation costs to installation total%
    o.CAPEX.real.substationInstall = o.CAPEX.real.substationInstall + vesselMobilisationCost(o, data, o.vessels.SSinst.type{i}, stocVar, markMods) * o.vessels.SSinst.nVesMob(i);
    
end
