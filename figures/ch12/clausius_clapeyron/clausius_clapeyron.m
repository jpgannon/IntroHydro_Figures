% Chapter 12, Figure X.3 - The Clausius-Clapeyron relationship (saturation vapor pressure vs temperature)
es0 = 6.11; T0 = 273.15; L = 2.501e6; Rv = 461.5;
es  = @(Tc) es0 * exp((L / Rv) * (1 / T0 - 1 ./ (Tc + 273.15)));            % hPa
rho = @(Tc) es(Tc) * 100 ./ (Rv * (Tc + 273.15)) * 1000;                    % g/m3
Tc = linspace(10, 30, 400);
fig = figure('Position', [100 100 760 580]);
ax = axes('Position', [0.12 0.16 0.76 0.74]); hold(ax, 'on');
plot(ax, Tc, es(Tc), 'Color', [0.106 0.31 0.447], 'LineWidth', 2.4);
Tref = 15; cols = [0.106 0.31 0.447; 0.9 0.494 0.133; 0.753 0.224 0.169]; dT = [0 2 4];
for i = 1:3
    Tp = Tref + dT(i);
    plot(ax, [Tp Tp], [0 es(Tp)], '--', 'Color', cols(i,:));
    plot(ax, Tp, es(Tp), 'o', 'MarkerFaceColor', cols(i,:), 'Color', cols(i,:));
end
text(ax, 10.4, es(15)+7, sprintf('15°C\n%.1f hPa\n(%.1f g/m^3)', es(15), rho(15)), 'Color', cols(1,:), 'FontSize', 9);
text(ax, 14.4, es(17)+5, sprintf('+2°C\n%.1f hPa (%.1f g/m^3)\n%.0f%% more water vapor', es(17), rho(17), (es(17)/es(15)-1)*100), 'Color', cols(2,:), 'FontSize', 9);
text(ax, 18.4, es(19)+7, sprintf('+4°C\n%.1f hPa (%.1f g/m^3)\n%.0f%% more water vapor', es(19), rho(19), (es(19)/es(15)-1)*100), 'Color', cols(3,:), 'FontSize', 9);
xlim(ax, [10 30]); ylim(ax, [10 48.5]); grid(ax, 'on'); box(ax, 'off');
xlabel(ax, 'Temperature (°C)'); ylabel(ax, 'Saturation vapor pressure, e_s (hPa)');
title(ax, 'The Clausius–Clapeyron relationship');
% right-hand axis: absolute humidity at saturation, labelled at the matching vapor-pressure positions
rt = 10:2.5:30;
ax2 = axes('Position', get(ax, 'Position'), 'Color', 'none', 'YAxisLocation', 'right', 'XTick', [], 'XLim', [10 30], 'YLim', [10 48.5]);
set(ax2, 'YTick', interp1(rho(Tc), es(Tc), rt), 'YTickLabel', arrayfun(@(v) sprintf('%.1f', v), rt, 'UniformOutput', false));
ylabel(ax2, 'Water vapor in air at saturation (g per m^3)');
print(fig, '-dpng', '-r150', 'figure_matlab.png');
