% Monthly P, ET, Q and change in storage in four climates (Figure 2.7)
% Chapter 2 draft; author data arrays from the code comment (truncated at Word's 2048-character comment limit); plotting completed from the figure in the draft
% Run: run water_budget_four_climates.m -> figure_matlab.png (MATLAB or GNU Octave)
clear; close all;
months = 'JFMAMJJASOND'; mfull = {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};
cl = struct('name', {}, 'place', {}, 'P', {}, 'ET', {}, 'Q', {}, 'note', {});
cl(1) = struct('name', 'Temperate (NH)', 'place', 'Hubbard Brook, NH', 'P', [95 88 100 105 118 112 116 116 84 120 124 108], 'ET', [5 8 22 48 84 108 120 104 78 34 12 5], 'Q', [0.95 0.85 1.05 2.3 1.35 0.85 0.5 0.35 0.3 0.55 0.85 0.95], 'note', 'snowmelt-fed spring Q, summer ET drawdown; lowest storage early autumn');
cl(2) = struct('name', 'Monsoon (NH)', 'place', 'Peninsular India', 'P', [10 12 14 22 40 150 300 290 180 70 20 8], 'ET', [35 45 70 95 110 120 115 110 95 70 50 40], 'Q', [0.55 0.35 0.25 0.2 0.2 0.9 2.6 2.7 1.8 1.0 0.75 0.65], 'note', 'dry season empties storage; trough just before monsoon onset');
cl(3) = struct('name', 'Temperate (SH)', 'place', 'S. Chile / Tasmania', 'P', [55 50 70 95 150 175 180 150 120 90 70 55], 'ET', [110 100 78 50 26 14 12 20 40 66 90 105], 'Q', [0.75 0.6 0.75 1.0 1.6 2.2 2.3 1.9 1.4 1.0 0.85 0.75], 'note', 'seasons flipped from NH; trough in austral autumn');
cl(4) = struct('name', 'Savanna (SH)', 'place', 'N. Australia (Top End)', 'P', [280 270 210 60 20 8 5 6 18 70 150 240], 'ET', [130 125 120 95 78 66 62 66 82 100 115 128], 'Q', [2.6 2.7 2.4 1.3 0.7 0.45 0.35 0.3 0.3 0.45 0.9 1.7], 'note', 'long dry season; trough at end of ''the Dry''');
figure('Visible', 'off', 'Position', [100 100 1250 860], 'Color', 'w');
x = 1:12;
for i = 1:4
  P = cl(i).P; ET = cl(i).ET; Q = cl(i).Q * ((sum(P) - sum(ET)) / sum(cl(i).Q));
  cs = cumsum(P - ET - Q); S = cs - min(cs); [~, trough] = min(cs); wy = mod(trough, 12) + 1;
  ytop = max([P ET Q]) * 1.08;
  pos = [0.07 + 0.49 * mod(i - 1, 2), 0.57 - 0.46 * (i > 2) + 0.0, 0.34, 0.33];
  ax1 = axes('Position', pos); hold on;
  for k = 1:12, patch('XData', [k-0.36 k+0.36 k+0.36 k-0.36]', 'YData', [0 0 P(k) P(k)]', 'FaceColor', [0.737 0.84 0.92], 'EdgeColor', 'none'); end
  plot(x, ET, '-o', 'Color', [0.835 0.369 0], 'LineWidth', 2, 'MarkerSize', 4, 'MarkerFaceColor', [0.835 0.369 0]);
  plot(x, Q, '-s', 'Color', [0 0.447 0.698], 'LineWidth', 2, 'MarkerSize', 4, 'MarkerFaceColor', [0 0.447 0.698]);
  plot([wy - 0.5 wy - 0.5], [0 ytop], 'k--', 'LineWidth', 1.4);
  text(wy - 0.4, ytop * 0.97, sprintf('water year\nstarts %s 1', mfull{wy}), 'FontWeight', 'bold', 'FontSize', 8, 'VerticalAlignment', 'top');
  text(0.7, ytop * 0.04, cl(i).note, 'FontAngle', 'italic', 'FontSize', 7, 'Color', [0.3 0.3 0.3]);
  set(ax1, 'XTick', x, 'XTickLabel', num2cell(months), 'Box', 'off'); xlim([0.4 12.6]); ylim([0 ytop]); ylabel('flux (mm/month)');
  title(sprintf('%s, %s  (P %.0f, ET %.0f, Q %.0f mm/yr, RC %.0f%%)', cl(i).name, cl(i).place, sum(P), sum(ET), sum(Q), 100 * sum(Q) / sum(P)), 'FontSize', 9);
  ax2 = axes('Position', pos, 'Color', 'none', 'YAxisLocation', 'right', 'XTick', [], 'Box', 'off'); hold on;
  patch('XData', [x fliplr(x)]', 'YData', [S zeros(1, 12)]', 'FaceColor', [0 0.62 0.451], 'FaceAlpha', 0.15, 'EdgeColor', 'none');
  plot(x, S, '--', 'Color', [0 0.62 0.451], 'LineWidth', 2); plot(trough, 0, 'v', 'MarkerFaceColor', [0 0.62 0.451], 'MarkerEdgeColor', 'k', 'MarkerSize', 8);
  xlim([0.4 12.6]); ylim([-0.05 * max(S) max(S) * 1.25]); ylabel('change in storage (mm)'); set(ax2, 'YColor', [0 0.62 0.451]);
end
print('-dpng', '-r150', 'figure_matlab.png');
