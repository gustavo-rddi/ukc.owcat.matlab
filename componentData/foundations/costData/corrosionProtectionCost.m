function Cprot = corrosionProtectionCost(o, data, ~, ~)

%cathodic protection [EUR]%
Ccath = 179500;

%apply CPI inflation modifier and currency conversion%
Cprot = Ccath * costScalingFactor(o, data, 2019, 'EUR');
