function seabedRent = calculateSeabedRent(o, opRevenue, t, data)

%determine real-to-nominal conversion factors%
fNom = arrayfun(@(X)CPImodifier(data, X, data.econ.(o.OWF.loc).yrReal, data.econ.(o.OWF.loc).curr), o.OWF.yrOper + t);

switch upper(o.OWF.loc)
    
    case 'UK'
        
        seabedRent = data.econ.UK.SBlease * max(0, opRevenue) ...
                   + data.econ.UK.mitFees * o.OWF.cap * fNom;
               
    case 'FR'
        
        seabedRent = data.econ.FR.OWtax * o.OWF.cap * fNom;
        
end

seabedRent = seabedRent .* (t >= 0) .* (t < data.WTG.nOper);