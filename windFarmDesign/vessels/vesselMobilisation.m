function o = vesselMobilisation(o, data, ~, ~)


phaseNames = fieldnames(o.vessels);

for i = 1 : numel(phaseNames)

    nVesType = numel(o.vessels.(phaseNames{i}).type);
    
    for j = 1 : nVesType
        
        o.vessels.(phaseNames{i}).nVesMob(j) = o.vessels.(phaseNames{i}).nVesOper(j) * ceil(o.vessels.(phaseNames{i}).durTot(j)/(o.OWF.nComm*SImultiplier('yr')));
        
    end
    
    for j = 1 : nVesType
    
        iMatch = strcmpi(o.vessels.(phaseNames{i}).type{j}, o.vessels.(phaseNames{i}).type) ...
               & o.vessels.(phaseNames{i}).nVesOper(j) == o.vessels.(phaseNames{i}).nVesOper ...
               & ~o.vessels.(phaseNames{i}).reqDed ...
               & o.vessels.(phaseNames{i}).nVesMob > 0;
        
        if sum(iMatch) > 1
            
            o.vessels.(phaseNames{i}).nVesMob(j) = o.vessels.(phaseNames{i}).nVesOper(j) * ceil(sum(o.vessels.(phaseNames{i}).durTot(iMatch))/(o.OWF.nComm*SImultiplier('yr')));
            
            o.vessels.(phaseNames{i}).nVesMob(iMatch & (1 : nVesType ~= j)) = 0;
            
        end
    
    end
        
end

if any(strcmpi({o.WTG.fndType}, 'oblyth'))||any(strcmpi({o.WTG.fndType}, 'o500gbf'))|| any(strcmpi({o.WTG.fndType}, 'o500jkt'))
return;
end


if ~strcmpi(o.OWF.expType, 'MVAC')

    nVesFndInst = numel(o.vessels.fndInst.type);

    for i = 1 : nVesFndInst

        iMatch = strcmpi(o.vessels.fndInst.type{i}, o.vessels.SSinst.type) ...
               & o.vessels.fndInst.nVesOper(i) == o.vessels.SSinst.nVesOper ...
               & ~o.vessels.SSinst.reqDed ...
               & o.vessels.SSinst.nVesMob > 0;

        if any(iMatch)

            durCum  = sum(o.vessels.SSinst.durTot(iMatch)) + o.vessels.fndInst.durTot(i);

            o.vessels.fndInst.nVesMob(i) = o.vessels.fndInst.nVesOper(i) * ceil(durCum/(o.OWF.nComm*SImultiplier('yr')));

            o.vessels.SSinst.nVesMob(iMatch) = 0;

        end

    end

    nVesFndDecom = numel(o.vessels.fndDecom.type);

    for i = 1 : nVesFndDecom

        iMatch = strcmpi(o.vessels.fndDecom.type{i}, o.vessels.SSdecom.type) ...
               & o.vessels.fndDecom.nVesOper(i) == o.vessels.SSdecom.nVesOper ...
               & ~o.vessels.SSdecom.reqDed ...
               & o.vessels.SSdecom.nVesMob > 0;

        if any(iMatch)

            durCum  = sum(o.vessels.SSdecom.durTot(iMatch)) + o.vessels.fndDecom.durTot(i);

            o.vessels.fndDecom.nVesMob(i) = o.vessels.fndDecom.nVesOper(i) * ceil(durCum/(o.OWF.nComm*SImultiplier('yr')));

            o.vessels.SSdecom.nVesMob(iMatch) = 0;

        end

    end

end