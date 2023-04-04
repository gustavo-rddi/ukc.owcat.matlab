function CF = calculateDebtCashFlows(o, data, CF, conCosts)

debt = o.finance.fDebtCon*cumsum(conCosts) .* (CF.t < 0) .* (CF.t > -4);

debtTotal = o.finance.fDebtCon*sum(conCosts);

interest = zeros(1, length(conCosts));
arrangeFees = zeros(1, length(conCosts));
debtDrawdown = zeros(1, length(conCosts));

for i = 1 : data.model.maxIter
    
    arrangeFees(5) = debtTotal * data.econ.fArr;
    
    commFees = (debtTotal - debt) * data.econ.fComm .* (CF.t < 0) .* (CF.t > -4);
    
    interest(2:end) = debt(1:end-1) * o.finance.iDebtCon;
    
    totalInvestment = conCosts + arrangeFees + commFees + interest;
        
    debt = o.finance.fDebtCon*cumsum(totalInvestment) .* (CF.t < 0) .* (CF.t > -4);
    
    for j = 4 + (1 : o.OWF.nComm+2)
        
        debtDrawdown(j) = debt(j) - debt(j-1);
        
    end
    
    newDebtTotal = sum(debtDrawdown);
    
    if abs(newDebtTotal - debtTotal)/debtTotal < data.model.tolConv
        break;
    else
        debtTotal = newDebtTotal;
    end
       
end

o.finance.debtTotal = newDebtTotal;

CF.nom.financingFees = -(arrangeFees + commFees);

if o.finance.refin
    iRepayment = o.finance.iDebtRe;
else
    iRepayment = o.finance.iDebtCon;
end

debtService = o.finance.debtTotal * iRepayment / (1 - (1+iRepayment)^-o.finance.nDebt);

debtRepayment = zeros(1, length(conCosts));

for j = 6 + o.OWF.nComm + (1 : o.finance.nDebt)
   
    interest(j) = debt(j-1) * iRepayment;
    
    debtRepayment(j) = debtService - interest(j);
    
    debt(j) = max(0, debt(j-1) - debtRepayment(j));
    
end

CF.nom.debtFinance = debtDrawdown - debtRepayment;

CF.nom.conInterest = -interest .* (CF.t < 0);
CF.nom.opInterest = -interest .* (CF.t >= 0);