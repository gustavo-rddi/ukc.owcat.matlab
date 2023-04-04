function output = subseaACcableProperties(req, Acon, spec)

%select output%
switch lower(req)
    
    %rated current%
    case 'irate'
        
        switch lower(spec)
        
            %select properties based on conductor material%
            case 'al'; a = +441.5; b = -544.2; c = +241.1; d = -9.549;
            case 'cu'; a = +1922;  b = -2492;  c = +1110;  d = -133.5;
                
        end
        
    %charging current%
    case 'icharge'
        
        switch spec
            
            %select properties based on cable voltage%
            case 33000;  a = +0.6306; b = +0.7413; c = -0.6769; d = +0.2231;
            case 66000;  a = -2.4476; b = +6.2711; c = -3.4426; d = +0.7141;
            case 132000; a = +8.6387; b = -7.5578; c = +2.2508; d = +0.0000;
            case 220000; a = +9.2171; b = -7.7352; c = +2.3960; d = +0.0000;
            case 270000; a = +26.090; b = -28.170; c = +10.341; d = -0.9437; %using same fitting param as 275
            case 275000; a = +26.090; b = -28.170; c = +10.341; d = -0.9437;
            
        end
        
        %convert A/km -> A/m%
        a = a/1000; b = b/1000; c = c/1000; d = d/1000;
        
end

%apply correlation to determine requested output%
output = a + b*log10(Acon) + c*log10(Acon).^2 + d*log10(Acon).^3;