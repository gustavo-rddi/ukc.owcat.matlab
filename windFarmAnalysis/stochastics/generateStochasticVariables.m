function val = generateStochasticVariables(o, ~, stocVal)

if numel(stocVal) > 3
    
    if ischar(stocVal{4}) && strcmpi(stocVal{4}, 'yearly')
        
        nVal = o.OWF.nProj;
        valType = 'vector';
        
    end
   
else
    
    nVal = 1;
    valType = 'single';
    
end

switch lower(stocVal{1})
    
    case 'normal'; val = normalVariable(stocVal, nVal);

    case 'lognormal'; val = logNormalVariable(stocVal, nVal);
        
    case 'triangular'; val = triangularVariable(stocVal, nVal);
        
end

if strcmpi(valType, 'average')
    
    val = mean(val);
    
end

end

%%------LOCAL-FUNCTIONS--------------------------------------------------%%

function val = normalVariable(stocVal, nVal)

switch lower(stocVal{2})
    
    case 'sigma'; sigma = stocVal{3};
        
    case 'p90'; sigma = abs(stocVal{3})/(sqrt(2)*erfinv(2*0.9 - 1));
        
end

val = 1 + sqrt(2)*sigma*erfinv(2*rand(1,nVal) - 1);

end

function val = logNormalVariable(stocVal, nVal)

switch lower(stocVal{2})
    
    case 'sigma'; sigma = stocVal{3};
        
    case 'p90'; sigma = abs(log(1+stocVal{3}))/(sqrt(2)*erfinv(2*0.9 - 1));
        
end

val = exp(sqrt(2)*sigma*erfinv(2*rand(1,nVal) - 1));

end

function val = triangularVariable(stocVal, nVal)

a = stocVal{2}(1);
b = stocVal{2}(2);

P = rand(1,nVal);

val = (1 + a + sqrt(a*(a-b)*P)) .* (P < a/(a - b)) ...
    + (1 + b - sqrt(b*(b-a)*(1 - P))) .* (P > a/(a - b)) ...
    + (P == a/(a - b));

end