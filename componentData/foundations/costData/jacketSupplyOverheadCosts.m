function Coverhead = jacketSupplyOverheadCosts(o, data, nSupply, ~, ~)

%design of jacket foundation structuresn [EUR]%
cJacketDesign = 5461000 * (nSupply/70)^0.5;

%supply and jacket construction management [EUR]%
cSupplyManagement = 4961500 * (nSupply/70)^0.5;

%sum overhead costs%
Coverhead = cJacketDesign + cSupplyManagement;

%apply CPI inflation modifier and currency conversion%
Coverhead = Coverhead * costScalingFactor(o, data, 2019, 'EUR');