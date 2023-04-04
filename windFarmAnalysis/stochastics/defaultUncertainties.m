function stocVar = defaultUncertainties()

stocVar.nSamples = 20;

stocVar.nDisp = 10;

stocVar.distr.windSpeed.mean = {'normal','sigma',0.09};
stocVar.distr.windSpeed.yearly = {'normal','sigma',0.06,'yearly'};

stocVar.distr.WTG.cost = {'triangular',[-0.05, +0.10]};

stocVar.distr.MP.mass = {'lognormal','sigma',0.3033};
stocVar.distr.TP.mass = {'lognormal','sigma',0.2913};

stocVar.distr.JKT.mass = {'lognormal','sigma',0.1814};
stocVar.distr.PP.mass = {'lognormal','sigma',0.1927};