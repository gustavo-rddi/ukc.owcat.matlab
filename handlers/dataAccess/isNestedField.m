function check = isNestedField(obj, field)

if isstruct(obj)

    %determine remaining field sub-levels%
    nestLevel = numel(strfind(field,'.'));
    
    if nestLevel == 0
        
        %get field value%
        check = isfield(obj, field);
        
    else
        
        %split field to get category%
        [cat, rem] = strtok(field, '.');
        
        %remaining fields%
        field = rem(2:end);
        
        if isfield(obj, cat)
        
            %recursive call for next field and category%
            check = isNestedField(obj.(cat), field);
            
        else
            
            %missing category%
            check = false;
            
        end
        
    end
    
else
    
    %not a structure%
    check = false;
    
end