function [o, data] = prepareEnvironment(runMode)

%create local data objects%
o = struct; data = struct;

%model timer%
o.tStart = tic;

%store model run mode%
o.runMode = runMode;

%clean-up environment%
if strcmpi(o.runMode, 'single') || strcmpi(o.runMode, 'setup') || strcmpi(o.runMode, 'stoc')
    close all; fclose all; clc; drawnow;
    restoredefaultpath;
end

%get details of m-file%
fullPath = mfilename('fullpath');
fName = mfilename;

%determine paths to model files%
data.paths.runDir = fullPath(1:end-(length(fName)+1));
data.paths.homeDir = fullPath(1:strfind(fullPath, 'cases')-2);

if strcmpi(o.runMode, 'single') || strcmpi(o.runMode, 'setup') || strcmpi(o.runMode, 'stoc')

    %get folders in directory%
    dStruct = dir(data.paths.homeDir);
    folders = {dStruct(3:end).name};
    isDir = {dStruct(3:end).isdir};
    
    %add paths to run directory%
    addpath(genpath(data.paths.runDir));
    
    %add path to home directory%
    addpath(data.paths.homeDir);
    
    for i = 1 : length(folders)
        
        if isDir{i} && ~strcmpi(folders{i}, 'cases') 
            
            %add paths to model files%
            addpath(genpath(strcat(data.paths.homeDir, filesep, folders{i})));
            
        end
        
    end
        
    %draw header%
    drawHeader();

end

