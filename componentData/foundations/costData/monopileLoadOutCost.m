function Cload = monopileLoadOutCost(o, data, ~, ~)

%load-out costs%
Cload = 96000;

%apply CPI inflation modifier and currency conversion%
Cload = Cload * costScalingFactor(o, data, 2019, 'EUR');


