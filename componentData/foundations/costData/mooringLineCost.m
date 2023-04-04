function Cmoor = mooringLineCost(o, data, lMoor, nAnch, anchType, stocVar, markMods)

Cmoor = lMoor * 2350 * costScalingFactor(o, data, 2020, 'EUR') ...
      + nAnch * data.(anchType).cost * costScalingFactor(o, data, 2020, 'EUR');%2013 originally, update cost