function fWake = WTGwakeLosses(cap, nWTG, fSpace)

% if cap <15000000
    
fWake = (8.257e-5)*(nWTG - 1) + (0.9506)*(fSpace^-1.2176)*(1 - exp(-0.2920*((nWTG - 1).^0.5597)/(fSpace^0.2061)));

% elseif cap >=15000000 %changes made to original model based on FCOW21 wake losses%
%     
% fWake = (8.000e-5)*(nWTG - 1) + (0.368)*(fSpace^-1.2176)*(1 - exp(-0.2920*((nWTG - 1).^0.5597)/(fSpace.^0.2061)));
% 
% end

fWake = fWake .* double(nWTG > 1);