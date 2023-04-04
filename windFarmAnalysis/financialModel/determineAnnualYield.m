function annYield = determineAnnualYield(o, t, data)

%determine annual yield (with degradation)%
annYield = o.OWF.AEPnet .* (1 - data.WTG.fDegr).^max(0, t) .* (t >= 0) .* (t < data.WTG.nOper);

annYield(6+(2:(o.OWF.nComm))) = 2*(1:(o.OWF.nComm-1))/(2*o.OWF.nComm - 1) * o.OWF.AEPnet;
annYield(7) = (1/2)/(2*o.OWF.nComm - 1) * o.OWF.AEPnet;

