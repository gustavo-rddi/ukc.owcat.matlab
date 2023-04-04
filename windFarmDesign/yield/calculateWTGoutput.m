function o = calculateWTGoutput(o, data, ~, ~)

for i = 1 : o.OWF.nWTG
    
    for j = 1 : length(o.zone(o.WTG(i).zone).vWindAnn)
    
        %calculate mean wind speed at WTG hub height%
        vMeanHub = o.zone(o.WTG(i).zone).vWindAnn(j) * log(o.WTG(i).hHub/data.model.lRough) / log(data.model.hWindRef/data.model.lRough);
    
%         %calculate Rayleigh sigma-factor%
%         sigmaRayleigh = sqrt(2/pi)*vMeanHub;
%     
%         %determine probabilistic wind speed distribution%
%         o.WTG(i).pWind(j,:) = (o.design.vWindCalc/sigmaRayleigh^2) .* exp(-(o.design.vWindCalc.^2)/(2*sigmaRayleigh^2));

        % Calculate Weibull parameters 
        k = 2.25; % assumed that k = 2.25 best represents generic offshore wind site. See investigation by Daniel Opoku
        a = vMeanHub/exp(gammaln(1+1/k)); % function to get Weibull scale parameter for known mean and shape factor (k)
        
        %Obtain Probability distribution values       
        o.WTG(i).pWind(j,:) = (k/a).*(o.design.vWindCalc./a).^(k-1).*exp(-(o.design.vWindCalc./a).^k);

        
        
        %calculate idealised wind turbine yield (no losses)%
        o.WTG(i).idealYield(j) = 8760 * 3600 * o.WTG(i).cap * sum(o.WTG(i).loadCurve.*o.WTG(i).pWind(j,:));
        
        if strcmpi(o.finance.type, 'project')
           
            %calculate mean wind speed at WTG hub height%
            vMeanHubP90 = o.zone(o.WTG(i).zone).vWindP90(j) * log(o.WTG(i).hHub/data.model.lRough) / log(data.model.hWindRef/data.model.lRough);
    
%             %calculate Rayleigh sigma-factor%
%             sigmaRayleighP90 = sqrt(2/pi)*vMeanHubP90;
%     
%             %determine probabilistic wind speed distribution%
%             o.WTG(i).pWindP90(j,:) = (o.design.vWindCalc/sigmaRayleighP90^2) .* exp(-(o.design.vWindCalc.^2)/(2*sigmaRayleighP90^2));
    
           % Calculate Weibull parameters           
            aP90 = vMeanHubP90/exp(gammaln(1+1/k)); % function to get Weibull scale parameter for known mean and shape factor (k)
            o.WTG(i).pWindP90(j,:) = (k/aP90).*(o.design.vWindCalc./aP90).^(k-1).*exp(-(o.design.vWindCalc./aP90).^k);

             %Obtain Probability distribution values       

            %calculate idealised wind turbine yield (no losses)%
            o.WTG(i).idealYieldP90(j) = 8760 * 3600 * o.WTG(i).cap * sum(o.WTG(i).loadCurve.*o.WTG(i).pWindP90(j,:));
            
        end
        
    end
   
    if strcmpi(o.finance.type, 'project')
    
        o.WTG(i).idealYieldP90 = o.WTG(i).idealYieldP90 .* (o.OWF.yrProj >= o.OWF.yrOper-o.OWF.nComm) .* (o.OWF.yrProj - o.OWF.yrOper < o.OWF.nOper);
        
    end
    
end

