function o = calculateWTGinstallCosts(o, data, stocVar, markMods)

%determine overhead costs for WTG installation%
Coverhead = WTGinstallOverheadCosts(o, data, o.OWF.nWTG, stocVar, markMods);

%determine WTG commissioning costs%
[~, Ccomm] = componentCommissioning(o, data, 'WTG', o.OWF.nWTG, stocVar, markMods);

if any(strcmpi({o.WTG.turbInst}, 'offshore'))
    
    iOffshore = strcmpi({o.WTG.turbInst}, 'offshore');

    %calculate charter costs for WTG installation%
    [~, ~, Cinstall] = vesselCharterModel(o, data, o.WTG(iOffshore), 'install', 'WTG', sum(iOffshore), stocVar, markMods);

    for i = 1 : numel(o.vessels.WTGinst.type)
    
        %add vessel mobilisation costs to installation total%
        o.CAPEX.real.turbInstall = o.CAPEX.real.turbInstall + vesselMobilisationCost(o, data, o.vessels.WTGinst.type{i}, stocVar, markMods) * o.vessels.WTGinst.nVesMob(i);
    
    end
    
end

if any(strcmpi({o.WTG.turbInst}, 'quaySide'))
    
    iQuaySide = strcmpi({o.WTG.turbInst}, 'quaySide');
    
    Cinstall = quaySideInstallation(o, data, o.WTG(iQuaySide), 'install', 'WTG', sum(iQuaySide), stocVar, markMods);
        
end
    
%sum to get total WTG installation costs%
o.CAPEX.real.turbInstall = o.CAPEX.real.turbInstall + Coverhead + Cinstall + Ccomm;
