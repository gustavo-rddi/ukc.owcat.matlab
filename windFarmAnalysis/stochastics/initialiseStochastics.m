function [oStoc, data] = initialiseStochastics(oStoc, oCase, data, stocVar)

%inform of current operation%
%message(oStoc, 'Preparing for Stochastic Evaluation...', 'stoc', 1);

oStoc.stocFields = checkChangedFields(oStoc, oCase, []);

for i = 1 : length(oStoc.stocFields)

    fieldVal = getNestedField(oCase, oStoc.stocFields{i});
   
    newField = zeros(stocVar.nSamples, numel(fieldVal));
    
    newField(1,:) = fieldVal;
    
    oStoc = setNestedField(oStoc, oStoc.stocFields{i}, newField);
    
end

createStochasticsHeader(oStoc, data);

end

function nameList = checkChangedFields(orig, comp, nameList, rootField)

if nargin < 4
    
    rootField = '';
    
else
    
    rootField = strcat(rootField, '.');
    
end

dataFields = fieldnames(orig);

for i = 1 : numel(dataFields)
    
    if ~isequal(orig.(dataFields{i}),comp.(dataFields{i}))
   
        if isstruct(orig.(dataFields{i}))
            
             if numel(orig.(dataFields{i})) == 1
            
                nameList = checkChangedFields(orig.(dataFields{i}), comp.(dataFields{i}), nameList, strcat(rootField,dataFields{i}));
                
             end
        
        else
            
            if isempty(nameList)
                
                nameList = {strcat(rootField,dataFields{i})};
                
            else
                
                nameList{numel(nameList)+1} = strcat(rootField,dataFields{i});
                
            end
        
        end
            
    end
    
end

end

function createStochasticsHeader(o, data)

fprintf(1, ' +-------+---------------------+---------------------+---------------------+---------+\n');
fprintf(1, ' |  No.  |   CAPEX [%3s/kW]    |   OPEX [%3s/kWyr]   |   LCOE [%3s/MWh]    |  Speed  |\n', data.econ.(o.OWF.loc).curr, data.econ.(o.OWF.loc).curr, data.econ.(o.OWF.loc).curr);
fprintf(1, ' | Cases |  P50   P90   Ratio  |  P50   P90   Ratio  |  P50   P90   Ratio  |  [#/h]  |\n');
fprintf(1, ' +-------+---------------------+---------------------+---------------------+---------+\n');

end
