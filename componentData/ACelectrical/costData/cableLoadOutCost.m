function Cload = cableLoadOutCost(o, data, lCable, ~, ~)

%estimation of cable load out costs%
Cload = 20.5*lCable; 

%apply CPI inflation modifier%
Cload = Cload * costScalingFactor(o, data, 2019, 'EUR');
