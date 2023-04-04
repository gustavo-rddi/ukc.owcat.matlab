function CF = debtScuplting(o, data, CF, investment, CFADS)

CFADS = CFADS .* (CF.t >= 0) .* (CF.t < o.finance.nDebt);

DSCR = max(data.econ.DSCRtarg, sum(CFADS)/(data.econ.fDebtMax*sum(investment) - sum(CF.nom.opInterest)));

principal = CFADS/DSCR + CF.nom.opInterest;

gearing = sum(principal)/sum(investment);

debt = gearing*cumsum(investment) .* (CF.t < 0) .* (CF.t > -4);

debtTotal = gearing*sum(investment);

arrangeFees = generateCashFlow(o, data, debtTotal * data.econ.fArr, 'AtFID');
    
commFees = (debtTotal - debt) * data.econ.fComm .* (CF.t < 0) .* (CF.t > -4);

CF.nom.financingFees = -(arrangeFees + commFees);
 
if o.finance.refin
    iRepayment = o.finance.iDebtRe;
else
    iRepayment = o.finance.iDebtCon;
end

for i = 6 + o.OWF.nComm + (1 : o.finance.nDebt)
    
    debt(i) = debt(i-1) - principal(i);
    
end

CF.nom.debtFinance = debt - [0 debt(1:end-1)];

CF.nom.opInterest = -[0, debt(1:end-1)] * iRepayment .* (CF.t >= 0) .* (CF.t < data.WTG.nOper);
CF.nom.conInterest = -[0 debt(1:end-1)] * o.finance.iDebtCon .* (CF.t < 0) .* (CF.t > -4);