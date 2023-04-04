function [hCharterLay, hCharterBury, Cinstall] = postLayBurialModel(o, data, lCableSB, objVect, comp, nCables, markMods, stocVar)

if any(strcmpi({o.WTG.fndType}, 'oblyth'))


switch lower(comp)
    
    case 'array'%96
    hCharterLay=48;  hCharterBury=48; hLayReal=48; hBuryReal=48;
    
    case 'export'%132h
    hCharterLay=66;  hCharterBury=66; hLayReal=66; hBuryReal=66;  

         
end


 %calculate total cost of installation process%
Cinstall = vesselCharterCost(o, data, hLayReal, 'Stemat', [], markMods, stocVar) + ...
           offshoreWorksCrew(o, data, hLayReal, 'prep', markMods, stocVar) + ...
           vesselCharterCost(o, data, hLayReal, 'CTV', [], markMods, stocVar) + ...
           vesselCharterCost(o, data, hBuryReal, 'Stemat', [], markMods, stocVar);  

      return;
end

switch lower(comp)
    
    case 'array'
        
        %determine preparation and pull-in times with learning effects%
        hPrep = data.array.hPrep * learningEffect(nCables, data.array.Nref, data.array.LRinst) * nCables;
        hPullIn = 2*data.array.hPullIn * learningEffect(nCables, data.array.Nref, data.array.LRinst) * nCables;                          
    
        switch o.zone.fDrill 
            
            case 0
                
            %determine cable laying times%
            hLay = lCableSB/data.vessel.CLV.vLaySimp;
        
            case 1
                
            %determine cable laying times%
            hLay = lCableSB/data.vessel.CLV.vLayComp;
            
        end
        
        %determine cable trenching times%
        hBury = lCableSB/data.vessel.OCV.vTrench;
        
        %determine distance to centre of WTG array%
        dMeanWTG = mean([objVect.dPortCon]);
                             
        %determine CLV and CLB travel times%
        hTravelCLV = 2*dMeanWTG/data.vessel.CLV.vTravel;
        hTravelCBV = 2*dMeanWTG/data.vessel.OCV.vTravel;
        
        %no moving times in array%
        hMoveCLV = 0; hMoveCBV = 0;
        
%     case 'export'
%         
%         %determine preparation and pull-in times with learning effects%
%         hPrep = data.HVAC.hPrep * learningEffect(nCables, data.HVAC.Nref, data.HVAC.LRinst) * nCables;
%         hPullIn = data.HVAC.hPullIn * learningEffect(nCables, data.HVAC.Nref, data.HVAC.LRinst) * nCables;
%         
%         %determine cable laying and trenching times%
%         hLay = lCableSB/data.vessel.CLV.vLay;
%         hBury = lCableSB/data.vessel.OCV.vTrench;
%         
%         %determine CLV and CLB travel times%
%         hTravelCLV = sum(2*[objVect.dPortCon]/data.vessel.CLV.vTravel);
%         hTravelCBV = sum(2*[objVect.dPortCon]/data.vessel.OCV.vTravel);
%         
%         %determine CLV and CLB moving times between subsequent SS cables%
%         hMoveCLV = sum(([objVect.dLandfall]/data.vessel.CLV.vTravel) .* ([objVect.nExportCable] - 1));
%         hMoveCBV = sum(([objVect.dLandfall]/data.vessel.OCV.vTravel) .* ([objVect.nExportCable] - 1));
%         
% end

    case 'export'
        
        if strcmp( o.OWF.expType, 'HVAC')
            
            %determine preparation and pull-in times with learning effects%
            hPrep = data.HVAC.hPrep * learningEffect(nCables, data.HVAC.Nref, data.HVAC.LRinst) * nCables;
            hPullIn = data.HVAC.hPullIn * learningEffect(nCables, data.HVAC.Nref, data.HVAC.LRinst) * nCables;
            
        end
        
        if strcmp( o.OWF.expType, 'HVDC')
            
            %determine preparation and pull-in times with learning effects%
            hPrep = data.HVDC.hPrep * learningEffect(nCables, data.HVDC.Nref, data.HVDC.LRinst) * nCables;
            hPullIn = data.HVDC.hPullIn * learningEffect(nCables, data.HVDC.Nref, data.HVDC.LRinst) * nCables;
            
        end
        
        switch o.zone.fDrill
            
            case 0
                
            %determine cable laying times for simple soil%
            hLay = lCableSB/data.vessel.CLV.vLaySimp;
        
            case 1
        
            %determine cable laying times for complex soil%
            hLay = lCableSB/data.vessel.CLV.vLayComp;
        
        end
        
        %determine cable trenching times%
        hBury = lCableSB/data.vessel.OCV.vTrench;
        
        %determine CLV and CLB travel times%
        hTravelCLV = sum(2*[objVect.dPortCon]/data.vessel.CLV.vTravel);
        hTravelCBV = sum(2*[objVect.dPortCon]/data.vessel.OCV.vTravel);
        
        %determine CLV and CLB moving times between subsequent SS cables%
        hMoveCLV = sum(([objVect.dLandfall]/data.vessel.CLV.vTravel) .* ([objVect.nExportCable] - 1));
        hMoveCBV = sum(([objVect.dLandfall]/data.vessel.OCV.vTravel) .* ([objVect.nExportCable] - 1));
        
end

%determine time to launch and recover ROV%
hROVlaunch = 2*data.vessel.OCV.hLaunch*nCables;

%apply any stochastic and market modifiers to real and planned times%
hPrepPlan = hPrep * scenarioModifier('cables.hInstPlan', stocVar, markMods);
hPrepReal = hPrepPlan * scenarioModifier('cables.hInstReal', stocVar, markMods);

%apply any stochastic and market modifiers to real and planned times%
hPullInPlan = hPullIn * scenarioModifier('cables.hInstPlan', stocVar, markMods);
hPullInReal = hPullInPlan * scenarioModifier('cables.hInstReal', stocVar, markMods);

%apply any stochastic and market modifiers to real and planned times%
hLayPlan = hLay * scenarioModifier('cables.hInstPlan', stocVar, markMods);
hLayReal = hLayPlan * scenarioModifier('cables.hInstReal', stocVar, markMods);

%apply any stochastic and market modifiers to real and planned times%
hBuryPlan = hBury * scenarioModifier('cables.hInstPlan', stocVar, markMods);
hBuryReal = hBuryPlan * scenarioModifier('cables.hInstReal', stocVar, markMods);

%determine CLV and CBV charter times%
hCharterLay = (hPrepPlan + hPullInPlan + hLayPlan + hTravelCLV + hMoveCLV)/data.vessel.CLV.wOp;
hCharterBury = (hROVlaunch + hBuryPlan + hTravelCBV + hMoveCBV)/data.vessel.OCV.wOp;

%determine CLV and CBV charter times%
hLayReal = (hPrepReal + hPullInReal + hLayReal + hTravelCLV + hMoveCLV)/data.vessel.CLV.wOp;
hBuryReal = (hROVlaunch + hBuryReal + hTravelCBV + hMoveCBV)/data.vessel.OCV.wOp;

%calculate total cost of installation process%
Cinstall = vesselCharterCost(o, data, hLayReal, 'CLV', [], markMods, stocVar) + ...
           offshoreWorksCrew(o, data, hLayReal, 'prep', markMods, stocVar) + ...
           vesselCharterCost(o, data, hLayReal, 'CTV', [], markMods, stocVar) + ...
           vesselCharterCost(o, data, hBuryReal, 'OCV', [], markMods, stocVar);  