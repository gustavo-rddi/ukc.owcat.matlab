function CF = calculateDecommissioningReserve(o, data, CF, decomCosts)

annualPayments = sum(decomCosts)/data.econ.yrDRA * (CF.t >= (o.OWF.nOper-data.econ.yrDRA)) .* (CF.t < o.OWF.nOper);

accountDrawdown = decomCosts;

CF.nom.decomReserve = accountDrawdown - annualPayments;

accountBalance = cumsum([0, annualPayments(1:end-1)]) - cumsum(accountDrawdown);

CF.nom.intIncome = data.econ.iRes * accountBalance;