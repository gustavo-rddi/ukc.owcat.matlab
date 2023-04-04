function obj = modifyField(obj, field, newVal, unitData)

if nargin < 4; unitData = []; end

%get current content of object field%
currField = getNestedField(obj, field);
    
if numel(unitData) == 2
    
    if isa(currField, 'string')
    
        error('applyModifiers: attempting to apply comparative modifier to string field ''%s''', field);
    
    elseif strcmpi(unitData{2}, 'rel')
        
        if strcmpi(unitData{1}, '-')
                
            fMod = 1 + newVal;
                
        elseif strcmpi(unitData{1}, '%')
                
            fMod = 1 + newVal/100;
            
        else
                
            error('applyModifiers: invalid relative modification type ''%s''', unitData{1});
                
        end
                        
        if iscell(currField)
            
            newField = currField;
            
            newField{1} = newField{1} * fMod;
            
        else
            
            newField = currField * fMod;
            
        end

    elseif strcmpi(unitData{2}, 'abs')
        
        if iscell(currField)
        
            if strcmpi(unitData{1}, currField{2})
                
                newField = currField;
            
                newField{1} = newField{1} + newVal;
   
            else
                
                error('applyModifiers: mismatched units [%s] and [%s] for absolute modification', unitData{1}, currField{2});
                
            end
            
        else
            
            if strcmpi(unitData{1}, '-')
            
                newField = currField + newVal;
                
            else
                
                warning('OWCAT:unitChange', 'adding units [%s] to field ''%s'', check consistancy', unitData{1}, field);
                
                newField{1} = currField + newVal;
                newField{2} = unitData{1};
                
            end
            
        end
            
    else
        
        error('applyModifiers: invalid comparative modification type');
            
    end
    
elseif numel(unitData) == 1
    
    if isa(currField, 'string')
    
        error('applyModifiers: changing string field ''%s'' to numerical field', field);
    
    elseif ~iscell(currField)
        
        warning('OWCAT:unitChange', 'adding units [%s] to field ''%s'', check consistancy', unitData{1}, field);
        
    elseif ~strcmpi(unitData{1}, currField{2})
        
        warning('OWCAT:unitChange', 'changing units from [%s] to [%s] for field ''%s'', check consistancy', currField{2}, unitData{1}, field);
        
    end
    
    newField = {newVal, unitData{1}};
    
else
    
    if iscell(currField)
            
       newField{1} = newVal;
            
       warning('OWCAT:unitChange', 'modification to ''%s'' supplied without unit, default unit is [%s], check consistancy', field, currField{2});
            
    elseif iscell(newVal)
        
        newField = newVal{1};
        
    else
            
        newField = newVal;
            
    end
    
end

obj = setNestedField(obj, field, newField);