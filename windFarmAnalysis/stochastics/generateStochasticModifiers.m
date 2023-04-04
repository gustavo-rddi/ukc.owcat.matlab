function stocVar = generateStochasticModifiers(o, data, mode, stocVar)

if strcmpi(mode, 'setup')
    
    %load stochastic distributions%
    stocVar = defaultUncertainties;
    
    %build list of all stochastic variable fields during setup%
    stocVar.stocFields = buildStochasticVariableList(stocVar.distr);
    
elseif strcmpi(mode, 'uncorrelated')
    
    for i = 1 : numel(stocVar.stocFields)
        
        %get distribution parameters of current stochastic variable%
        distrParams = getNestedField(stocVar.distr, stocVar.stocFields{i});
        
        %generate new modifier based on distribution parameters%
        stocVal = generateStochasticVariables(o, data, distrParams);
        
        %set new value of stochastic variable%
        stocVar = setNestedField(stocVar, stocVar.stocFields{i}, stocVal);

    end
        
end

end

%%------LOCAL-FUNCTIONS--------------------------------------------------%%

function nameList = buildStochasticVariableList(stocDistr, nameList, rootField)

if nargin < 2; nameList = []; end;

if nargin < 3
    
    %start-point%
    rootField = '';
    
else
    
    %increment structure level%
    rootField = strcat(rootField, '.');
    
end

%get fieldnames for structure%
dataFields = fieldnames(stocDistr);

for i = 1 : numel(dataFields)
    
    if isstruct(stocDistr.(dataFields{i}))

        %recursive call to function at next structure level%
        nameList = buildStochasticVariableList(stocDistr.(dataFields{i}), nameList, strcat(rootField,dataFields{i}));

    else
            
        if isempty(nameList)
            
            nameList = {strcat(rootField,dataFields{i})};
            
        else
            
            nameList{numel(nameList)+1} = strcat(rootField,dataFields{i});
            
        end
        
    end
    
end

end