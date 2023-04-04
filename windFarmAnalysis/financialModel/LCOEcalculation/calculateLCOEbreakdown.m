function o = calculateLCOEbreakdown(o, ~)

switch lower(o.finance.type)
    
    case 'corporate'; fDisc = o.finance.WACC;
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