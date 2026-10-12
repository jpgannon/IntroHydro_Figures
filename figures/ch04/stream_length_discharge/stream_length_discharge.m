% Stream length vs discharge (expansion and contraction of the network)
% Chapter 4 draft; data supplied by the chapter author (figs/fig12.csv)
% Run: run stream_length_discharge.m  ->  figure_matlab.png (works in MATLAB and GNU Octave)
clear; close all;

fid = fopen('fig12.csv'); fgetl(fid);
C = textscan(fid, '%s%f%f%f%f%f%f', 'Delimiter', ',', 'EmptyValue', NaN); fclose(fid);
a.record_type = C{1};
a.survey_date_MMDD = C{2};
a.discharge_mm_per_d = C{3};
a.stream_length_obs_km = C{4};
a.stream_length_fit_km = C{5};
a.drainage_density = C{6};
a.exceedance_prob_pct = C{7};
a.record_type = strrep(a.record_type, '"', '');

figure('Visible', 'off', 'Position', [100 100 700 500], 'Color', 'w');
subplot(1, 1, 1); hold on;

w = strcmp(a.record_type, 'fit');
h0 = plot(a.discharge_mm_per_d(w), a.stream_length_fit_km(w), '-', 'Color', [0.122, 0.306, 0.475], 'LineWidth', 1.6);

w = strcmp(a.record_type, 'observation');
h1 = plot(a.discharge_mm_per_d(w), a.stream_length_obs_km(w), 'o', 'MarkerFaceColor', [0.91, 0.455, 0.231], 'MarkerEdgeColor', [0.91, 0.455, 0.231], 'MarkerSize', 6, 'LineStyle', 'none');
set(gca, 'XScale', 'log');
xlabel('Discharge (mm/day)');
ylabel('Flowing stream length (km)');
box off; grid on; set(gca, 'GridAlpha', 0.2, 'Layer', 'top');
legend([h0, h1], {'Fit', 'Observed surveys'}, 'Location', 'northwest'); legend boxoff;

print('-dpng', '-r150', 'figure_matlab.png');
