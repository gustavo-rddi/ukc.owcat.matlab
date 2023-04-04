function fWake = WTGwakeLosses(nWTG, fSpace)

fWake = (8.257e-5)*(nWTG - 1) + (0.9506)*(fSpace^-1.2176)*(1 - exp(-0.2920*((nWTG - 1).^0.5597)/(fSpace^0.2061)));

fWake = fWake .* double(nWTG > 1);