function o = windTurbineProcurement(o, data)
    
%determine WTG models%
WTGmodels = unique({o.WTG.model});

for i = 1 : length(WTGmodels)
    
    %determine number of current WTG model to order%
    nSupply = sum(strcmpi({o.WTG.model}, WTGmodels{i}));
    
    %add WTG model to procurement requirements%
    o = addToProcurementRequirements(o, data, 'WTG', WTGmodels{i}, nSupply);
    
end
