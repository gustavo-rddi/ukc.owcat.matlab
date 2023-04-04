function fInfl = CPImodifier(data, yearCost, yearRef, curr)

if yearCost == yearRef
    fInfl = 1;
else
    fInfl = calcCPI(yearCost, curr, data) / calcCPI(yearRef, curr, data);
end

end

function CPI = calcCPI(year, curr, data)

if year > max(data.CPI.year)
    
    infl = (data.CPI.(curr)(end)/data.CPI.(curr)(1))^(1/(length(data.CPI.(curr))-1));
    
    CPI = data.CPI.(curr)(end) * (infl^(year - max(data.CPI.year)));
    
elseif year < min(data.CPI.year)
    
    infl = (data.CPI.(curr)(end)/data.CPI.(curr)(1))^(1/(length(data.CPI.(curr))-1));
    
    CPI = data.CPI.(curr)(1) / (infl^(min(data.CPI.year) - year));
    
else
    
    CPI= data.CPI.(curr)(data.CPI.year == year);
    
end

end