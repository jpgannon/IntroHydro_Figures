% Chapter 3, Figure 3.11 - Temperature versus saturation vapor pressure (dew point and RH)
es = @(T) 6.112 * exp(17.67 * T ./ (T + 243.5));       % hPa, Bolton (1980), T in deg C
dewpoint = @(e) 243.5 * log(e/6.112) ./ (17.67 - log(e/6.112));
T0 = 25; e0 = 20;
Td = dewpoint(e0); RH = 100 * e0 / es(T0);
T = linspace(-20, 40, 600);

fig = figure('Position',[100 100 1100 800]); hold on
patch([T fliplr(T)], [es(T) 80*ones(size(T))], [0.984 0.89 0.89], 'EdgeColor','none');
patch([T fliplr(T)], [es(T) zeros(size(T))], [0.871 0.922 0.969], 'EdgeColor','none');
plot(T, es(T), 'k', 'LineWidth', 2.5);
axis([-20 40 0 80]); box on
xlabel('Temperature (°C)', 'FontSize', 13); ylabel('Water-vapor pressure (hPa)', 'FontSize', 13);
title('Figure 3.11: Temperature versus saturation vapor pressure.', 'FontSize', 14);
text(31.5, 68, 'e_s(T)', 'FontSize', 15);
% parcel cooling at constant vapor pressure
plot([T0 Td+0.6], [e0 e0], 'k-', 'LineWidth', 3);
plot(Td+0.6+[1.2 0 1.2], e0+[0.8 0 -0.8], 'k-', 'LineWidth', 3);   % arrow head
plot([T0 Td], [e0 e0], 'ko', 'MarkerFaceColor','k', 'MarkerSize', 8);
plot([-20 Td], [e0 e0], 'k:');
plot([Td Td], [0 e0], 'k--'); plot([T0 T0], [0 e0], 'k--');
text(T0, e0+2.5, sprintf('RH ≈ %.0f%%', RH), 'HorizontalAlignment','center', 'FontSize', 12);
text((T0+Td)/2, e0-6, {'air parcel cools at','nearly constant','vapor pressure'}, 'HorizontalAlignment','center', 'FontAngle','italic');
annotation_x = [Td-0.4 -3]; plot(annotation_x, [e0+0.6 28], 'k-');
text(-8, 28, {'saturation reached:','RH = 100%,','dew point'}, 'HorizontalAlignment','center');
Tc = linspace(Td, -14, 100);
plot(Tc, es(Tc), 'Color', [0.8 0 0], 'LineWidth', 3.5);
text(-19.5, 8, {'condensation begins;','vapor pressure limited','to e_s(T) as parcel','cools further'}, 'Color',[0.8 0 0], 'FontAngle','italic');
text(-7.5, 56, {'supersaturated conditions','(e > e_s; beyond scope)'}, 'Color',[0.8 0 0], 'FontSize', 13, 'HorizontalAlignment','center');
text(34, 31, {'unsaturated','air parcels','(e < e_s)'}, 'Color',[0.12 0.37 0.75], 'FontSize', 13, 'HorizontalAlignment','center');
plot([19 6], [33 33], '-', 'Color',[0.15 0.25 0.75], 'LineWidth', 2);
text(12.5, 36.5, {'RH increases','as T decreases'}, 'Color',[0.15 0.25 0.75], 'FontAngle','italic', 'HorizontalAlignment','center');
text(Td, -9, sprintf('T_d = %.1f°C', Td), 'HorizontalAlignment','center'); text(T0, -9, '25°C', 'HorizontalAlignment','center');
text(10, -13, 'RH = e / e_s(T) × 100%   (actual vapor pressure e / saturation vapor pressure e_s)', 'HorizontalAlignment','center');
print(fig, '-dpng', '-r150', 'figure_matlab.png');
