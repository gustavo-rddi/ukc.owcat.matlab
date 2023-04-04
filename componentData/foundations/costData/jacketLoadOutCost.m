function Cload = jacketLoadOutCost(o, data, ~, ~)

%jacket load-out costs [EUR]%
Cload = 192000;

%apply CPI inflation modifier and currency conversion%
Cload = Cload * costScalingFactor(o, data, 2019, 'EUR');