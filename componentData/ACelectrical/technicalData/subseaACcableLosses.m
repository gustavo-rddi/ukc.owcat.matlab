function loss = subseaACcableLosses(Asect, Vop, matCond, Iload)

switch Vop
    
    case 33000
        
        switch lower(matCond)
            
            case {'cu', 'copper'}
                
                switch Asect
                    
                    %correlation coefficients (Cu-33kV)%
                    case 95;  a = +7.645e1; c = +7.832e-1;
                    case 150; a = +8.893e1; c = +5.219e-1;
                    case 300; a = +1.143e2; c = +2.836e-1;
                    case 400; a = +1.256e2; c = +2.363e-1;
                    case 500; a = +1.386e2; c = +2.069e-1;
                    case 630; a = +1.530e2; c = +1.716e-1;
                    case 800; a = +1.687e2; c = +1.511e-1;
             
                end
        
            case {'al', 'aluminium'}
                
                switch Asect
                    
                    %correlation coefficients (Al-33kV)%
                    case 95;  a = +7.645e1; c = +12.87e-1;
                    case 150; a = +8.893e1; c = +8.463e-1;
                    case 300; a = +1.143e2; c = +4.395e-1;
                    case 400; a = +1.256e2; c = +3.554e-1;
                    case 500; a = +1.386e2; c = +2.907e-1;
                    case 630; a = +1.530e2; c = +2.407e-1;
                    case 800; a = +1.687e2; c = +2.037e-1;
             
                end
                
        end
                
    case 66000
        
        switch lower(matCond)
            
            case {'cu', 'copper'}
                
                switch Asect
                    
                    %correlation coefficients (Cu-66kV)%
                    case 95;  a = +3.225e2; c = +7.809e-1;
                    case 150; a = +3.722e2; c = +5.190e-1;
                    case 300; a = +4.734e2; c = +2.797e-1;
                    case 400; a = +5.187e2; c = +2.316e-1;
                    case 500; a = +5.704e2; c = +2.017e-1;
                    case 630; a = +6.282e2; c = +1.662e-1;
                    case 800; a = +6.282e2; c = +1.449e-1;
                
                end
                        
            case {'al', 'aluminium'}
                
                switch Asect
                    
                    %correlation coefficients (Al-66kV)%
                    case 95;  a = +3.225e2; c = +12.84e-1;
                    case 150; a = +3.722e2; c = +8.434e-1;
                    case 300; a = +4.734e2; c = +4.357e-1;
                    case 400; a = +5.187e2; c = +3.509e-1;
                    case 500; a = +5.704e2; c = +2.856e-1;
                    case 630; a = +6.282e2; c = +2.354e-1;
                    case 800; a = +6.282e2; c = +1.979e-1;
                        
                end     
                        
        end
        
end

%calculate losses per m%
loss = (a + c*Iload.^2)/1000;