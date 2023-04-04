function message(o, text, modes, nWL)

%default to no white lines%
if nargin < 4; nWL = 0; end

if any(strcmpi(o.runMode, modes))
    
    %inform of current operation%
    disp(['>> ', text]);
    
    %add white lines%
    for i = 1 : nWL
        disp(' ');
    end
    
end
