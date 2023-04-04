function Coverhead = arrayInstallOverheadCosts(o, data, nSect, ~, ~)

%installation design overhead cost [GBP]%
cInstallEngineering = 1126500 * (nSect/74)^0.5;

cInstallManagement = 2387000 * (nSect/74)^0.5;

Coverhead = cInstallEngineering + cInstallManagement;

%apply CPI inflation modifier and currency conversion%
Coverhead = Coverhead * costScalingFactor(o, data, 2019, 'GBP');