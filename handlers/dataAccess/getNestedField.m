function val = getNestedField(obj, field)

%determine remaining field sub-levels%
nestLevel = numel(strfind(field,'.'));

if nestLevel == 0
    
    %get field value%
    val = obj.(field);
    
else
    
    %split field to get category%
    [cat, rem] = strtok(field, '.');
   
    %remaining fields% 
    field = rem(2:end);
    
    %recursive call for next field and category%
    val = getNestedField(obj.(cat), field);
       
end