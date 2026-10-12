% Chapters 1 and 5 - The Budyko curve (conceptual): ET/P vs PET/P (Budyko 1974) with energy and water limits
x = linspace(0.01, 5, 500);
budyko = sqrt(x .* tanh(1 ./ x) .* (1 - exp(-x)));
fig = figure('Position',[100 100 700 500]); hold on
h1 = plot(x, min(x, 1), 'k-', 'LineWidth', 1.5);
h2 = plot(x, budyko, 'Color', [0.106 0.31 0.447], 'LineWidth', 3);
plot([1 1], [0 1.1], ':', 'Color', [0.5 0.5 0.5]);
text(0.5, 0.12, {'energy-limited','(humid)'}, 'HorizontalAlignment','center');
text(3, 0.62, {'water-limited','(arid)'}, 'HorizontalAlignment','center');
xlim([0 5]); ylim([0 1.1]); box off
xlabel('Aridity index, PET / P'); ylabel('Evaporative index, ET / P');
legend([h1 h2], {'Energy limit (ET = PET) and water limit (ET = P)','Budyko curve'}, 'Location','southeast', 'Box','off');
print(fig, '-dpng', '-r150', 'figure_matlab.png');
