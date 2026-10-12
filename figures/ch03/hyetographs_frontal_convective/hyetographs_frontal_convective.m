% Figure 3.9: Hyetographs for a frontal storm (March) and a convective storm (June)
% Chapter 3 draft; data supplied by chapter author (Figure_3_9_Timeseries.xlsx; Hubbard Brook rain gage, 15-min)
% Run: run hyetographs_frontal_convective.m  ->  figure_matlab.png (works in MATLAB and GNU Octave)
clear; close all;

fid = fopen('hyetograph_frontal_march.csv'); fgetl(fid);
C = textscan(fid, '%s%f', 'Delimiter', ',', 'EmptyValue', NaN); fclose(fid);
a.datetime = C{1};
a.precip_mm = C{2};
a.datetime = strrep(a.datetime, '"', '');
a.datetime = datenum(a.datetime, 'yyyy-mm-dd HH:MM:SS');
a_t0 = floor(min(a.datetime));  a.datetime = a.datetime - a_t0;   % offset keeps plotting precision (Octave uses single precision)

fid = fopen('hyetograph_convective_june.csv'); fgetl(fid);
C = textscan(fid, '%s%f', 'Delimiter', ',', 'EmptyValue', NaN); fclose(fid);
b.datetime = C{1};
b.precip_mm = C{2};
b.datetime = strrep(b.datetime, '"', '');
b.datetime = datenum(b.datetime, 'yyyy-mm-dd HH:MM:SS');
b_t0 = floor(min(b.datetime));  b.datetime = b.datetime - b_t0;   % offset keeps plotting precision (Octave uses single precision)

figure('Visible', 'off', 'Position', [100 100 800 600], 'Color', 'w');
subplot(2, 1, 1); hold on;
xb = a.datetime(:); yb = a.precip_mm(:); h0 = patch('XData', [xb-0.010416666666666666/2 xb+0.010416666666666666/2 xb+0.010416666666666666/2 xb-0.010416666666666666/2]', 'YData', [zeros(size(yb)) zeros(size(yb)) yb yb]', 'FaceColor', [0.122, 0.306, 0.475], 'EdgeColor', 'none');
ylim([0 1.0]);
set(gca, 'YDir', 'reverse');
xt = get(gca, 'XTick'); set(gca, 'XTick', xt, 'XTickLabel', datestr(xt + a_t0, 'HH:MM'));
xlabel('Time of day');
ylabel('Precipitation (mm per 15 min)');
title('(a) Frontal storm, 31 March 2025', 'FontSize', 10, 'HorizontalAlignment', 'left');
box off; grid on; set(gca, 'GridAlpha', 0.2, 'Layer', 'top');

subplot(2, 1, 2); hold on;
xb = b.datetime(:); yb = b.precip_mm(:); h0 = patch('XData', [xb-0.010416666666666666/2 xb+0.010416666666666666/2 xb+0.010416666666666666/2 xb-0.010416666666666666/2]', 'YData', [zeros(size(yb)) zeros(size(yb)) yb yb]', 'FaceColor', [0.122, 0.306, 0.475], 'EdgeColor', 'none');
ylim([0 6]);
set(gca, 'YDir', 'reverse');
xt = get(gca, 'XTick'); set(gca, 'XTick', xt, 'XTickLabel', datestr(xt + b_t0, 'HH:MM'));
xlabel('Time of day');
ylabel('Precipitation (mm per 15 min)');
title('(b) Convective storm, 6 June 2025', 'FontSize', 10, 'HorizontalAlignment', 'left');
box off; grid on; set(gca, 'GridAlpha', 0.2, 'Layer', 'top');

print('-dpng', '-r150', 'figure_matlab.png');
