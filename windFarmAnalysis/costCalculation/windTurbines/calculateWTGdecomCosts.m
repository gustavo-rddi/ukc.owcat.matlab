function o = calculateWTGdecomCosts(o, data, stocVar, markMods)

%determine overhead costs for WTG installation%
Coverhead = WTGinstallOverheadCosts(o, data, o.OWF.nWTG, stocVar, markMods);

if any(strcmpi({o.WTG.turbInst}, 'offshore'))

%calculate charter costs for WTG installation%
[~, ~, Cinstall] = vesselCharterModel(o, data, o.WTG, 'decom', 'WTG', o.OWF.nWTG, stocVar, markMods);


    for i = 1 : numel(o.vessels.WTGdecom.type)
    
        %add vessel mobilisation costs to installation total%
        o.DECEX.real.turbDecom = o.DECEX.real.turbDecom + vesselMobilisationCost(o, data, o.vessels.WTGdecom.type{i}, stocVar, markMods) * o.vessels.WTGdecom.nVesMob(i);
    
    end

end

if any(strcmpi({o.WTG.turbInst}, 'quaySide'))
    
    iQuaySide = strcmpi({o.WTG.turbInst}, 'quaySide');
    
    Cinstall = quaySideInstallation(o, data, o.WTG(iQuaySide), 'install', 'WTG', sum(iQuaySide), stocVar, markMods);
        
end
    
%sum to get total WTG installation costs%
o.DECEX.real.turbDecom = o.DECEX.real.turbDecom + Coverhead + Cinstall;
