% Daily snowmelt vs air temperature, Bogus Basin, April 2023 (degree-day regression)
% Chapter 6 draft; data supplied by chapter author (bogus_basin_april2023_temp_melt.csv)
% Run: run temperature_melt_regression.m -> figure_matlab.png (MATLAB or GNU Octave)
clear; close all;
fid = fopen('bogus_basin_april2023_temp_melt.csv'); fgetl(fid);
C = textscan(fid, '%f%f', 'Delimiter', ','); fclose(fid);
T = C{1}; melt = C{2};
p = polyfit(T, melt, 1); cc = corrcoef(T, melt); r2 = cc(1,2)^2;
xs = linspace(min(T), max(T), 50);
figure('Visible', 'off', 'Position', [100 100 700 500], 'Color', 'w'); hold on;
h1 = plot(T, melt, 'o', 'MarkerFaceColor', [0.122 0.306 0.475], 'MarkerEdgeColor', [0.122 0.306 0.475], 'MarkerSize', 5, 'LineStyle', 'none');
h2 = plot(xs, polyval(p, xs), '-', 'Color', [0.91 0.455 0.231], 'LineWidth', 2);
xlabel('Mean daily air temperature (°C)'); ylabel('Daily snowmelt (mm)');
legend([h1 h2], {'Daily observations', sprintf('Fit: melt = %.2f T %+.2f  (R^2 = %.2f)', p(1), p(2), r2)}, 'Location', 'northwest'); legend boxoff;
box off; grid on; set(gca, 'GridAlpha', 0.2);
print('-dpng', '-r150', 'figure_matlab.png');
