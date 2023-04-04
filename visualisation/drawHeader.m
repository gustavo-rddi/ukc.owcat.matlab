function drawHeader()

close all; clc; drawnow;

fprintf(1, '\n');
fprintf(1, '  ++------------------------------------------++\n');
fprintf(1, '  ++ EDF R&D Offshore Wind Cost Analysis Tool ++\n');
fprintf(1, '  ++  Version 4.6.%03d (%11s)          ++\n',round(now() - datenum('01-May-2016')), datestr(now, 'dd-mmm-yyyy'));
fprintf(1, '  ++------------------------------------------++\n');
fprintf(1, '\n');