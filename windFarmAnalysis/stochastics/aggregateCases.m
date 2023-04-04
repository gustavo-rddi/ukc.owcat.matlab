function oStoc = aggregateCases(oStoc, oCase, nCase)

for i = 1 : length(oStoc.stocFields)
   
    stocVal = getNestedField(oStoc, oStoc.stocFields{i});
    caseVal = getNestedField(oCase, oStoc.stocFields{i});
   
    stocVal(nCase,:) = caseVal;
    
    oStoc = setNestedField(oStoc, oStoc.stocFields{i}, stocVal);
    
end