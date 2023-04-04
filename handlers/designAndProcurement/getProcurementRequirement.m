function nSupply = getProcurementRequirement(o, ~, cat, compType)

iSelect = strcmpi(o.proc.(cat).type, compType);

nSupply = o.proc.(cat).nSupply(iSelect);