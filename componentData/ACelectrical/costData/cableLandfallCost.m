function cLF = cableLandfallCost(o, data, nCables, ~, ~)

%landfall cost per cable from FCOW 2021%

cLF = 4000000 * nCables;

%apply CPI inflation modifier and currency conversion%
cLF = cLF * costScalingFactor(o, data, 2021, 'EUR');

end