% Stage–discharge rating curve with 95% interval
% Chapter 4 draft; data supplied by the chapter author (figs/fig8_measurements_with_fit.csv, fig8_rating_fit.csv)
% Run: run rating_curve.m  ->  figure_matlab.png (works in MATLAB and GNU Octave)
clear; close all;

fid = fopen('fig8_measurements_with_fit.csv'); fgetl(fid);
C = textscan(fid, '%s%s%f%f%f%f%f', 'Delimiter', ',', 'EmptyValue', NaN); fclose(fid);
a.field_visit_id = C{1};
a.datetime_UTC = C{2};
a.gage_height_ft = C{3};
a.discharge_cfs = C{4};
a.Q_fit_cfs = C{5};
a.log_residual = C{6};
a.field_visit_id = strrep(a.field_visit_id, '"', '');
a.datetime_UTC = strrep(a.datetime_UTC, '"', '');

fid = fopen('fig8_rating_fit.csv'); fgetl(fid);
C = textscan(fid, '%f%f%f%f', 'Delimiter', ',', 'EmptyValue', NaN); fclose(fid);
b.gage_height_ft = C{1};
b.Q_fit_cfs = C{2};
b.Q_lower_95_cfs = C{3};
b.Q_upper_95_cfs = C{4};

figure('Visible', 'off', 'Position', [100 100 700 500], 'Color', 'w');
subplot(1, 1, 1); hold on;
xx = b.gage_height_ft(:)'; hi_ = b.Q_upper_95_cfs(:)'; lo_ = b.Q_lower_95_cfs(:)'; ok = ~isnan(hi_); h0 = patch('XData', [xx(ok) fliplr(xx(ok))]', 'YData', [hi_(ok) fliplr(lo_(ok))]', 'FaceColor', [0.62, 0.773, 0.91], 'EdgeColor', 'none', 'FaceAlpha', 0.6);
h1 = plot(b.gage_height_ft, b.Q_fit_cfs, '-', 'Color', [0.122, 0.306, 0.475], 'LineWidth', 1.6);
h2 = plot(a.gage_height_ft, a.discharge_cfs, 'o', 'MarkerFaceColor', [0.91, 0.455, 0.231], 'MarkerEdgeColor', [0.91, 0.455, 0.231], 'MarkerSize', 4, 'LineStyle', 'none');
set(gca, 'YScale', 'log');
xlabel('Gage height (ft)');
ylabel('Discharge (cfs)');
box off; grid on; set(gca, 'GridAlpha', 0.2, 'Layer', 'top');
legend([h0, h1, h2], {'95% interval', 'Fitted rating', 'Measurements'}, 'Location', 'southeast'); legend boxoff;

print('-dpng', '-r150', 'figure_matlab.png');
