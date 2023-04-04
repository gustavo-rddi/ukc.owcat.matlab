function o = applyTechnologyModifiers(o, techMods)

for i = 1 : numel(techMods)
   
    %apply all modifiers%
    o = modifyField(o, techMods{i}{1}, techMods{i}{2}, techMods{i}(3:end));
        
end