% Storm hydrograph with rainfall, baseflow and stormflow
% Chapter 4 draft; data supplied by the chapter author (figs/fig1_timeseries.csv)
% Run: run storm_hydrograph.m  ->  figure_matlab.png (works in MATLAB and GNU Octave)
clear; close all;

fid = fopen('fig1_timeseries.csv'); fgetl(fid);
C = textscan(fid, '%f%f%f%f%f%f', 'Delimiter', ',', 'EmptyValue', NaN); fclose(fid);
a.time_h = C{1};
a.time_d = C{2};
a.rainfall_mm_per_h = C{3};
a.streamflow_m3_per_s = C{4};
a.baseflow_m3_per_s = C{5};
a.stormflow_m3_per_s = C{6};

figure('Visible', 'off', 'Position', [100 100 800 600], 'Color', 'w');
axes('Position', [0.09 0.625 0.88 0.275]); hold on;
xb = a.time_d(:); yb = a.rainfall_mm_per_h(:); h0 = patch('XData', [xb-0.010416666666666666/2 xb+0.010416666666666666/2 xb+0.010416666666666666/2 xb-0.010416666666666666/2]', 'YData', [zeros(size(yb)) zeros(size(yb)) yb yb]', 'FaceColor', [0.122, 0.306, 0.475], 'EdgeColor', 'none');
xlim([0, 2.5]);
ylim([0 40]);
set(gca, 'YDir', 'reverse');
ylabel('Rainfall (mm/h)');
box off; grid on; set(gca, 'GridAlpha', 0.2, 'Layer', 'top');

axes('Position', [0.09 0.080 0.88 0.505]); hold on;
h0 = plot(a.time_d, a.streamflow_m3_per_s, '-', 'Color', [0.133, 0.133, 0.133], 'LineWidth', 2);
h1 = plot(a.time_d, a.baseflow_m3_per_s, '--', 'Color', [0.353, 0.62, 0.435], 'LineWidth', 1.6);
h2 = plot(a.time_d, a.stormflow_m3_per_s, '--', 'Color', [0.91, 0.455, 0.231], 'LineWidth', 1.6);
xlim([0, 2.5]);
xlabel('Time (days)');
ylabel('Discharge (m³/s)');
box off; grid on; set(gca, 'GridAlpha', 0.2, 'Layer', 'top');
legend([h0, h1, h2], {'Streamflow', 'Baseflow', 'Stormflow'}, 'Location', 'northeast'); legend boxoff;

print('-dpng', '-r150', 'figure_matlab.png');
