function cLF = cableLandfallCost(o, data, nCables, ~, ~)

%cost from Navitus data [GBP]%
cLF = 2350000 * nCables;

%apply CPI inflation modifier and currency conversion%
cLF = cLF * costScalingFactor(o, data, 2018, 'GBP');