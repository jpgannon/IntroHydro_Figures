% Green–Ampt infiltration under constant rainfall (silty clay)
% Chapter 7 draft; parameters from the chapter author (Figures_4_5_6_and_Table1_2026_10_02.xlsx, GreenAmpt sheet); explicit time stepping dt = 0.02 h as in the workbook
% Run: run green_ampt_infiltration.m -> figure_matlab.png (MATLAB or GNU Octave)
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

figure('Visible', 'off', 'Position', [100 100 750 480], 'Color', 'w'); hold on;
h1 = plot(t, min(ipot, 60), '--', 'Color', [0.18 0.545 0.341], 'LineWidth', 2);
h2 = plot(t, iact, '-', 'Color', [0.122 0.306 0.475], 'LineWidth', 2.4);
h3 = plot([0 3], [r r], '-', 'Color', [0.91 0.455 0.231], 'LineWidth', 1.6);
h4 = plot([0 3], [Ks Ks], ':', 'Color', [0.5 0.5 0.5]);
ylim([0 40]); xlim([0 3]); xlabel('Time (hr)'); ylabel('Rate (mm/hr)');
legend([h1 h2 h3 h4], {'Green-Ampt capacity', 'Actual infiltration', 'Rainfall rate', 'Ks'}, 'Location', 'northeast'); legend boxoff;
box off; grid on; set(gca, 'GridAlpha', 0.2);
print('-dpng', '-r150', 'figure_matlab.png');
