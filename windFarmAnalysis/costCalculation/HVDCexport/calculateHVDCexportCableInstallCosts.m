function o = calculateHVDCexportCableInstallCosts(o, data, stocVar, markMods)

o.CAPEX.real.exportInstall_offcable=0;
Coverhead = exportInstallOverheadCosts(o, data, o.OWF.nExportCable, stocVar, markMods);

%calculate cost of pre-laying activities%
Cprelay = cablePreLayingCosts(o, data, o.OWF.lExportLay, stocVar, markMods);

%determine charter times for cable laying and burial%
[~, ~, Cvessels] = postLayBurialModel(o, data, o.OWF.lExportLay, o.offshoreConv, 'export', o.OWF.nExportCable,  stocVar, markMods);

%determine cable landfall costs%
Clandfall = cableLandfallCost(o, data, o.OWF.nExportCable, stocVar, markMods);

[~, Cterm] = cableTermination(o, data, 'HVDC', o.OWF.nExportCable, stocVar, markMods);

%sum export cable installation costs%
o.CAPEX.real.exportInstall = o.CAPEX.real.exportInstall + Cprelay +  Cvessels + Clandfall + Cterm + Coverhead;
o.CAPEX.real.exportInstall_offcable = o.CAPEX.real.exportInstall_offcable + Cprelay +  Cvessels + Clandfall + Cterm + Coverhead;

for i = 1 : numel(o.vessels.exportInst.type)
    
    %add vessel mobilisation costs to installation total%
    o.CAPEX.real.exportInstall = o.CAPEX.real.exportInstall + vesselMobilisationCost(o, data, o.vessels.exportInst.type{i}, stocVar, markMods) * o.vessels.exportInst.nVesMob(i);
    o.CAPEX.real.exportInstall_offcable = o.CAPEX.real.exportInstall_offcable +vesselMobilisationCost(o, data, o.vessels.exportInst.type{i}, stocVar, markMods) * o.vessels.exportInst.nVesMob(i);
end

