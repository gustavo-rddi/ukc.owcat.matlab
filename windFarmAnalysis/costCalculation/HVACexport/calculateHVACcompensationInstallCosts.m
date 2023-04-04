function o = calculateHVACcompensationInstallCosts(o, data, stocVar, markMods)
    
    %determine the number of heavy SS jackets to be installed%
    nJKTinstall = getProcurementRequirement(o, data, 'fndComp', 'hvyJacket');
    
    %determine SS foundation installation vessel charter duration%
    [~, ~, CinstJKT] = vesselCharterModel(o, data, o.offshoreCP, 'install', 'hJKT', nJKTinstall, stocVar, markMods);
    
    %determine JKT installation vessel charter duration%
    [~, ~, CinstCP] = vesselCharterModel(o, data, o.offshoreCP, 'install', 'OHVS', o.OWF.nOSS+o.design.osComp, stocVar, markMods);
    
    %determine SP installation vessel charter duration%
    [~, CinstSP] = scourProtectionInstall(o, data, o.offshoreCP, 'hJKT', stocVar, markMods);
    
o.CAPEX.real.exportInstall = o.CAPEX.real.exportInstall + CinstJKT + CinstCP + CinstSP;