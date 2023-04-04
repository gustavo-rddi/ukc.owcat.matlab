function [o, data] = loadSpecifications(o, data, projMods, techMods)

%inform of current operation%
%message(o, 'Loading Project Specifications...', {'single', 'stoc'});

%load default project specifications%
o = defaultProjectSpecifications(o);

%apply any project modifications%
if ~isempty(projMods)
    o = applyProjectModifiers(o, projMods);
end

%convert units%
o = convertUnits(o);

%inform of current operation%
%message(o, 'Loading Component Specifications...', {'single', 'stoc'}, 1);

%load default technology specifications%
data = defaultTechnologySpecifications(data);

%apply any technology modifications%
if ~isempty(techMods)
    data = applyTechnologyModifiers(data, techMods);
end

%convert units%
data = convertUnits(data);

%determine operational lifetime%
o.OWF.nOper = data.WTG.nOper;
o.OWF.nProj = 6+o.OWF.nComm+data.WTG.nOper+2;

%get WTG lifetime%
o.OWF.yrProj = o.OWF.yrOper + (-(6+o.OWF.nComm) : data.WTG.nOper+1);

if strcmpi(o.runMode, 'stoc')
    
    %turn off contingency in stochastic mode%
    data.econ.contCon = 0; data.econ.contOp = 0;

end