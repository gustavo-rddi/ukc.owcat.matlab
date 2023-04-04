function exch = exchangeRateData()

exch.EUR.GBP = 0.8528;  %0.885
exch.DKK.GBP = 0.112971;  

exch.EUR.DKK = exch.EUR.GBP/exch.DKK.GBP;

exch.GBP.EUR = 1/exch.EUR.GBP;
exch.GBP.DKK = 1/exch.DKK.GBP;
exch.DKK.EUR = 1/exch.EUR.DKK;


