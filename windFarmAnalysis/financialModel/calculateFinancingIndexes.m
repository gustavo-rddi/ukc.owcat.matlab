function o = calculateFinancingIndexes(o, data, CF, leveragedInvestment, CFADS)

CFADS = CFADS .* (CF.t >= 0) .* (CF.t < o.finance.nDebt);

debtTotal = max(cumsum(CF.nom.debtFinance));

o.finance.fDebt = debtTotal/sum(leveragedInvestment);

o.finance.DSCR = -CFADS./(CF.nom.debtFinance + CF.nom.opInterest + eps);
o.finance.DSCRmin = min(o.finance.DSCR);

if o.finance.refin
    iRepayment = o.finance.iDebtRe;
else
    iRepayment = o.finance.iDebtCon;
end

fDisc = (1 + iRepayment).^-CF.t;

o.finance.LLCR = sum(CFADS.*fDisc)/debtTotal;

if o.finance.fDebt == data.econ.fDebtMax
    o.finance.limit = 'gearing';
else
    o.finance.limit = 'DSCR';
end