function o = calculateProjectReturns(o, data, stocVar, markMods)

    if strcmpi(o.finance.type, 'corporate')
        
        o.OWF.IRRproj = o.finance.kHurdle;
        
    else
       
        o.finance.type = 'corporate';
        
        CF = fixedLCOEcashFlows(o, data, stocVar, markMods);
        
        CF = variableLCOEcashFlows(o, CF, data, o.LCOE.real.total, 'real');
        
        o.OWF.IRRproj = fzero(@(X)evaluateProjectIRR(CF, X), 0.1);
        
        o.finance.type = 'project';
        
    end

end

function NPV = evaluateProjectIRR(CF, fDisc)

    CFlist = fieldnames(CF.nom);

    NPV = 0;

    for i = 1 : length(CFlist)

        NPV = NPV + sum(CF.nom.(CFlist{i}) ./ (1 + fDisc).^CF.t);

    end
        
end