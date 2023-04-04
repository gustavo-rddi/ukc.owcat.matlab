function nMob = determineVesselMobilisation(o, ~, instPhase)

nMob = size(o.vessels.(instPhase).type);

for i = 1 : numel(o.vessels.(instPhase).type)
    
    nMob(i) = o.vessels.(instPhase).nCharter(i) * ceil(o.vessels.(instPhase).durTot(i)/(o.OWF.nComm*SImultiplier('yr')));
    
end

