function markMods = generateMarketModifierStructure(dataFields)

if ~isempty(dataFields)
    
    %create structure%
    markMods = struct;
    
    for i = 1 : length(dataFields)
       
        if ~(strcmpi(dataFields{i}{3},'%') || strcmpi(dataFields{i}{3},'-')) || ~strcmpi(dataFields{i}{4},'rel')
        
            %report invalid market modifier data field%
            error('generateMarketModifierStructure: invalid market modifier for field ''%s''', dataFields{i}{1});
        
        else
            
            modVal = 1 + dataFields{i}{2} * SImultiplier(dataFields{i}{3});
            
            markMods = setNestedField(markMods, dataFields{i}{1}, modVal);
            
        end
        
    end
    
else
    
    %no modifiers%
    markMods = [];
    
end