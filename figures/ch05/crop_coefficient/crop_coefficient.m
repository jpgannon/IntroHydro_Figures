% Chapter 5 - Crop coefficient curve for sweet corn (Idaho, USA). Data: 'Fig # - CropCoefficientCurve.xlsx'
% (duplicate rows in the spreadsheet removed). Reference: FAO Irrigation and Drainage Paper 56.
days = [0 30 60 90 110]; kc = [0.30 0.30 1.15 1.15 1.05];
a = [0 30 60 90]; b = [30 60 90 110];
names = {'Initial','Development','Mid-season','Late season'};
cols = [0.91 0.945 0.83; 0.83 0.9 0.96; 0.97 0.9 0.77; 0.95 0.85 0.83];
fig = figure('Position', [100 100 700 450]); hold on
for i = 1:4
    patch([a(i) b(i) b(i) a(i)], [0 0 1.4 1.4], cols(i,:), 'EdgeColor', 'none');
    text((a(i)+b(i))/2, 1.3, names{i}, 'HorizontalAlignment', 'center');
end
plot(days, kc, '-o', 'Color', [0.106 0.31 0.447], 'LineWidth', 2.5, 'MarkerFaceColor', [0.106 0.31 0.447]);
xlim([0 110]); ylim([0 1.4]); box off
xlabel('Days after planting'); ylabel('Crop coefficient, K_c');
title('Crop coefficient curve, sweet corn (Idaho, USA)');
print(fig, '-dpng', '-r150', 'figure_matlab.png');
