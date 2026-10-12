% Figures 3.21 and 3.22: normal PDF and CDF of annual precipitation; effect of standard deviation
% Chapter 3 draft; parameters read from the draft figure (mean 40 in; sigma 5 and 10 in for Fig 3.22; sigma 8 in assumed for the Fig 3.21 schematic)
% Run: run normal_distribution_pdf_cdf.m -> figure_matlab.png (MATLAB or GNU Octave)
clear; close all;
mu = 40; sd = 8; xq = 46; x = linspace(10, 70, 600); m = x <= xq;
pdf_ = @(x, mu, s) exp(-0.5 * ((x - mu) / s).^2) / (s * sqrt(2 * pi));
cdf_ = @(x, mu, s) 0.5 * (1 + erf((x - mu) / (s * sqrt(2))));
figure('Visible', 'off', 'Position', [100 100 1400 420], 'Color', 'w');
subplot(1, 3, 1); hold on;
patch('XData', [x(m) fliplr(x(m))]', 'YData', [pdf_(x(m), mu, sd) zeros(1, sum(m))]', 'FaceColor', [0.62 0.77 0.91], 'EdgeColor', 'none');
plot(x, pdf_(x, mu, sd), '-', 'Color', [0.122 0.306 0.475], 'LineWidth', 2); ylabel('Probability density'); title('(a) Probability density function', 'FontSize', 10);
text(52, 0.04, sprintf('P(X <= %d in) = %.2f', xq, cdf_(xq, mu, sd)));
subplot(1, 3, 2); hold on;
patch('XData', [x(m) fliplr(x(m))]', 'YData', [cdf_(x(m), mu, sd) zeros(1, sum(m))]', 'FaceColor', [0.62 0.77 0.91], 'EdgeColor', 'none');
plot(x, cdf_(x, mu, sd), '-', 'Color', [0.122 0.306 0.475], 'LineWidth', 2);
plot([xq xq], [0 cdf_(xq, mu, sd)], 'k:'); plot([10 xq], [1 1] * cdf_(xq, mu, sd), 'k:'); ylabel('Cumulative probability'); title('(b) Cumulative distribution function', 'FontSize', 10);
subplot(1, 3, 3); hold on;
h1 = plot(x, pdf_(x, mu, 5), '-', 'Color', [0.275 0.51 0.706], 'LineWidth', 2.2); h2 = plot(x, pdf_(x, mu, 10), '-', 'Color', [1 0.549 0], 'LineWidth', 2.2);
legend([h1 h2], {'\sigma = 5 in', '\sigma = 10 in'}); legend boxoff; ylabel('Probability density'); title('(c) Narrower vs wider standard deviation', 'FontSize', 10);
for k = 1:3, subplot(1, 3, k); xlabel('Annual precipitation (inches)'); box off; grid on; set(gca, 'GridAlpha', 0.2); xlim([10 70]); end
print('-dpng', '-r150', 'figure_matlab.png');
