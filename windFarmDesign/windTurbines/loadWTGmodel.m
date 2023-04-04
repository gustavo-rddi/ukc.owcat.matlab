function WTG = loadWTGmodel(data, model, loadCurves)

%load specific model data%
WTG = WTGmodelData(model);

%get list of turbine types%
turbList = strtrim(loadCurves.colheaders(2:end));

%select chosen turbine model%
iSelect = strcmpi(turbList, model);

%store load curve and load states%
WTG.loadCurve = loadCurves.data(:, 1+find(iSelect))';