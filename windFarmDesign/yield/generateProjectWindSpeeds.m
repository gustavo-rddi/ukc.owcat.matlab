function o = generateProjectWindSpeeds(o, ~, stocVar, markMods)

for i = 1 : o.OWF.nZones
    
    o.zone(i).vWindAnn = o.zone(i).vWind * ones(1, numel(o.OWF.yrProj));
    
    %apply any stochastic and market modifiers to long-term and yearly mean wind speeds%
    o.zone(i).vWindAnn = o.zone(i).vWindAnn .* scenarioModifier('windSpeed.mean', stocVar, markMods) ...
                                            .* scenarioModifier('windSpeed.yearly', stocVar, markMods);
    
    if strcmpi(o.finance.type, 'project')
                                            
        o.zone(i).vWindP90 = o.zone(i).vWind * (1 - sqrt(2)*o.OWF.sigWind*erfinv(0.8)) * ones(1, numel(o.OWF.yrProj));
                                            
    end
                                        
end
    