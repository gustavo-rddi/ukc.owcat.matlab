function [hPlan, Nsupply, Cvessels] = vesselCharterModel(o, data, objVect, mode, objType, nObjPhase, stocVar, markMods)

%default operation times%
hLoad = data.(objType).hLoad;
hInstall = data.(objType).hInstall;

if hInstall == 0
    
    hPlan = 0; Nsupply = 0; Cvessels = 0;
    
else

%number of installation sites%
nPos = numel(objVect);

%number of objects to install%
if strcmpi(objType, 'PP') 
    nObjInstall = sum([objVect.nPP]);
else
    nObjInstall = nPos;
end



if strcmpi(mode, 'decom')
    
    %decommissioning modifiers%
    hLoad = hLoad * (1 + data.(objType).fDecom);
    hInstall = hInstall * (1 + data.(objType).fDecom);

end

if isfield(data.(objType), 'LRinst')

    %apply learning-by-doing effects where available%
    hLoad = hLoad * learningEffect(nObjPhase, data.(objType).Nref, data.(objType).LRinst);
    hInstall = hInstall * learningEffect(nObjPhase, data.(objType).Nref, data.(objType).LRinst);

end

if strcmpi(objType, 'WTG')
    
    %determine WTG installation weather window from wind speed%
    wInst = mean(1 - exp(-(pi/4)*(data.WTG.vMaxInst./[objVect.vWind]).^2));
    
else
    
    %weather window based on vessel choice%
    wInst = data.vessel.(data.(objType).instVes).wOp;
    
end

%additional installation time if drilling required%
if (strcmpi(objType, 'MP') || strcmpi(objType, 'PP')) && strcmpi(mode, 'install')
    hInstall = hInstall + data.(objType).dhDrill * mean([objVect.pDrill]);
end

if strcmpi(mode, 'install')

    %apply any stochastic and market modifiers to real and planned installation time%
    hInstallPlan = hInstall * scenarioModifier([objType,'.hInstPlan'], stocVar, markMods);
    hLoadPlan = hLoad * scenarioModifier([objType,'.hInstPlan'], stocVar, markMods);
    
    hInstallReal = hInstallPlan * scenarioModifier([objType,'.hInstReal'], stocVar, markMods);
    hLoadReal = hLoadPlan * scenarioModifier([objType,'.hInstReal'], stocVar, markMods);
    
else
    
    %apply any stochastic and market modifiers to real and planned  decommissioning time%
    hInstallPlan = hInstall * scenarioModifier([objType,'.hDecomPlan'], stocVar, markMods);
    hLoadPlan = hLoad * scenarioModifier([objType,'.hDecomPlan'], stocVar, markMods);
        
    hInstallReal = hInstallPlan * scenarioModifier([objType,'.hDecomReal'], stocVar, markMods);
    hLoadReal = hLoadPlan * scenarioModifier([objType,'.hDecomReal'], stocVar, markMods);
    
end

switch data.(objType).compSup
    
    case 'self'
        
        %determine vessel travel and moving times%
        vTravel = data.vessel.(data.(objType).instVes).vTravel;
        vMove = data.vessel.(data.(objType).instVes).vMove;
        
        %get vessel operation weather window%
        wOp = data.vessel.(data.(objType).instVes).wOp;
        
        %number of transport trips to and from construction port%
        Ntrip = ceil(nObjInstall/data.vessel.(data.(objType).instVes).cap.(objType));
        
        %loading operations%
        nLoad = nObjInstall;
                
    case {'OTB','PSV'}
        
        %determine vessel travel and moving times%
        vTravel = min(data.vessel.(data.(objType).instVes).vTravel, data.vessel.(data.(objType).compSup).vTravel);
        vMove = min(data.vessel.(data.(objType).instVes).vMove, data.vessel.(data.(objType).compSup).vMove);
        
        %get most restrictive vessel operation weather window%
        wOp = min(data.vessel.(data.(objType).instVes).wOp, data.vessel.(data.(objType).compSup).wOp);
        
        %one trip%
        Ntrip = 1;
        
        %only account for loading for first barge%
        nLoad = min(nObjInstall, data.vessel.(data.(objType).compSup).cap.(objType));
        
end

%calculate vessel travelling and moving times%
hTravel = 2*mean([objVect.dPortCon])/vTravel;
hMove = mean([objVect.dSpace])/vMove;

%determine base charter duration%
hPlan = hLoadPlan * nLoad ...
      + data.vessel.(data.(objType).instVes).hPos/wOp * nPos ...
      + hTravel/wOp * Ntrip ...
      + hMove/wOp * (nPos - Ntrip) ...
      + hInstallPlan/wInst * nObjInstall;
 
%determine planned/real duration with installation%     
hReal = hLoadReal * nLoad ...
      + data.vessel.(data.(objType).instVes).hPos/wOp * nPos ...
      + hTravel/wOp * Ntrip ...
      + hMove/wOp * (nPos - Ntrip) ...
      + hInstallReal/wInst * nObjInstall;     

%load required installation equipment%     
if strcmpi(mode, 'install') && isfield(data.(objType), 'instEquip')
    
    equip{1,1} = data.(objType).instEquip;
    
else
    
    equip = [];
    
end
     
switch data.(objType).compSup
    
    case 'self'
        %add additional drilling for installation in complex soil%
        if strcmpi(mode, 'install') && o.zone.fDrill(1) ~= 0

            if  strcmpi(objType, 'MP')
                
                equip{end+1} = 'drillMP';  
                
            elseif strcmpi(objType, 'PP')
                
                equip{end+1} = 'drillPP';
                
            end
            
        end
        
        %no supply vessel%
        Nsupply = 0;
        
        %cost of installation vessel only%
        Cvessels = vesselCharterCost(o, data, hReal, data.(objType).instVes, equip, stocVar, markMods);
                
    case {'OTB','PSV'}
        %add additional drilling for installation in complex soil%
        if strcmpi(mode, 'install') && o.zone.fDrill ~= 0

            if  strcmpi(objType, 'MP')
                
                equip{end+1} = 'drillMP';  
                
            elseif strcmpi(objType, 'PP')
                
                equip{end+1} = 'drillPP';
                
            end
            
        end

        %determine OTB travel and moving times%
        hTravelBarge = 2*mean([objVect.dPortCon])/data.vessel.(data.(objType).compSup).vTravel;
        
        %determine required number of supply vessels for continuous component supply%
        Nsupply = 1 + ceil( (data.vessel.(data.(objType).compSup).cap.(objType)*hLoad + hTravelBarge) ...
                          / (data.vessel.(data.(objType).compSup).cap.(objType)*(hInstallPlan + data.vessel.(data.(objType).instVes).hPos/nPos) + (data.vessel.(data.(objType).compSup).cap.(objType)-1)*hMove) );
        
        %check if single supply trip would be more efficient%             
        Nsupply = min(Nsupply, ceil(nObjInstall/data.vessel.(data.(objType).compSup).cap.(objType)));             
             
        %cost of installation vessel and required OTBs%
        Cvessels = vesselCharterCost(o, data, hReal, data.(objType).instVes, equip, stocVar, markMods) ...
                 + vesselCharterCost(o, data, hReal, data.(objType).compSup, [], stocVar, markMods) * Nsupply;
         
end     

end