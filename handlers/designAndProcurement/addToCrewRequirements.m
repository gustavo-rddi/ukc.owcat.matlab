function o = addToCrewRequirements(o, ~, instPhase, vesType, hCharter)

if hCharter > 0
    
    if ~isfield(o, 'crews') || ~isfield(o.crews, instPhase)
        
        o.crews.(instPhase).type = {vesType};
        o.crews.(instPhase).durTot = hCharter;
        
    else
        
        iSelect = strcmpi(o.vessels.(instPhase).type, vesType);
        
        if ~any(iSelect)
            
            o.crews.(instPhase).type{end+1} = vesType;
            o.crews.(instPhase).durTot(end+1) = hCharter;
            
        else
            
            o.crews.(instPhase).type = {vesType};
            o.crews.(instPhase).durTot = hCharter;
            
        end
        
    end
    
end