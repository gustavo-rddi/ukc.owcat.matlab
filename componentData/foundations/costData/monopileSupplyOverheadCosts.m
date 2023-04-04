function Coverhead = monopileSupplyOverheadCosts(o, data, nSupply, ~, ~)

%design of monopile foundation [EUR]%
cMonopileDesign = 2730000 * (nSupply/70)^0.5;

%supply and monopile construction management [EUR]%
cSupplyManagement = 1653800 * (nSupply/70)^0.5;

%sum overhead costs%
Coverhead = cMonopileDesign + cSupplyManagement;

%apply CPI inflation modifier and currency conversion%
Coverhead = Coverhead * costScalingFactor(o, data, 2019, 'EUR');