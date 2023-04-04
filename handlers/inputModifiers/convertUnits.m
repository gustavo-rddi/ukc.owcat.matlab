function obj = convertUnits(obj)

%get current object fields%
dataFields = fieldnames(obj);

for i = 1 : length(dataFields)

    for j = 1 : numel(obj)
    
        if isstruct(obj(j).(dataFields{i}))
        
            %recursive call for nested fields%
            obj(j).(dataFields{i}) = convertUnits(obj(j).(dataFields{i}));
        
        elseif iscell(obj(j).(dataFields{i}))
   
            %apply SI multiplier to convert to standard units%
            obj(j).(dataFields{i}) = obj(j).(dataFields{i}){1} * SImultiplier(obj(j).(dataFields{i}){2});
                
        end
        
    end
    
end


