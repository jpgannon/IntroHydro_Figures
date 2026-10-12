% Hydrograph by runoff pathway (stacked)
% Chapter 4 draft; data supplied by the chapter author (figs/fig3_timeseries.csv)
% Run: run runoff_pathways.m  ->  figure_matlab.png (works in MATLAB and GNU Octave)
clear; close all;

fid = fopen('fig3_timeseries.csv'); fgetl(fid);
C = textscan(fid, '%f%f%f%f%f%f%f%f', 'Delimiter', ',', 'EmptyValue', NaN); fclose(fid);
a.time_h = C{1};
a.time_d = C{2};
a.rainfall_mm_per_h = C{3};
a.streamflow_m3_per_s = C{4};
a.channel_precip_m3_per_s = C{5};
a.overland_flow_m3_per_s = C{6};
a.interflow_m3_per_s = C{7};
a.groundwater_m3_per_s = C{8};
a.c1 = a.groundwater_m3_per_s;
a.c2 = a.groundwater_m3_per_s + a.interflow_m3_per_s;
a.c3 = a.groundwater_m3_per_s + a.interflow_m3_per_s + a.overland_flow_m3_per_s;
a.c4 = a.groundwater_m3_per_s + a.interflow_m3_per_s + a.overland_flow_m3_per_s + a.channel_precip_m3_per_s;

figure('Visible', 'off', 'Position', [100 100 800 600], 'Color', 'w');
axes('Position', [0.09 0.625 0.88 0.275]); hold on;
xb = a.time_d(:); yb = a.rainfall_mm_per_h(:); h0 = patch('XData', [xb-0.010416666666666666/2 xb+0.010416666666666666/2 xb+0.010416666666666666/2 xb-0.010416666666666666/2]', 'YData', [zeros(size(yb)) zeros(size(yb)) yb yb]', 'FaceColor', [0.122, 0.306, 0.475], 'EdgeColor', 'none');
xlim([0, 3]);
ylim([0 40]);
set(gca, 'YDir', 'reverse');
ylabel('Rainfall (mm/h)');
box off; grid on; set(gca, 'GridAlpha', 0.2, 'Layer', 'top');

axes('Position', [0.09 0.080 0.88 0.505]); hold on;
xx = a.time_d(:)'; hi_ = a.c4(:)'; lo_ = a.c3(:)'; ok = ~isnan(hi_); h0 = patch('XData', [xx(ok) fliplr(xx(ok))]', 'YData', [hi_(ok) fliplr(lo_(ok))]', 'FaceColor', [0.498, 0.702, 0.835], 'EdgeColor', 'none', 'FaceAlpha', 0.9);
xx = a.time_d(:)'; hi_ = a.c3(:)'; lo_ = a.c2(:)'; ok = ~isnan(hi_); h1 = patch('XData', [xx(ok) fliplr(xx(ok))]', 'YData', [hi_(ok) fliplr(lo_(ok))]', 'FaceColor', [0.91, 0.455, 0.231], 'EdgeColor', 'none', 'FaceAlpha', 0.9);
xx = a.time_d(:)'; hi_ = a.c2(:)'; lo_ = a.c1(:)'; ok = ~isnan(hi_); h2 = patch('XData', [xx(ok) fliplr(xx(ok))]', 'YData', [hi_(ok) fliplr(lo_(ok))]', 'FaceColor', [0.353, 0.62, 0.435], 'EdgeColor', 'none', 'FaceAlpha', 0.9);
xx = a.time_d(:)'; hi_ = a.c1(:)'; lo_ = zeros(size(a.time_d))(:)'; ok = ~isnan(hi_); h3 = patch('XData', [xx(ok) fliplr(xx(ok))]', 'YData', [hi_(ok) fliplr(lo_(ok))]', 'FaceColor', [0.549, 0.427, 0.275], 'EdgeColor', 'none', 'FaceAlpha', 0.9);
xlim([0, 3]);
xlabel('Time (days)');
ylabel('Discharge (m³/s)');
box off; grid on; set(gca, 'GridAlpha', 0.2, 'Layer', 'top');
legend([h0, h1, h2, h3], {'Channel precipitation', 'Overland flow', 'Interflow', 'Groundwater'}, 'Location', 'northeast'); legend boxoff;

print('-dpng', '-r150', 'figure_matlab.png');
