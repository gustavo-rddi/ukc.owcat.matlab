function cPM = projectManagementCosts(o, data, capOWF, nPos, ~, ~)

cMan = 30e6 * (capOWF/560e6)^0.5;

cSV = 19e6 * (nPos/72)^0.5;

cPM = (cMan + cSV) * costScalingFactor(o, data, 2019, 'GBP');