function fLoad = genericPowerCurve(vWind, dRot, Prate, vIn, vOut, rho, effBetz)

if nargin < 6; rho = 1.225; end
if nargin < 7; effBetz = 0.75; end

Adisc = pi*(dRot/2)^2;

Pwind = rho*Adisc*(vWind.^3)/2;

Ploss = (16/27)*effBetz*rho*Adisc*(vIn^3)/2;

Pgen = min(Prate, max(0, (16/27)*effBetz*Pwind-Ploss)) .* (vWind <= vOut);

fLoad = Pgen/Prate;