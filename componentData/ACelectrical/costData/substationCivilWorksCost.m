function cCivil = substationCivilWorksCost(o, data, capSS, ~, ~)

%civil engineering costs [GBP]%
cCivil = 6100000*(capSS/640e6)^0.65;

%apply CPI inflation modifier%
cCivil = cCivil * costScalingFactor(o, data, 2018, 'GBP');