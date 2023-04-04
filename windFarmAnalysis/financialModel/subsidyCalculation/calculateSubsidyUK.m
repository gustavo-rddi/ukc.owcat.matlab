function o = calculateSubsidyUK(o, data, stocVar, markMods)

%use simple LCOE as first-guess value%
Pguess = getLCOEestimate(o, data);

o.Pstrike.CF = fixedPstrikeCashFlows(o, data, stocVar, markMods);

%calculate nominal LCOE values and strike prices%
o.Pstrike.value = fzero(@(x)evaluateProjectNPV(o, o.Pstrike.CF, data, x, 'Pstrike'), Pguess);

o.Pstrike.CF = variablePstrikeCashFlows(o, o.Pstrike.CF, data, o.Pstrike.value);

switch lower(o.finance.type)
    
    case 'corporate'; fDisc = o.finance.kHurdle;
    case 'project'; fDisc = o.finance.MARR;
        
end

subFields = fieldnames(o.Pstrike.CF.nom);

o.Pstrike.CF.nom.total = 0;
o.Pstrike.CF.real.total = 0;

for i = 1 : length(subFields)
    
    o.Pstrike.CF.nom.total = o.Pstrike.CF.nom.total + o.Pstrike.CF.nom.(subFields{i});
    o.Pstrike.CF.real.total = o.Pstrike.CF.real.total + o.Pstrike.CF.real.(subFields{i});
    
end

o.Pstrike.CF.nom.discTotal = o.Pstrike.CF.nom.total ./ (1 + fDisc).^o.LCOE.CF.t;