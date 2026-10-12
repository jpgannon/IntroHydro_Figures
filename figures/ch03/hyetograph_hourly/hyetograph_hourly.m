% Chapter 3, Figure 3.16 - Hourly hyetograph for a 24-hour period (21 mm total)
hrs = 1:24;
v = zeros(1, 24); v([3 4 5 6 7 8 14 15 16 20 21]) = [0.5 1.5 8 4 2 0.5 0.5 1.5 0.5 1 1];
assert(abs(sum(v) - 21) < 1e-9)
fig = figure('Position', [100 100 800 400]);
ax = axes(fig); hold(ax, 'on');
for k = 1:24
    patch(ax, k + [-0.45 0.45 0.45 -0.45], [0 0 v(k) v(k)], [0.169 0.424 0.69], 'EdgeColor', [0.1 0.21 0.39]);
end
set(ax, 'YDir', 'reverse', 'XAxisLocation', 'top', 'XTick', 0:3:24, 'Box', 'off');
xlim(ax, [0.3 24.7]); ylim(ax, [0 10]);
xlabel(ax, 'Hour ending (h, May 25, 2026)'); ylabel(ax, 'Precipitation (mm/hr)');
print(fig, '-dpng', '-r150', 'figure_matlab.png');
