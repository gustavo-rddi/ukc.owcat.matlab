function o = applyProjectModifiers(o, projMods)

% -----------
% Note sure what GBF is and I cannot find it in code or worksheets
% needs clarification.
% -----------

%Transfer external information into the model-GBF
for i = 1 : numel(projMods)
 %find GBF structure %
    if any(strfind(projMods{i}{1}, 'GBF'))
        o.GBF=projMods{i}{2};
    end
end

% -----------
% check the number of zones loaded in defaultProjectSpecifications.m
% currently, 1 zone is the default
% -----------

%current number of zones%
currZones = numel(o.zone);

for i = 1 : numel(projMods)
   
    %find any modifiers to zone properties%
    if any(strfind(projMods{i}{1}, 'zone'))
        
        % -----------
        % if the variable newZones does not exist, or if it exists and is 1 but the number
        % of values for the current property is more than 1, then set newZones to the number
        % of values for the curernt property. This means, how many 'projects' are being 
        % considered from the excel file. The way the code is right now, this is always 1 project
        % at a time. This condition always occurs.
        % -----------
        if ~exist('newZones', 'var') || (newZones == 1 && numel(projMods{i}{2}) ~= 1)
            
            %new number of zones%
            newZones = numel(projMods{i}{2});
            
        elseif (numel(projMods{i}{2}) ~= newZones) && (numel(projMods{i}{2}) ~= 1)
            
            % -----------
            % if some properties have more elements than others, in other words, if for some
            % rows in the excel file I read more columns than for others, this is an error
            % because all properties should exist for each project.
            % this is just checking for consistency.
            % -----------

            %report multiple inconsistant zone number changes%
            error('applyZoneChanges: inconsistant number of zones defined');
            
        end
        
    end
    
end

% -----------
% this always occurs
% -----------
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

    % -----------
    % currZones is now the number (int) of total zones (projects) under consideration
    % -----------
end

for i = 1 : numel(projMods)
   
    if any(strfind(projMods{i}{1}, 'zone'))
        
        % -----------
        % split by the first '.' found, this is similar to string.split('.') in python
        % e.g. in 'zone.cap', the function below returns rem = '.cap'
        % -----------
        
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