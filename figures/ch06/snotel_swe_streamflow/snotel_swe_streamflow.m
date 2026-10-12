% SNOTEL snow water equivalent, snow depth and USGS streamflow, WY2011–WY2012
% Chapter 6 draft; data supplied by chapter author (snotel1031_usgs06614800_WY2011_WY2012.csv)
% Run: run snotel_swe_streamflow.m  ->  figure_matlab.png (works in MATLAB and GNU Octave)
clear; close all;

fid = fopen('snotel1031_usgs06614800_WY2011_WY2012.csv'); fgetl(fid);
C = textscan(fid, '%s%f%f%f%f', 'Delimiter', ',', 'EmptyValue', NaN); fclose(fid);
a.date = C{1};
a.wy = C{2};
a.swe_mm = C{3};
a.depth_mm = C{4};
a.flow_cfs = C{5};
a.date = strrep(a.date, '"', '');
a.date = datenum(a.date, 'yyyy-mm-dd');
a_t0 = floor(min(a.date));  a.date = a.date - a_t0;   % offset keeps plotting precision (Octave uses single precision)

figure('Visible', 'off', 'Position', [100 100 800 600], 'Color', 'w');
axes('Position', [0.09 0.510 0.88 0.390]); hold on;
h0 = plot(a.date, a.swe_mm, '-', 'Color', [0.122, 0.306, 0.475], 'LineWidth', 1.6);
h1 = plot(a.date, a.depth_mm, '-', 'Color', [0.467, 0.467, 0.467], 'LineWidth', 1);
xt = get(gca, 'XTick'); set(gca, 'XTick', xt, 'XTickLabel', datestr(xt + a_t0, 'mmm yyyy'));
ylabel('Snow (mm)');
box off; grid on; set(gca, 'GridAlpha', 0.2, 'Layer', 'top');
legend([h0, h1], {'SWE (mm)', 'Snow depth (mm)'}, 'Location', 'northeast'); legend boxoff;

axes('Position', [0.09 0.080 0.88 0.390]); hold on;
h0 = plot(a.date, a.flow_cfs, '-', 'Color', [0.91, 0.455, 0.231], 'LineWidth', 1.6);
xt = get(gca, 'XTick'); set(gca, 'XTick', xt, 'XTickLabel', datestr(xt + a_t0, 'mmm yyyy'));
ylabel('Streamflow (cfs)');
box off; grid on; set(gca, 'GridAlpha', 0.2, 'Layer', 'top');

print('-dpng', '-r150', 'figure_matlab.png');
