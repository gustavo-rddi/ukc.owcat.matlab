function o = populateWindFarmZones(o, data)

%determine number of zones%
o.OWF.nZones = numel(o.zone);

%get WTG load-curve data from external file%
loadCurveDir = strcat(data.paths.homeDir, filesep, 'componentData', filesep, 'windTurbines', filesep, 'loadCurves', filesep);
loadCurveFile = importdata(strcat(loadCurveDir, 'loadCurves.txt'));

%store wind speed values for calculation%
o.design.vWindCalc = loadCurveFile.data(:, 1)';

for i = 1 : o.OWF.nZones
    
    %starting WTG index%
    if ~isfield(o, 'WTG'); nWTG = 0;
    else nWTG = length(o.WTG);
    end
    
    %load or generate base WTG model data%
    if ~strncmpi(o.zone(i).WTGmodel, 'generic', 7)
        WTGmodel = loadWTGmodel(data, o.zone(i).WTGmodel, loadCurveFile);
    else
        WTGmodel = generateWTGmodel(data, o.zone(i).WTGmodel, o.design.vWindCalc);
    end
        
    WTGmodel.model = o.zone(i).WTGmodel;
    
    %determine foundation type%
    switch lower(o.zone(i).fndType)
        
        %store number of pin-piles%
        case 'jacket'; WTGmodel.nPP = data.sJKT.nPP; WTGmodel.turbInst = 'offshore';
        case 'semisub'; 
            
            WTGmodel.nMoor = data.semi.nMoor;
                        
            WTGmodel.lMoor = sqrt(o.zone(i).dWater^2 + data.semi.rMoor^2);
            
            WTGmodel.turbInst = 'quaySide';
            
        otherwise
            
            WTGmodel.turbInst = 'offshore';
            
    end
    
    WTGmodel.loadStates = sort(unique(WTGmodel.loadCurve));
        
    %calculate hub and tip height%
    WTGmodel.hHub = WTGmodel.dRot/2 + data.WTG.hClear;
    WTGmodel.hTip = WTGmodel.dRot + data.WTG.hClear;
    
    %determine number of WTGs in zone%
    o.zone(i).nWTG = floor(o.zone(i).cap/WTGmodel.cap+1e-8);
    o.zone(i).cap = o.zone(i).nWTG * WTGmodel.cap;

    for j = 1 : o.zone(i).nWTG
        
        %store WTG foundation type%
        WTGmodel.fndType = o.zone(i).fndType;
        
        %copy zonal properties of WTG unit%
        WTGmodel.dWater = o.zone(i).dWater;
        WTGmodel.dLandfall = o.zone(i).dLandfall;
        WTGmodel.dPortCon = o.zone(i).dPortCon;
        WTGmodel.dPortOM = o.zone(i).dPortOM;
        WTGmodel.vWind = o.zone(i).vWind;
        WTGmodel.pDrill = o.zone(i).fDrill;
        
        %determine spacing around WTG unit%
        WTGmodel.dSpace = WTGmodel.dRot*o.design.fSpace;
        
        %assign zone%
        WTGmodel.zone = i;
        
        %store WTG data%
        o.WTG(nWTG + j) = WTGmodel;
        
    end
    
end

%overall wind farm capacity%
o.OWF.cap = sum([o.zone.cap]);
o.OWF.nWTG = sum([o.zone.nWTG]);