function stocValAv = averagedVariability(stocVal, nEvent)

%determine variability of average value%
stocValAv = 1 + (stocVal-1)/sqrt(nEvent);    