function o = calculateFoundationInstallCosts(o, data, stocVar, markMods)


if any(strcmpi({o.WTG.fndType}, 'oblyth'))
o.CAPEX.real.fndInstall= o.GBF.installation.oblyth;
return;
end
if any(strcmpi({o.WTG.fndType}, 'o500gbf'))
o.CAPEX.real.fndInstall= o.GBF.installation.o500gbf;
return;
end
if any(strcmpi({o.WTG.fndType}, 'o500jkt'))
o.CAPEX.real.fndInstall= o.GBF.installation.o500jkt;
return; 
end


if any(strcmpi({o.WTG.fndType}, 'monopile'))
    
    %determine MP-mounted WTGs%
    iMP = strcmpi({o.WTG.fndType}, 'monopile');
    
    %determine the number of monopiles that are going to be installed%
    nMPinstall = getProcurementRequirement(o, data, 'fndComp', 'monopile');
    
    %determine overhead costs for monopile installation%
    CoverheadMP = monopileInstallOverheadCosts(o, data, nMPinstall, stocVar, markMods);
    
    %determine MP and TP installation vessel charter durations%
    [~, ~, CvesselMP] = vesselCharterModel(o, data, o.WTG(iMP), 'install', 'MP', nMPinstall, stocVar, markMods);
    [~, ~, CvesselTP] = vesselCharterModel(o, data, o.WTG(iMP), 'install', 'TP', nMPinstall, stocVar, markMods);
    
    %determine SP installation vessel charter duration%
    [~, CscourMP] = scourProtectionInstall(o, data, o.WTG(iMP), 'MP', stocVar, markMods);
    
    %add to total foundation installation costs%
    o.CAPEX.real.fndInstall = o.CAPEX.real.fndInstall + CvesselMP + CvesselTP + CscourMP + CoverheadMP;
        
end

if any(strcmpi({o.WTG.fndType}, 'jacket'))
    
    %determine JKT-mounted WTGs%
    iJKT = strcmpi({o.WTG.fndType}, 'jacket');
    
    %determine the number of components that are going to be installed%
    nPPinstall = getProcurementRequirement(o, data, 'fndComp', 'pinpile');
    nJKTinstall = getProcurementRequirement(o, data, 'fndComp', 'wtgJacket');
    
    %determine overhead costs for JKT installation (scaled to remove any OTM contributions)%
    CoverheadJKT = jacketInstallOverheadCosts(o, data, nJKTinstall, stocVar, markMods) * sum(iJKT)/nJKTinstall;
    
    %determine PP and JKT installation vessel costs%
    [~, ~, CvesselPP] = vesselCharterModel(o, data, o.WTG(iJKT), 'install', 'PP', nPPinstall, stocVar, markMods);
    [~, ~, CvesselJKT] = vesselCharterModel(o, data, o.WTG(iJKT), 'install', 'sJKT', nJKTinstall, stocVar, markMods);
    
    %determine SP installation costs%
    [~, CscourJKT] = scourProtectionInstall(o, data, o.WTG(iJKT), 'sJKT', stocVar, markMods);
    
    %add to total foundation installation costs%
    o.CAPEX.real.fndInstall = o.CAPEX.real.fndInstall + CvesselPP + CvesselJKT + CscourJKT + CoverheadJKT;
    
end

if any(strcmpi({o.WTG.fndType}, 'semisub'))
    
    %determine semi-submersible WTGs%
    iSS = strcmpi({o.WTG.fndType}, 'semisub');
    
    %determine the number of components to be installed%
    nMoorInstall = getProcurementRequirement(o, data, 'fndComp', 'drag');
    nSSinstall = getProcurementRequirement(o, data, 'fndComp', 'semisub');
   
    CoverheadSS = jacketInstallOverheadCosts(o, data, nSSinstall, stocVar, markMods);
    
    Claunch = semiSubLaunchingCosts(o, data, nSSinstall, 'install', stocVar, markMods);
    
    [~, CinstSS] = floatingInstallModel(o, data, o.WTG(iSS), 'install', 'semi', nSSinstall, stocVar, markMods);
    [~, ~, CinstMoor] = vesselCharterModel(o, data, o.WTG(iSS), 'install', data.semi.anchType, nMoorInstall, stocVar, markMods);
    
    o.CAPEX.real.fndInstall = o.CAPEX.real.fndInstall + Claunch + CinstSS + CinstMoor + CoverheadSS;
    
end

if any(strcmpi({o.WTG.fndType}, 'gbf'))
    %Preparation of the seabed has to be modelled
    %determine gbf WTGs%
    iSS = strcmpi({o.WTG.fndType}, 'gbf');
    
    %determine the number of components to be installed%
    nGBFinstall = getProcurementRequirement(o, data, 'fndComp', 'gbf');
   
    
    CoverheadGBF = gbfInstallOverheadCosts(o, data, nGBFinstall, stocVar, markMods);
    
    Claunch = gbfLaunchingCosts(o, data, nGBFinstall, 'install', stocVar, markMods);
    
    [~, CinstGBF] = gbffloatingInstallModel(o, data, o.WTG(iSS), 'install', 'gbf', nGBFinstall, stocVar, markMods);
    
    o.CAPEX.real.fndInstall = o.CAPEX.real.fndInstall + Claunch + CinstGBF + CoverheadGBF;
    
end

for i = 1 : numel(o.vessels.fndInst.type)
    
    %add vessel mobilisation costs to installation total%
    o.CAPEX.real.fndInstall = o.CAPEX.real.fndInstall + vesselMobilisationCost(o, data, o.vessels.fndInst.type{i}, stocVar, markMods) * o.vessels.fndInst.nVesMob(i);
    
end
                  