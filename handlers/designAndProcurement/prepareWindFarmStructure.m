function o = fixedWindFarmDesignElements(o, data)

%determine number of zones%
o.OWF.nZones = numel(o.zone);

o.OWF.nOper = data.WTG.nOper;

%get WTG lifetime%
o.OWF.yrProj = o.OWF.yrOper + (-(6+o.OWF.nComm) : data.WTG.nOper+1);