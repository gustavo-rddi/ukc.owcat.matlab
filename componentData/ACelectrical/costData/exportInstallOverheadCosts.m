function Coverhead = exportInstallOverheadCosts(o, data, nCables, ~, ~)

%installation design overhead cost [GBP]%
cInstallEngineering = 500000 * (nCables/2)^0.5;

cInstallManagement = 2000000 * (nCables/2)^0.5;

Coverhead = cInstallEngineering + cInstallManagement;

%apply CPI inflation modifier and currency conversion%
Coverhead = Coverhead * costScalingFactor(o, data, 2019, 'GBP');
