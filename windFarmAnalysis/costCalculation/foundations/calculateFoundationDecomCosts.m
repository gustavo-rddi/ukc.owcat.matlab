function o = calculateFoundationDecomCosts(o, data, stocVar, markMods)


if any(strcmpi({o.WTG.fndType}, 'oblyth'))||any(strcmpi({o.WTG.fndType}, 'o500gbf'))|| any(strcmpi({o.WTG.fndType}, 'o500jkt'))
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
    [~, ~, CvesselMP] = vesselCharterModel(o, data, o.WTG(iMP), 'decom', 'MP', nMPinstall, stocVar, markMods);
    [~, ~, CvesselTP] = vesselCharterModel(o, data, o.WTG(iMP), 'decom', 'TP', nMPinstall, stocVar, markMods);
    
    %add to total foundation installation costs%
    o.DECEX.real.fndDecom = o.DECEX.real.fndDecom + CvesselMP + CvesselTP + CoverheadMP;
        
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
    [~, ~, CvesselPP] = vesselCharterModel(o, data, o.WTG(iJKT), 'decom', 'PP', nPPinstall, stocVar, markMods);
    [~, ~, CvesselJKT] = vesselCharterModel(o, data, o.WTG(iJKT), 'decom', 'sJKT', nJKTinstall, stocVar, markMods);
    
    %add to total foundation installation costs%
    o.DECEX.real.fndDecom = o.DECEX.real.fndDecom + CvesselPP + CvesselJKT + CoverheadJKT;
    
end

if any(strcmpi({o.WTG.fndType}, 'semisub'))
    
    %determine jacket-based WTGs%
    iSS = strcmpi({o.WTG.fndType}, 'semisub');
    
    %determine the number of components to be installed%
    nMoorInstall = getProcurementRequirement(o, data, 'fndComp', 'drag');
    nSSinstall = getProcurementRequirement(o, data, 'fndComp', 'semisub');
   
    Claunch = semiSubLaunchingCosts(o, data, nSSinstall, 'decom', stocVar, markMods);
    
    CoverheadSS = jacketInstallOverheadCosts(o, data, nSSinstall, stocVar, markMods);
    
    [~, CinstSS] = floatingInstallModel(o, data, o.WTG(iSS), 'decom', 'semi', nSSinstall, stocVar, markMods);
    [~, ~, CinstMoor] = vesselCharterModel(o, data, o.WTG(iSS), 'decom', data.semi.anchType, nMoorInstall, stocVar, markMods);
    
    o.DECEX.real.fndDecom = o.DECEX.real.fndDecom + CinstSS + Claunch + CinstMoor + CoverheadSS;
    
end

for i = 1 : numel(o.vessels.fndDecom.type)
    
    %add vessel mobilisation costs to installation total%
    o.DECEX.real.fndDecom = o.DECEX.real.fndDecom + vesselMobilisationCost(o, data, o.vessels.fndDecom.type{i}, stocVar, markMods) * o.vessels.fndDecom.nVesMob(i);
    
end