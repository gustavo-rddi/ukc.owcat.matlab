function CF = calculateOFTOcashFlows(o, CF, investOFTO, data)

%determine real-to-nominal conversion factors%
fNom = arrayfun(@(X)CPImodifier(data, X, data.econ.(o.OWF.loc).yrReal, data.econ.(o.OWF.loc).curr), o.OWF.yrOper + CF.t);

IDCcapOFTO = cumsum(investOFTO) * data.econ.UK.IDCcap .* (CF.t < -o.OWF.nComm);

etvOFTO = sum(investOFTO + IDCcapOFTO);

CF.nom.OFTOfee = -0.8*(4.26e6 + 0.076*etvOFTO) * fNom .* (CF.t >= 0) .* (CF.t < data.WTG.nOper);

CF.nom.OFTOsale = zeros(size(CF.t));
CF.nom.OFTOsale(CF.t == 0) = etvOFTO;