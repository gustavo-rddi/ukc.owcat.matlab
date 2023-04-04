function cBSUoS = getBSUoScharge(o, data)

%load BSUoS charge%
cBSUoS = 1.502 / 3.6e9;

%apply CPI inflation modifier%
cBSUoS = cBSUoS * costScalingFactor(o, data, 2013, 'GBP'); 