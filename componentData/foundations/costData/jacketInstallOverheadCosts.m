function Coverhead = jacketInstallOverheadCosts(o, data, nSupply, ~, ~)

%installation design overhead cost [GBP]%
cInstallEngineering = 1625000 * (nSupply/70)^0.5;

cInstallManagement= 6200000 * (nSupply/70)^0.5;

Coverhead = cInstallEngineering + cInstallManagement;

%apply CPI inflation modifier and currency conversion%
Coverhead = Coverhead * costScalingFactor(o, data, 2019, 'EUR');