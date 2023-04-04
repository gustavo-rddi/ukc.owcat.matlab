function cPorts = harbourUpgradeCosts(o, data, nWTG, ~, ~)

cPorts = 25e6 * (nWTG/70)^0.5;

cPorts = cPorts * costScalingFactor(o, data, 2019, 'GBP');