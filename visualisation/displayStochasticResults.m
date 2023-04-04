function displayStochasticResults(oStoc, data, i)

speed = floor(3600*i/toc(oStoc.tStart));

P = linspace(0, 100, i);

sCAPEX = sort(oStoc.CAPEX.real.total(1:i))*1000/oStoc.OWF.cap;
sOPEX = sort(oStoc.OPEX.real.total(1:i))*1000/oStoc.OWF.cap;
sLCOE = sort(oStoc.LCOE.real.total(1:i))*3.6e9;

CAPEX_P50 = interp1(P, sCAPEX, 50);
CAPEX_P90 = interp1(P, sCAPEX, 90);

E_CAPEX = mean(sCAPEX);

OPEX_P50 = interp1(P, sOPEX, 50);
OPEX_P90 = interp1(P, sOPEX, 90);

E_OPEX = mean(sOPEX);

LCOE_P50 = interp1(P, sLCOE, 50);
LCOE_P90 = interp1(P, sLCOE, 90);

E_LCOE = mean(sLCOE);

fprintf(1, ' | %5d | %5.0f %5.0f  %5.3f  | %5.0f %5.0f  %5.3f  | %5.0f %5.0f  %5.3f  |  %5d  |\n', i, CAPEX_P50, CAPEX_P90, CAPEX_P90/CAPEX_P50, OPEX_P50, OPEX_P90, OPEX_P90/OPEX_P50, LCOE_P50, LCOE_P90, LCOE_P90/LCOE_P50, speed);

subplot(1,3,1); hold off;
plot([-50 100], [1, 1]*E_CAPEX, 'b', 'LineWidth', 2.5); hold on;
plot([50 50 0], [0, CAPEX_P50, CAPEX_P50], 'r', 'LineWidth', 2.5);
plot([90 90 0], [0, CAPEX_P90, CAPEX_P90], 'r', 'LineWidth', 2.5);
plot(P, sCAPEX, 'k', 'LineWidth', 2.5);
xlabel('Percentile [%]', 'FontSize', 12);
ylabel(sprintf('CAPEX [%s/kW]', data.econ.(oStoc.OWF.loc).curr), 'FontSize', 12);
set(gca, 'xlim', [0, 100], 'ylim', [sCAPEX(1), sCAPEX(end)]);

subplot(1,3,2); hold off;
plot([-50 100], [1, 1]*E_OPEX, 'b', 'LineWidth', 2.5); hold on;
plot([50 50 0], [0, OPEX_P50, OPEX_P50], 'r', 'LineWidth', 2.5);
plot([90 90 0], [0, OPEX_P90, OPEX_P90], 'r', 'LineWidth', 2.5);
plot(P, sOPEX, 'k', 'LineWidth', 2.5);
xlabel('Percentile [%]', 'FontSize', 12);
ylabel(sprintf('OPEX [%s/kWyr]', data.econ.(oStoc.OWF.loc).curr), 'FontSize', 12);
set(gca, 'xlim', [0, 100], 'ylim', [sOPEX(1), sOPEX(end)]);

subplot(1,3,3); hold off;
plot([-50 100], [1, 1]*E_LCOE, 'b', 'LineWidth', 2.5); hold on;
plot([50 50 0], [0, LCOE_P50, LCOE_P50], 'r', 'LineWidth', 2.5);
plot([90 90 0], [0, LCOE_P90, LCOE_P90], 'r', 'LineWidth', 2.5);
plot(P, sLCOE, 'k', 'LineWidth', 2.5);
xlabel('Percentile [%]', 'FontSize', 12);
ylabel(sprintf('LCOE [%s/MWh]', data.econ.(oStoc.OWF.loc).curr), 'FontSize', 12);
set(gca, 'xlim', [0, 100], 'ylim', [sLCOE(1), sLCOE(end)]);

set(gcf, 'position', [50 100 1500 410]);

drawnow;