function Cpre = WTGpreassemblyCost(o, data, Nturb, ~, ~)

%pre-assembley/pre-commissioning [GBP]%
Cpre = 345000 * Nturb;

%apply CPI inflation modifier%
Cpre = Cpre * costScalingFactor(o, data, 2020, 'GBP');%2014 originally