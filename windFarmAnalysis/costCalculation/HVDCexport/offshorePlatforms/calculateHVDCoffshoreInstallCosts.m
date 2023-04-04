function o = calculateHVDCoffshoreInstallCosts(o, data, stocVar)

for i = 1 : o.OWF.nColl
   
    %determine build phase%
    iPhaseColl = o.offshoreColl(i).buildPhase;
    
    %determine installation vessel travel time%
    hTravelIV = 2*o.offshoreColl(i).dPortCon/data.vessel.HLV.vTravel;
        
    %determine time to install single offshore substation%
    hInstallSS = data.HVDC.hLoad ...
               + data.vessel.HLV.hPos/data.vessel.HLV.wOp ...
               + data.HVDC.hInstall/data.vessel.HLV.wOp ... 
               + hTravelIV/data.vessel.HLV.wOp;
        
    %determine the number of foundations that are going to be installed this phase%
    nFndInstall = o.phase(iPhaseColl).nFndSupply(strcmpi(o.phase(iPhaseColl).fndTypes, 'heavyJacket'));
    
    %determine SPJV travel time%
    hTravelDPV = 2*o.offshoreColl(i).dPortCon/data.vessel.SPJV.vTravel;
    
    %determine time to install single set of pre-piles%
    hInstallPP = 4*data.fnd.PP.hLoad ...
        + 4*data.vessel.SPJV.hPos/data.vessel.SPJV.wOp ...
        + 4*data.fnd.PP.hInstall/data.vessel.SPJV.wOp ...
        + (hTravelDPV/data.vessel.SPJV.wOp)*(1/nFndInstall);
    
    %determine time to install single OSS jacket%
    hInstallJKT = data.fnd.JKT.hLoad ...
        + data.vessel.HLV.hPos/data.vessel.HLV.wOp ...
        + data.fnd.JKT.hInstall/data.vessel.HLV.wOp ...
        + hTravelIV/data.vessel.HLV.wOp;
    
    %determine RDV travel and moving times%
    hTravelRDV = 2*o.offshoreColl(i).dPortCon/data.vessel.RDV.vTravel;
    
    %determine time to install scour protection%
    hInstallSP = 2*data.fnd.JKT.mSPmat/data.vessel.RDV.vLoad ...
        + (2*data.fnd.JKT.mSPmat/data.vessel.RDV.vInst)/data.vessel.RDV.wOp ...
        + (hTravelRDV/data.vessel.RDV.wOp)*max(1, data.fnd.JKT.mSPmat/data.vessel.RDV.capSP);
        
    %determine additional variable cost for OHVS configuration%
    CinstSS = vesselCharterCost(data, hInstallSS, 'HLV', [], data.econ.yrOper-2, stocVar) ...
            + vesselCharterCost(data, hInstallPP, 'SPJV', {'hammer'}, data.econ.yrOper-2, stocVar) ...
            + vesselCharterCost(data, hInstallJKT, 'HLV', {'grout'}, data.econ.yrOper-2, stocVar) ...
            + vesselCharterCost(data, hInstallSP, 'RDV', [], data.econ.yrOper-2, stocVar) ...
            + scourProtectionMaterialCost(data, data.fnd.JKT.mSPmat, data.econ.yrOper-2, stocVar);
    
    switch o.zone.fDrill
    
    case 0
        %determine time to install a single cable in simple soil%
        hLayCBL = data.HVAC.hPrep/data.vessel.CLV.wOp  ...
            + data.HVAC.hPullIn/data.vessel.CLV.wOp ...
            + o.offshoreColl(i).lInterConnect*(1/data.vessel.CLV.vLaySimp)/data.vessel.CLV.wOp;
        
    case 1
        %determine time to install a single cable complex soil%
        hLayCBL = data.HVAC.hPrep/data.vessel.CLV.wOp  ...
            + data.HVAC.hPullIn/data.vessel.CLV.wOp ...
            + o.offshoreColl(i).lInterConnect*(1/data.vessel.CLV.vLayComp)/data.vessel.CLV.wOp;
         
    end
    
    %determine time to trench a single cable%
    hTrenchCBL = 2*data.vessel.CBV.hLaunch/data.vessel.CBV.wOp ...
               + o.offshoreColl(i).lInterConnect*(1/data.vessel.CBV.vTrench )/data.vessel.CBV.wOp;
           
    %determine variable cable installation cost per substation%  
    CinstCollCable = cablePreLayingCosts(data, o.offshoreColl(i).lInterConnect, data.econ.yrOper-2, stocVar) ...
                   + vesselCharterCost(data, hLayCBL, 'CLV', [], data.econ.yrOper-2, stocVar) ...
                   + vesselCharterCost(data, hTrenchCBL, 'CBV', [], data.econ.yrOper-2, stocVar) ...
                   + offshoreWorksCrew(data, data.HVAC.hTerm, 'term', data.econ.yrOper-2, stocVar);        
    
    %calculate installation costs per OWF phase%
    o.phase(iPhaseColl).CexportInstall = o.phase(iPhaseColl).CexportInstall + CinstSS + CinstCollCable;
    
    %add to total installation costs for OWF%
    o.OWF.CexportInstall = o.OWF.CexportInstall + CinstSS + CinstCollCable;
    
    for j = 1 : o.OWF.nZones
    
        %calculate zonal installation costs%
        o.zone(j).CexportInstall = o.zone(j).CexportInstall + (CinstSS + CinstCollCable) * o.zone(j).cap/o.OWF.cap;
        
    end           
    
end

for i = 1 : o.OWF.nConv
    
    %determine build phase%
    iPhaseConv = o.offshoreConv(i).buildPhase;
    
    %determine installation vessel travel time%
    hTravelIV = 2*o.offshoreConv(i).dPortCon/data.vessel.HLV.vTravel;
        
    %determine time to install single offshore substation%
    hInstallSS = data.HVDC.hLoad ...
               + data.vessel.HLV.hPos/data.vessel.HLV.wOp ...
               + data.HVDC.hInstall/data.vessel.HLV.wOp ... 
               + hTravelIV/data.vessel.HLV.wOp;
        
    %determine the number of foundations that are going to be installed this phase%
    nFndInstall = o.phase(iPhaseConv).nFndSupply(strcmpi(o.phase(iPhaseConv).fndTypes, 'heavyJacket'));
    
    %determine SPJV travel time%
    hTravelDPV = 2*o.offshoreConv(i).dPortCon/data.vessel.SPJV.vTravel;
    
    %determine time to install single set of pre-piles%
    hInstallPP = 6*data.fnd.PP.hLoad ...
             + 6*data.vessel.SPJV.hPos/data.vessel.SPJV.wOp ...
        + 6*data.fnd.PP.hInstall/data.vessel.SPJV.wOp ...
        + (hTravelDPV/data.vessel.SPJV.wOp)*(1/nFndInstall);
    
    %determine time to install single OSS jacket%
    hInstallJKT = data.fnd.JKT.hLoad ...
        + data.vessel.HLV.hPos/data.vessel.HLV.wOp ...
        + data.fnd.JKT.hInstall/data.vessel.HLV.wOp ...
        + hTravelIV/data.vessel.HLV.wOp;
    
    %determine RDV travel and moving times%
    hTravelRDV = 2*o.offshoreConv(i).dPortCon/data.vessel.RDV.vTravel;
    
    %determine time to install scour protection%
    hInstallSP = 2*data.fnd.JKT.mSPmat/data.vessel.RDV.vLoad ...
        + (2*data.fnd.JKT.mSPmat/data.vessel.RDV.vInst)/data.vessel.RDV.wOp ...
        + (hTravelRDV/data.vessel.RDV.wOp)*max(1, data.fnd.JKT.mSPmat/data.vessel.RDV.capSP);
        
    %determine additional variable cost for OHVS configuration%
    CinstSS = vesselCharterCost(data, hInstallSS, 'HLV', [], data.econ.yrOper-2, stocVar) ...
            + vesselCharterCost(data, hInstallPP, 'SPJV', {'hammer'}, data.econ.yrOper-2, stocVar) ...
            + vesselCharterCost(data, hInstallJKT, 'HLV', {'grout'}, data.econ.yrOper-2, stocVar) ...
            + vesselCharterCost(data, hInstallSP, 'RDV', [], data.econ.yrOper-2, stocVar) ...
            + scourProtectionMaterialCost(data, data.fnd.JKT.mSPmat, data.econ.yrOper-2, stocVar);
    
        switch o.zone.fDrill
            
            case 0
           
            %determine time to install a single cable in simple soil%
            hLayCBL = data.HVAC.hPrep/data.vessel.CLV.wOp  ...
                    + data.HVAC.hPullIn/data.vessel.CLV.wOp ...
                    + o.offshoreConv(i).lOffshore*(1/data.vessel.CLV.vLaySimp)/data.vessel.CLV.wOp;
                
            case 1
                
            %determine time to install a single cable in simple soil%
            hLayCBL = data.HVAC.hPrep/data.vessel.CLV.wOp  ...
                    + data.HVAC.hPullIn/data.vessel.CLV.wOp ...
                    + o.offshoreConv(i).lOffshore*(1/data.vessel.CLV.vLayComp)/data.vessel.CLV.wOp;   
                
        end 
    
    %determine time to trench a single cable%
    hTrenchCBL = 2*data.vessel.CBV.hLaunch/data.vessel.CBV.wOp ...
               + o.offshoreConv(i).lOffshore*(1/data.vessel.CBV.vTrench )/data.vessel.CBV.wOp;
           
    %determine variable cable installation cost per substation%  
    CinstConvCable = cablePreLayingCosts(data, o.offshoreConv(i).lOffshore, data.econ.yrOper-2, stocVar) ...
                   + vesselCharterCost(data, hLayCBL, 'CLV', [], data.econ.yrOper-2, stocVar) * (2*o.offshoreConv(i).nConv) ...
                   + vesselCharterCost(data, hTrenchCBL, 'CBV', [], data.econ.yrOper-2, stocVar) * (2*o.offshoreConv(i).nConv)...
                   + offshoreWorksCrew(data, data.HVAC.hTerm, 'term', data.econ.yrOper-2, stocVar) * (2*o.offshoreConv(i).nConv);        
    
    %calculate installation costs per OWF phase%
    o.phase(iPhaseConv).CexportInstall = o.phase(iPhaseConv).CexportInstall + CinstSS + CinstConvCable;
    
    %add to total installation costs for OWF%
    o.OWF.CexportInstall = o.OWF.CexportInstall + CinstSS + CinstConvCable;
    
    for j = 1 : o.OWF.nZones
    
        %calculate zonal installation costs%
        o.zone(j).CexportInstall = o.zone(j).CexportInstall + (CinstSS + CinstConvCable) * o.zone(j).cap/o.OWF.cap;
        
    end           
            
end