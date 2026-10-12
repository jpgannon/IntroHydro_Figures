% Soil water retention curves: Brooks–Corey, Campbell and van Genuchten (sandy loam and silty clay)
% Chapter 7 draft; parameters from the chapter author (Figures_4_5_6_and_Table1_2026_10_02.xlsx, RetentionCurves sheet; Clapp & Hornberger 1978 / Rawls et al. parameter sets)
% Run: run retention_curve_models.m -> figure_matlab.png (MATLAB or GNU Octave)
clear; close all;
% Parameters (RetentionCurves sheet). psi_ae = air-entry (cm); b = pore-size exponent.
names = {'Sandy loam', 'Silty clay'};
phi = [0.435 0.492]; thr = [0.06 0.241]; psi_ae = [21.8 49]; b_bc = [3.9 4.4]; b_camp = [4.9 10.4]; alpha = [0.025 0.01]; n = [1.3 1.3];
figure('Visible', 'off', 'Position', [100 100 1000 460], 'Color', 'w');
for i = 1:2
  subplot(1, 2, i); hold on;
  th = linspace(thr(i) + 0.01, phi(i) - 0.002, 400);
  se = (th - thr(i)) / (phi(i) - thr(i)); m = 1 - 1 / n(i);
  h1 = plot(th, psi_ae(i) * se.^(-b_bc(i)), '-', 'Color', [0.122 0.306 0.475], 'LineWidth', 2);
  h2 = plot(th, psi_ae(i) * (th / phi(i)).^(-b_camp(i)), '--', 'Color', [0.91 0.455 0.231], 'LineWidth', 2);
  h3 = plot(th, (se.^(-1 / m) - 1).^(1 / n(i)) / alpha(i), ':', 'Color', [0.18 0.545 0.341], 'LineWidth', 2);
  plot(xlim, [340 340], ':', 'Color', [0.5 0.5 0.5]); plot(xlim, [15300 15300], ':', 'Color', [0.5 0.5 0.5]);
  set(gca, 'YScale', 'log'); ylim([1 1e7]); xlabel('Volumetric water content, \theta (m^3/m^3)');
  if i == 1, ylabel('Matric potential magnitude, |\psi| (cm)'); legend([h1 h2 h3], {'Brooks-Corey', 'Campbell', 'van Genuchten'}, 'Location', 'northeast'); legend boxoff; end
  title(names{i}, 'FontSize', 10); box off; grid on; set(gca, 'GridAlpha', 0.2);
end
print('-dpng', '-r150', 'figure_matlab.png');
