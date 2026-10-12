% Chapter 8 - Idealized slug-test response (Hvorslev) for a high-K and a low-K well
T37_HIGH = 3; T37_LOW = 30;       % min, basic time lag
tmin = -20; tmax = 120;
BLUE = [0.165 0.47 0.839]; ORANGE = [0.922 0.408 0.204]; MUTED = [0.537 0.529 0.506];
ta = linspace(0, tmax, 500); ta = ta(2:end);
fig = figure('Position', [100 100 800 450]); hold on
plot([0 0], [-0.05 1.2], '--', 'Color', MUTED); plot([0 T37_LOW], [0.37 0.37], '--', 'Color', MUTED);
T37s = [T37_HIGH T37_LOW]; cols = [BLUE; ORANGE]; h = zeros(1, 2);
for k = 1:2
    t = [tmin 0 0 ta]; hh = [0 0 1 exp(-ta / T37s(k))];
    h(k) = plot(t, hh, 'Color', cols(k,:), 'LineWidth', 2);
    plot([T37s(k) T37s(k)], [-0.05 0.37], '--', 'Color', cols(k,:));
    plot(T37s(k), 0.37, 'o', 'MarkerFaceColor', cols(k,:), 'MarkerEdgeColor', 'w', 'MarkerSize', 8);
end
text(0, 1.17, 'slug added', 'HorizontalAlignment', 'center', 'FontWeight', 'bold');
text(8, 0.14, sprintf('T37 = %d min', T37_HIGH), 'Color', BLUE, 'FontWeight', 'bold');
text(36, 0.52, sprintf('T37 = %d min', T37_LOW), 'Color', ORANGE, 'FontWeight', 'bold');
text(tmin + 1, 0.39, 'H/H0 = 0.37', 'Color', MUTED); text(tmin + 1, 0.03, 'steady', 'Color', MUTED);
xlim([tmin tmax]); ylim([-0.05 1.2]); set(gca, 'YTick', 0:0.2:1); grid on; box off
xlabel('Time relative to slug (min)'); ylabel('Head above static level, H/H0');
legend(h, {'High K well', 'Low K well'}, 'Location', 'northeast', 'Box', 'off');
print(fig, '-dpng', '-r150', 'figure_matlab.png');
