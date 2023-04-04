function Coverhead = undergroundCableOverheadCost(o, data, nCables, ~, ~)

%installation design overhead cost [GBP]%
Coverhead = 2475000 * (nCables/2)^0.5;

%apply CPI inflation modifier%
Coverhead = Coverhead * costScalingFactor(o, data, 2018, 'GBP');
