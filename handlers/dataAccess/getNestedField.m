function val = getNestedField(obj, field)

% ---
% strfind(x,a) finds all the occurences of a in x
% numel counts how many times a was found in x
% in other words, this counts how many 'sub-levels' the field
% has as indicated by the character '.'
% ---

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