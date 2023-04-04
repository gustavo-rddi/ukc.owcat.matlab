function o = applyProjectModifiers(o, projMods)

%Transfer external information into the model-GBF
for i = 1 : numel(projMods)
 %find GBF structure %
    if any(strfind(projMods{i}{1}, 'GBF'))
        o.GBF=projMods{i}{2};
    end
end



%current number of zones%
currZones = numel(o.zone);

for i = 1 : numel(projMods)
   
    %find any modifiers to zone properties%
    if any(strfind(projMods{i}{1}, 'zone'))
        
        if ~exist('newZones', 'var') || (newZones == 1 && numel(projMods{i}{2}) ~= 1)
            
            %new number of zones%
            newZones = numel(projMods{i}{2});
            
        elseif (numel(projMods{i}{2}) ~= newZones) && (numel(projMods{i}{2}) ~= 1)
            
            %report multiple inconsistant zone number changes%
            error('applyZoneChanges: inconsistant number of zones defined');
            
        end
        
    end
    
end

if exist('newZones', 'var')

    while newZones > currZones
        
        %add new zones based on last zone%
        o.zone(currZones+1) = o.zone(currZones);
        currZones = currZones + 1;
        
    end
    
    while newZones < currZones
        
        %remove excess zones%
        o.zones(currZones) = [];
        currZones = currZones - 1;
        
    end

end

for i = 1 : numel(projMods)
   
    if any(strfind(projMods{i}{1}, 'zone'))
        
        %split field to remove zone category%
        [~, rem] = strtok(projMods{i}{1}, '.');
        
        %remaining fields%
        field = rem(2:end);
        
        for j = 1 : currZones
            
            if numel(projMods{i}{2}) == 1
                
                %iterate through zones and apply common modifier%
                o.zone(j) = modifyField(o.zone(j), field, projMods{i}{2}, projMods{i}(3:end));
                
            else
            
                %iterate through zones and apply zone-specific modifier%
                o.zone(j) = modifyField(o.zone(j), field, projMods{i}{2}(j), projMods{i}(3:end));
                
            end
                
        end
       
    else
        
        %apply any other non-zone related modifiers%
        o = modifyField(o, projMods{i}{1}, projMods{i}{2}, projMods{i}(3:end));
        
    end
    
end