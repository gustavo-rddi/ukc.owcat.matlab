function o = runModel(runMode, projMods, techMods, markMods)

%set default input parameters%
if nargin < 1; runMode = 'single'; end
if nargin < 2; projMods = []; end;
if nargin < 3; techMods = []; end;
if nargin < 4; markMods = []; end;

%prepare model environment%
[o, data] = prepareEnvironment(runMode);

%run OWCAT model%
o = OWCATcore(o, data, projMods, techMods, markMods);