function [p, LR] = findLRfit(cost, capacity)

    aGuess = log(min(cost)/max(cost)) / log(max(capacity)/min(capacity));
    
    bGuess = log(max(cost)) - log(min(capacity));

    p = fminsearch(@(X)LRfit(cost, capacity, X), [aGuess, bGuess]);

    LR = 1 - exp(p(1)*log(2));
    
end

function res = LRfit(cost, capacity, X)

costCalc = exp(X(1)*log(capacity) + X(2));

res = sqrt(sum((cost - costCalc).^2));

end