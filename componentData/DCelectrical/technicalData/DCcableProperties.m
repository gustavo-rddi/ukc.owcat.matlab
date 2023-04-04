function output = DCcableProperties(req, Acon, spec)

%select output%
switch lower(req)
    
    %rated current%
    case 'irate'
        
        switch lower(spec)
        
            %select properties based on conductor material%
            case 'cu'; a = -12137; b = 13671; c = -5240.7; d = 737.61;
                
        end
           
end

%apply correlation to determine requested output%
output = a + b*log10(Acon) + c*log10(Acon).^2 + d*log10(Acon).^3;