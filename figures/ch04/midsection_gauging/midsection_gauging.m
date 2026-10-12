% Velocity–area (mid-section) discharge measurement
% Chapter 4 draft; data supplied by the chapter author (figs/fig7_midsection.csv)
% Run: run midsection_gauging.m  ->  figure_matlab.png (works in MATLAB and GNU Octave)
clear; close all;

fid = fopen('fig7_midsection.csv'); fgetl(fid);
C = textscan(fid, '%s%f%f%f%f%f%f%f%s', 'Delimiter', ',', 'EmptyValue', NaN); fclose(fid);
a.station = C{1};
a.distance_ft = C{2};
a.depth_ft = C{3};
a.mean_velocity_ft_per_s = C{4};
a.width_ft = C{5};
a.area_ft2 = C{6};
a.discharge_ft3_per_s = C{7};
a.percent_of_Q = C{8};
a.velocity_method = C{9};
a.station = strrep(a.station, '"', '');
a.velocity_method = strrep(a.velocity_method, '"', '');
a.negd = -a.depth_ft;

figure('Visible', 'off', 'Position', [100 100 800 650], 'Color', 'w');
axes('Position', [0.09 0.510 0.88 0.390]); hold on;
xx = a.distance_ft(:)'; hi_ = a.negd(:)'; lo_ = zeros(size(a.distance_ft))(:)'; ok = ~isnan(hi_); h0 = patch('XData', [xx(ok) fliplr(xx(ok))]', 'YData', [hi_(ok) fliplr(lo_(ok))]', 'FaceColor', [0.498, 0.702, 0.835], 'EdgeColor', 'none', 'FaceAlpha', 0.8);
xlabel('Distance from left edge of water (ft)');
ylabel('Depth (ft, below water surface)');
box off; grid on; set(gca, 'GridAlpha', 0.2, 'Layer', 'top');
legend([h0], {'Water depth'}, 'Location', 'southeast'); legend boxoff;

axes('Position', [0.09 0.080 0.88 0.390]); hold on;
xb = a.distance_ft(:); yb = a.discharge_ft3_per_s(:); h0 = patch('XData', [xb-3.0/2 xb+3.0/2 xb+3.0/2 xb-3.0/2]', 'YData', [zeros(size(yb)) zeros(size(yb)) yb yb]', 'FaceColor', [0.91, 0.455, 0.231], 'EdgeColor', 'none');
xlabel('Distance from left edge of water (ft)');
ylabel('Station discharge (ft³/s)');
box off; grid on; set(gca, 'GridAlpha', 0.2, 'Layer', 'top');

print('-dpng', '-r150', 'figure_matlab.png');
