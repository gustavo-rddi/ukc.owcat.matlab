function depreStream = calculateDepreciation(o, vAsset, t, data)

switch upper(o.OWF.loc)
    
    case 'UK'
        
        depreStream = data.econ.UK.CArate * (1-data.econ.UK.CArate).^t * vAsset .* (t >= 0) .* (t < data.WTG.nOper);
        
    case 'FR'

        depreRate = data.econ.FR.accDepr/data.WTG.nOper;
        
        depreStreamDB = depreRate * (1-depreRate).^t * vAsset .* (t >= 0) .* (t < data.WTG.nOper);
        
        eqSLdepre = (1-depreRate).^t * vAsset ./ (data.WTG.nOper - t) .* (t >= 0) .* (t < data.WTG.nOper);
        
        iSwitch = find(eqSLdepre > depreStreamDB, 1, 'first');
        
        depreStream = max(depreStreamDB, eqSLdepre(iSwitch)) .* (t >= 0) .* (t < data.WTG.nOper);
        
end