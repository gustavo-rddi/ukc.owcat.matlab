function o = calculateLCOEvalues(o, data, stocVar, markMods) 

%get first-guess simple LCOE value%
LCOEguess = getLCOEestimate(o, data);

o.LCOE.CF = fixedLCOEcashFlows(o, data, stocVar, markMods);

% test
% npv = evaluateProjectNPV(o,o.LCOE.CF,data,LCOEguess,'LCOE','real');

%calculate nominal LCOE values and strike prices%
o.LCOE.nom.total = fzero(@(x)evaluateProjectNPV(o, o.LCOE.CF, data, x, 'LCOE', 'nom'), LCOEguess);
o.LCOE.real.total = fzero(@(x)evaluateProjectNPV(o, o.LCOE.CF, data, x, 'LCOE', 'real'), LCOEguess);

%generate revenue-dependent cash flows (in real and nominal terms)%
CFnom = variableLCOEcashFlows(o, o.LCOE.CF, data, o.LCOE.nom.total, 'nom');
CFreal = variableLCOEcashFlows(o, o.LCOE.CF, data, o.LCOE.real.total, 'real');

o.LCOE.CF.nom = CFnom.nom;
o.LCOE.CF.real = CFreal.real;

switch lower(o.finance.type)
    
    case 'corporate'; fDisc = o.finance.kHurdle;
    case 'project'; fDisc = o.finance.MARR;
        
end

LCOEfields = fieldnames(o.LCOE.CF.nom);

o.LCOE.CF.nom.total = 0;
o.LCOE.CF.real.total = 0;

for i = 1 : length(LCOEfields)
    
    if ~strcmpi(LCOEfields{i}, 'elecSale')
        
        fSplit = -sum(CFnom.nom.(LCOEfields{i}) ./ (1 + fDisc).^o.LCOE.CF.t) / sum(CFnom.nom.elecSale ./ (1 + fDisc).^o.LCOE.CF.t);
        
        o.LCOE.nom.(LCOEfields{i})  = o.LCOE.nom.total * fSplit;
        o.LCOE.real.(LCOEfields{i}) = o.LCOE.real.total * fSplit;
        
    end
    
    o.LCOE.CF.nom.total = o.LCOE.CF.nom.total + o.LCOE.CF.nom.(LCOEfields{i});
    o.LCOE.CF.real.total = o.LCOE.CF.real.total + o.LCOE.CF.real.(LCOEfields{i});
    
end

o.LCOE.CF.nom.discTotal = o.LCOE.CF.nom.total ./ (1 + fDisc).^o.LCOE.CF.t;