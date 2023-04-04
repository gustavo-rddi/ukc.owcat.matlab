function CF = calculateDepreciationReserve(o, data, CF, decomCosts)

totalCosts = sum(decomCosts);

annualPayment = sum(decomCosts)/data.WTG.nOper;