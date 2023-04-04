function o = foundationDecommissioning(o, data, stocVar, markMods)


if any(strcmpi({o.WTG.fndType}, 'oblyth'))||any(strcmpi({o.WTG.fndType}, 'o500gbf'))|| any(strcmpi({o.WTG.fndType}, 'o500jkt'))
return;
end

if any(strcmpi({o.WTG.fndType}, 'monopile'))
    
    %determine monopile-based WTGs%
    iMPphase = strcmpi({o.WTG.fndType}, 'monopile');
    
    %determine the number of components to be decommissioned%
    nMPdecom = getProcurementRequirement(o, data, 'fndComp', 'monopile');
    
    %determine MP and TP installation vessel charter durations%
    [hMPdecom, NsuppMP, ~] = vesselCharterModel(o, data, o.WTG(iMPphase), 'decom', 'MP', nMPdecom, stocVar, markMods);
    [hTPdecom, NsuppTP, ~] = vesselCharterModel(o, data, o.WTG(iMPphase), 'decom', 'TP', nMPdecom, stocVar, markMods);
   
    %add MP vessels to BOP decommissioning requirements%
    o = addToVesselRequirements(o, data, 'fndDecom', data.MP.instVes, 1, hMPdecom, true);
    o = addToVesselRequirements(o, data, 'fndDecom', data.MP.compSup, NsuppMP, hMPdecom, true);
      
    %add TP vessels to BOP decommissioning requirements%
    o = addToVesselRequirements(o, data, 'fndDecom', data.TP.instVes, 1, hTPdecom, true);
    o = addToVesselRequirements(o, data, 'fndDecom', data.TP.compSup, NsuppTP, hTPdecom, true);
    
end

if any(strcmpi({o.WTG.fndType}, 'jacket'))
    
    %determine jacket-based WTGs in current phase%
    iJKTphase = strcmpi({o.WTG.fndType}, 'jacket');
    
    %determine the number of components to be decommissioned%
    nPPdecom = getProcurementRequirement(o, data, 'fndComp', 'pinpile');
    nJKTdecom = getProcurementRequirement(o, data, 'fndComp', 'wtgJacket');
    
    %determine PP and JKT installation vessel charter durations%
    [hPPdecom, NsuppPP, ~] = vesselCharterModel(o, data, o.WTG(iJKTphase), 'decom', 'PP', nPPdecom, stocVar, markMods);
    [hJKTdecom, NsuppJKT, ~] = vesselCharterModel(o, data, o.WTG(iJKTphase), 'decom', 'sJKT', nJKTdecom, stocVar, markMods);
    
    %add MP vessels to BOP decommissioning requirements%
    o = addToVesselRequirements(o, data, 'fndDecom', data.PP.instVes, 1, hPPdecom, true);
    o = addToVesselRequirements(o, data, 'fndDecom', data.PP.compSup, NsuppPP, hPPdecom, true);
      
    %add TP vessels to BOP decommissioning requirements%
    o = addToVesselRequirements(o, data, 'fndDecom', data.sJKT.instVes, 1, hJKTdecom, true);
    o = addToVesselRequirements(o, data, 'fndDecom', data.sJKT.compSup, NsuppJKT, hJKTdecom, true);
    
end

if any(strcmpi({o.WTG.fndType}, 'semisub'))
   
    %determine jacket-based WTGs%
    iSS = strcmpi({o.WTG.fndType}, 'semisub');
    
    %determine the number of components to be installed%
    nMoorInstall = getProcurementRequirement(o, data, 'fndComp', 'drag');
    nSSinstall = getProcurementRequirement(o, data, 'fndComp', 'semisub');
   
    [hInstSS, ~] = floatingInstallModel(o, data, o.WTG(iSS), 'decom', 'semi', nSSinstall, stocVar, markMods);
    [hInstMoor, NsuppMoor, ~] = vesselCharterModel(o, data, o.WTG(iSS), 'decom', data.semi.anchType, nMoorInstall, stocVar, markMods);
    
    o = addToVesselRequirements(o, data, 'fndDecom', data.semi.instVes, 1, hInstSS, true);
    
    o = addToVesselRequirements(o, data, 'fndDecom', data.(data.semi.anchType).instVes, 1, hInstMoor, true);
    o = addToVesselRequirements(o, data, 'fndDecom', data.(data.semi.anchType).compSup, NsuppMoor, hInstMoor, true);
    
end
