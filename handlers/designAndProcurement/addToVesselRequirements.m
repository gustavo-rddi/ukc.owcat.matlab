function o = addToVesselRequirements(o, ~, instPhase, vesType, nVesOper, hCharter, reqDed)

if nVesOper > 0 && hCharter > 0
    
    if ~isfield(o, 'vessels') || ~isfield(o.vessels, instPhase)
        
        o.vessels.(instPhase).type = {vesType};
        o.vessels.(instPhase).nVesOper = nVesOper;
        o.vessels.(instPhase).durTot = hCharter;
        
        o.vessels.(instPhase).reqDed = reqDed;
        
    else
        
        o.vessels.(instPhase).type{end+1} = vesType;
        o.vessels.(instPhase).nVesOper(end+1) = nVesOper;
        o.vessels.(instPhase).durTot(end+1) = hCharter;
        
        o.vessels.(instPhase).reqDed(end+1) = reqDed;
        
    end
    
end