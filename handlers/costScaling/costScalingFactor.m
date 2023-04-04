function fScale = costScalingFactor(o, data, yearRef, currRef)

fScale = exchangeRate(data, data.econ.(o.OWF.loc).curr, currRef) ...
       * CPImodifier(data, data.econ.(o.OWF.loc).yrReal, yearRef, data.econ.(o.OWF.loc).curr);
                