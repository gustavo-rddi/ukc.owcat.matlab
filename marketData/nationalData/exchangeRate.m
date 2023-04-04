function fExch = exchangeRate(data, outCurr, dataCurr)

if strcmpi(outCurr, dataCurr)
    
    fExch = 1;
    
else
    
    fExch = data.exch.(dataCurr).(outCurr);
    
end