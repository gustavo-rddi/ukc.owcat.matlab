function Coverhead = WTGinstallOverheadCosts(o, data, nSupply, ~, ~)

%installation overhead cost [GBP]%
Coverhead = 9582000 * (nSupply/70)^0.5;

%apply CPI inflation modifier and currency conversion%
Coverhead = Coverhead * costScalingFactor(o, data, 2020, 'GBP');