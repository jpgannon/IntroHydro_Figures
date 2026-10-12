% Baseflow separation: fixed-interval vs digital filter
% Chapter 4 draft; data supplied by the chapter author (figs/fig9.csv)
% Run: run baseflow_separation.m  ->  figure_matlab.png (works in MATLAB and GNU Octave)
clear; close all;

fid = fopen('fig9.csv'); fgetl(fid);
C = textscan(fid, '%s%f%f%f%f%f', 'Delimiter', ',', 'EmptyValue', NaN); fclose(fid);
a.date = C{1};
a.streamflow_cfs = C{2};
a.baseflow_fixed_interval_cfs = C{3};
a.baseflow_digital_filter_cfs = C{4};
a.quickflow_fixed_interval_cfs = C{5};
a.quickflow_digital_filter_cfs = C{6};
a.date = strrep(a.date, '"', '');
a.date = datenum(a.date, 'dd-mmm-yyyy');
a_t0 = floor(min(a.date));  a.date = a.date - a_t0;   % offset keeps plotting precision (Octave uses single precision)

figure('Visible', 'off', 'Position', [100 100 800 450], 'Color', 'w');
subplot(1, 1, 1); hold on;
h0 = plot(a.date, a.streamflow_cfs, '-', 'Color', [0.133, 0.133, 0.133], 'LineWidth', 1.6);
h1 = plot(a.date, a.baseflow_fixed_interval_cfs, '-', 'Color', [0.91, 0.455, 0.231], 'LineWidth', 1.6);
h2 = plot(a.date, a.baseflow_digital_filter_cfs, '-', 'Color', [0.122, 0.306, 0.475], 'LineWidth', 1.6);
xt = get(gca, 'XTick'); set(gca, 'XTick', xt, 'XTickLabel', datestr(xt + a_t0, 'mmm yyyy'));
ylabel('Discharge (cfs)');
box off; grid on; set(gca, 'GridAlpha', 0.2, 'Layer', 'top');
legend([h0, h1, h2], {'Streamflow', 'Baseflow (fixed interval)', 'Baseflow (digital filter)'}, 'Location', 'northeast'); legend boxoff;

print('-dpng', '-r150', 'figure_matlab.png');
