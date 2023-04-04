function obj = setNestedField(obj, field, val)

%determine remaining field sub-levels%
nestLevel = numel(strfind(field,'.'));

if nestLevel == 0
    
    %set field value%
    obj.(field) = val;
            
else
    
    %split field to get category%
    [cat, rem] = strtok(field, '.');
    
    %remaining fields%
    field = rem(2:end);
    
    if ~isfield(obj, cat)
        
        %add new category%
        obj.(cat) = struct;
        
    end
    
    %recursive call for next field and category%
    obj.(cat) = setNestedField(obj.(cat), field, val);
        
end
    