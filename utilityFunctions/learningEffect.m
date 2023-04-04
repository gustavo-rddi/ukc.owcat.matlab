function eff = learningEffect(N, Nref, LR)

%calculate learning effect%
eff = (N/Nref)^(log(1-LR)/log(2));