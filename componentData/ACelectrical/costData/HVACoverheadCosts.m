function Coverhead = HVACoverheadCosts(o, data, nOSS, ~, ~)

%design of electrical system [EUR]%
Coverhead = 5200000 * (nOSS/2)^0.5;

%apply CPI inflation modifier%
Coverhead = Coverhead * costScalingFactor(o, data, 2019, 'EUR');