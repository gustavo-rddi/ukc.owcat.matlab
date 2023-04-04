function o = foundationInstallation(o, data, stocVar, markMods)


% if any(strcmpi({o.WTG.fndType}, 'oblyth'))||any(strcmpi({o.WTG.fndType}, 'o500gbf'))|| any(strcmpi({o.WTG.fndType}, 'o500jkt'))
% return;
% end


if any(strcmpi({o.WTG.fndType}, 'monopile'))
    
    %determine monopile-based WTGs%
    iMP = strcmpi({o.WTG.fndType}, 'monopile');
    
    %determine the number of components to be installed%
    nMPinstall = getProcurementRequirement(o, data, 'fndComp', 'monopile');
    
    %determine MP and TP installation vessel charter durations%
    [hMPinst, NsuppMP, ~] = vesselCharterModel(o, data, o.WTG(iMP), 'install', 'MP', nMPinstall, stocVar, markMods);
    [hTPinst, NsuppTP, ~] = vesselCharterModel(o, data, o.WTG(iMP), 'install', 'TP', nMPinstall, stocVar, markMods);
    
    %determine SP installation vessel charter duration%
    [hSPinst, ~] = scourProtectionInstall(o, data, o.WTG(iMP), 'MP', stocVar, markMods);
    
    %add MP vessels to BOP installation requirements%
    o = addToVesselRequirements(o, data, 'fndInst', data.MP.instVes, 1, hMPinst, true);
    o = addToVesselRequirements(o, data, 'fndInst', data.MP.compSup, NsuppMP, hMPinst, true);
      
    %add TP vessels to BOP installation requirements%
    o = addToVesselRequirements(o, data, 'fndInst', data.TP.instVes, 1, hTPinst, true);
    o = addToVesselRequirements(o, data, 'fndInst', data.TP.compSup, NsuppTP, hTPinst, true);
    
    %add SP vessel to BOP installation requirements%
    o = addToVesselRequirements(o, data, 'fndInst', 'RDV', 1, hSPinst, false);
        
end

if any(strcmpi({o.WTG.fndType}, 'jacket'))
    
    %determine jacket-based WTGs%
    iJKTphase = strcmpi({o.WTG.fndType}, 'jacket');
    
    %determine the number of components to be installed%
    nPPinstall = getProcurementRequirement(o, data, 'fndComp', 'pinpile');
    nJKTinstall = getProcurementRequirement(o, data, 'fndComp', 'wtgJacket');
    
    %determine PP and JKT installation vessel charter durations%
    [hPPinst, NsuppPP, ~] = vesselCharterModel(o, data, o.WTG(iJKTphase), 'install', 'PP', nPPinstall, stocVar, markMods);
    [hJKTinst, NsuppJKT, ~] = vesselCharterModel(o, data, o.WTG(iJKTphase), 'install', 'sJKT', nJKTinstall, stocVar, markMods);
    
    %determine SP installation vessel charter duration%
    [hSPinst, ~] = scourProtectionInstall(o, data, o.WTG(iJKTphase), 'sJKT', [], []);
        
    %add PP vessels to BOP installation requirements%
    o = addToVesselRequirements(o, data, 'fndInst', data.PP.instVes, 1, hPPinst, true);
    o = addToVesselRequirements(o, data, 'fndInst', data.PP.compSup, NsuppPP, hPPinst, true);
      
    %add JKT vessels to BOP installation requirements%
    o = addToVesselRequirements(o, data, 'fndInst', data.sJKT.instVes, 1, hJKTinst, true);
    o = addToVesselRequirements(o, data, 'fndInst', data.sJKT.compSup, NsuppJKT, hJKTinst, true);
    
    %add SP vessel to BOP installation requirements%
    o = addToVesselRequirements(o, data, 'fndInst', 'RDV', 1, hSPinst, false);
    
end

if any(strcmpi({o.WTG.fndType}, 'semisub'))
   
    %determine jacket-based WTGs%
    iSS = strcmpi({o.WTG.fndType}, 'semisub');
    
    %determine the number of components to be installed%
    nMoorInstall = getProcurementRequirement(o, data, 'fndComp', 'drag');
    nSSinstall = getProcurementRequirement(o, data, 'fndComp', 'semisub');
   
    [hInstSS, ~] = floatingInstallModel(o, data, o.WTG(iSS), 'install', 'semi', nSSinstall, stocVar, markMods);
    [hInstMoor, NsuppMoor, ~] = vesselCharterModel(o, data, o.WTG(iSS), 'install', data.semi.anchType, nMoorInstall, stocVar, markMods);
    
    o = addToVesselRequirements(o, data, 'fndInst', data.semi.instVes, 1, hInstSS, true);
    
    o = addToVesselRequirements(o, data, 'fndInst', data.(data.semi.anchType).instVes, 1, hInstMoor, true);
    o = addToVesselRequirements(o, data, 'fndInst', data.(data.semi.anchType).compSup, NsuppMoor, hInstMoor, true);
    
end
