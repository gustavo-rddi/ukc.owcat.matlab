function o = addToProcurementRequirements(o, ~, cat, compType, nSupply, lSupply)

if nSupply ~= 0

    if ~isfield(o, 'proc') || ~isfield(o.proc, cat)
        
        if isa(compType,'char')
            o.proc.(cat).type = {compType};
        else
            o.proc.(cat).type = compType;
        end
                
        o.proc.(cat).nSupply = nSupply;
        
        if nargin > 5
            o.proc.(cat).lSupply = lSupply;
        end
        
    else
        
        if isa(compType,'char')
            iSelect = strcmpi(o.proc.(cat).type, compType);
        else
            iSelect = (o.proc.(cat).type == compType);
        end
        
        if any(iSelect)
            
            o.proc.(cat).nSupply(iSelect) = o.proc.(cat).nSupply(iSelect) + nSupply;
            
            if nargin > 5
                o.proc.(cat).lSupply(iSelect) = o.proc.(cat).lSupply(iSelect) + lSupply;
            end
            
        else
            
            if isa(compType,'char')
                o.proc.(cat).type{end+1} = compType;
            else
                o.proc.(cat).type(end+1) = compType;
            end
                        
            o.proc.(cat).nSupply(end+1) = nSupply;
            
            if nargin > 5
                o.proc.(cat).lSupply (end+1)= lSupply;
            end
            
        end
        
    end
    
end