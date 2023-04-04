function o = foundationProcurement(o, data, ~)

%determine WTG foundation components%
WTGfndTypes = unique({o.WTG.fndType});

for i = 1 : length(WTGfndTypes)
    
    %determine number of current WTG foundation to order%
    nSupply = sum(strcmpi({o.WTG.fndType}, WTGfndTypes{i}));
    
    if strcmpi(WTGfndTypes{i}, 'jacket')
    
        %re-label as WTG jackets and add to procurement requirements%
        o = addToProcurementRequirements(o, data, 'fndComp', 'wtgJacket', nSupply);
        o = addToProcurementRequirements(o, data, 'fndComp', 'pinPile', sum([o.WTG.nPP]));
        
     elseif strcmpi(WTGfndTypes{i}, 'semisub')
        
        %add WTG foundations to procurement requirements%
        o = addToProcurementRequirements(o, data, 'fndComp', WTGfndTypes{i}, nSupply);
        o = addToProcurementRequirements(o, data, 'fndComp', data.semi.anchType, sum([o.WTG.nMoor]));
        
    else
        
        %add WTG foundations to procurement requirements%
        o = addToProcurementRequirements(o, data, 'fndComp', WTGfndTypes{i}, nSupply);

    end

end

if ~strcmpi(o.OWF.expType, 'MVAC')

    if strcmpi(o.design.expConf, 'OTM') && ~o.OWF.fndShare
        
        %add any additional OTM jackets to procurement requirements%
        o = addToProcurementRequirements(o, data, 'fndComp', 'wtgJacket', o.OWF.nOSS);
        o = addToProcurementRequirements(o, data, 'fndComp', 'pinPile', sum([o.offshoreSS.nPP]));
        
        
    elseif strcmpi(o.design.expConf, 'OHVS')
        
        %add large SS jackets to procurement requirements%
        o = addToProcurementRequirements(o, data, 'fndComp', 'hvyJacket',o.OWF.nOSS);
        o = addToProcurementRequirements(o, data, 'fndComp', 'pinPile', sum([o.offshoreSS.nPP]));
        
    end
    
    if strcmpi(o.design.expConf, 'VSC')
        
        %add large SS jackets to procurement requirements%
        o = addToProcurementRequirements(o, data, 'fndComp', 'hvyJacket',o.OWF.nOSS+o.OWF.nConv);
        o = addToProcurementRequirements(o, data, 'fndComp', 'pinPile', sum([o.offshoreSS.nPP])+sum([o.offshoreConv.nPP]));
        
    end

end
    
if o.design.osComp

    %additional large SS jacket for offshore compensation platform%
    o = addToProcurementRequirements(o, data, 'fndComp', 'hvyJacket', 1);
    o = addToProcurementRequirements(o, data, 'fndComp', 'pinPile', o.offshoreCP.nPP);

end