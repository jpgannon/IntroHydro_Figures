% Conductivity ratio vs slope for different hillslope length-to-depth ratios
% Chapter 4 draft; data supplied by the chapter author (figs/fig11.csv)
% Run: run hydraulic_conductivity_ratio.m  ->  figure_matlab.png (works in MATLAB and GNU Octave)
clear; close all;

fid = fopen('fig11.csv'); fgetl(fid);
C = textscan(fid, '%f%f%f%f%f%f%f%f', 'Delimiter', ',', 'EmptyValue', NaN); fclose(fid);
a.slope = C{1};
a.Kratio_LD_10m = C{2};
a.Kratio_LD_20m = C{3};
a.Kratio_LD_30m = C{4};
a.Kratio_LD_40m = C{5};
a.Kratio_LD_50m = C{6};
a.Kratio_LD_100m = C{7};
a.Kratio_LD_200m = C{8};

figure('Visible', 'off', 'Position', [100 100 700 500], 'Color', 'w');
subplot(1, 1, 1); hold on;
h0 = plot(a.slope, a.Kratio_LD_10m, '-', 'Color', [0.031, 0.188, 0.42], 'LineWidth', 1.6);
h1 = plot(a.slope, a.Kratio_LD_20m, '-', 'Color', [0.031, 0.318, 0.612], 'LineWidth', 1.6);
h2 = plot(a.slope, a.Kratio_LD_30m, '-', 'Color', [0.129, 0.443, 0.71], 'LineWidth', 1.6);
h3 = plot(a.slope, a.Kratio_LD_40m, '-', 'Color', [0.259, 0.573, 0.776], 'LineWidth', 1.6);
h4 = plot(a.slope, a.Kratio_LD_50m, '-', 'Color', [0.42, 0.682, 0.839], 'LineWidth', 1.6);
h5 = plot(a.slope, a.Kratio_LD_100m, '-', 'Color', [0.62, 0.792, 0.882], 'LineWidth', 1.6);
h6 = plot(a.slope, a.Kratio_LD_200m, '-', 'Color', [0.776, 0.859, 0.937], 'LineWidth', 1.6);
set(gca, 'XScale', 'log');
set(gca, 'YScale', 'log');
xlabel('Slope (m/m)');
ylabel('K ratio');
box off; grid on; set(gca, 'GridAlpha', 0.2, 'Layer', 'top');
legend([h0, h1, h2, h3, h4, h5, h6], {'10 m', '20 m', '30 m', '40 m', '50 m', '100 m', '200 m'}, 'Location', 'northeast'); legend boxoff;

print('-dpng', '-r150', 'figure_matlab.png');
