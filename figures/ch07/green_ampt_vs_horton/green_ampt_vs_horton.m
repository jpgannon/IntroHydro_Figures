% Green–Ampt vs Horton infiltration capacity
% Chapter 7 draft; parameters from the chapter author (Figures_4_5_6_and_Table1_2026_10_02.xlsx, GreenAmpt sheet)
% Run: run green_ampt_vs_horton.m -> figure_matlab.png (MATLAB or GNU Octave)
clear; close all;
% Silty clay, Campbell parameters (GreenAmpt sheet). Units: mm and hours.
phi = 0.492; theta_i = 0.37; Ks = 3.72; psi_f = 70; r = 10;
f0 = 30; fc = Ks; beta = 3;
dtheta = phi - theta_i; dt = 0.02; t = 0:dt:3;
I = zeros(size(t)); ipot = zeros(size(t)); iact = zeros(size(t));
for k = 1:numel(t)
  if I(k) > 0, ipot(k) = Ks * (1 + psi_f * dtheta / I(k)); else, ipot(k) = Inf; end
  iact(k) = min(r, ipot(k));
  if k < numel(t), I(k + 1) = I(k) + iact(k) * dt; end
end
horton = fc + (f0 - fc) * exp(-beta * t);

A = psi_f * dtheta;
Fp = linspace(1e-3, 80, 4000); tp = (Fp - A * log(1 + Fp / A)) / Ks; fg = Ks * (1 + A ./ Fp);
figure('Visible', 'off', 'Position', [100 100 750 480], 'Color', 'w'); hold on;
h1 = plot(tp, fg, '-', 'Color', [0.18 0.545 0.341], 'LineWidth', 2.2);
h2 = plot(t, horton, '--', 'Color', [0.91 0.455 0.231], 'LineWidth', 2.2);
plot([0 3], [Ks Ks], ':', 'Color', [0.5 0.5 0.5]);
xlim([0 3]); ylim([0 45]); xlabel('Time (hr)'); ylabel('Infiltration capacity (mm/hr)');
legend([h1 h2], {'Green-Ampt (ponded from t = 0)', 'Horton'}, 'Location', 'northeast'); legend boxoff;
box off; grid on; set(gca, 'GridAlpha', 0.2);
print('-dpng', '-r150', 'figure_matlab.png');
