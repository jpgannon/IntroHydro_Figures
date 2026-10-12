% USDA soil texture triangle
% Chapter 7 draft (Figure "Texture"); classes computed from the standard USDA texture-class rules (sand, silt, clay in % by weight)
% Run: run soil_texture_triangle.m -> figure_matlab.png (MATLAB or GNU Octave)
clear; close all;
nm = {'Sand', 'Loamy sand', 'Sandy loam', 'Loam', 'Silt loam', 'Silt', 'Sandy clay loam', 'Clay loam', 'Silty clay loam', 'Sandy clay', 'Silty clay', 'Clay'};
H = sqrt(3) / 2;
[xs, ys] = meshgrid(linspace(0, 1, 600), linspace(0, H, 520));
clay = 100 * ys / H; silt = 100 * (xs - 0.5 * clay / 100); sand = 100 - clay - silt;
inside = clay >= 0 & silt >= 0 & sand >= 0;
rules = cell(1, 12);
rules{1}  = silt + 1.5 * clay < 15;
rules{2}  = silt + 1.5 * clay >= 15 & silt + 2 * clay < 30;
rules{3}  = (clay >= 7 & clay < 20 & sand > 52 & silt + 2 * clay >= 30) | (clay < 7 & silt < 50 & silt + 2 * clay >= 30);
rules{4}  = clay >= 7 & clay < 27 & silt >= 28 & silt < 50 & sand <= 52;
rules{5}  = (silt >= 50 & clay >= 12 & clay < 27) | (silt >= 50 & silt < 80 & clay < 12);
rules{6}  = silt >= 80 & clay < 12;
rules{7}  = clay >= 20 & clay < 35 & silt < 28 & sand > 45;
rules{8}  = clay >= 27 & clay < 40 & sand > 20 & sand <= 45;
rules{9}  = clay >= 27 & clay < 40 & sand <= 20;
rules{10} = clay >= 35 & sand > 45;
rules{11} = clay >= 40 & silt >= 40;
rules{12} = clay >= 40 & sand <= 45 & silt < 40;
cls = nan(size(xs));
for k = 1:12, cls(isnan(cls) & rules{k} & inside) = k; end
cols = [0.553 0.827 0.78; 1 1 0.702; 0.745 0.729 0.855; 0.984 0.502 0.447; 0.502 0.694 0.827; 0.992 0.706 0.384; 0.702 0.871 0.412; 0.988 0.804 0.898; 0.851 0.851 0.851; 0.737 0.502 0.741; 0.8 0.922 0.773; 1 0.929 0.435];
figure('Visible', 'off', 'Position', [100 100 750 660], 'Color', 'w'); hold on;
rgb = ones([size(cls) 3]);
for k = 1:12, mk = cls == k; for c = 1:3, tmp = rgb(:,:,c); tmp(mk) = cols(k, c); rgb(:,:,c) = tmp; end, end
image([0 1], [0 H], rgb); set(gca, 'YDir', 'normal');
plot([0 1 0.5 0], [0 0 H 0], 'k-', 'LineWidth', 1.5);
for k = 1:12
  mk = cls == k; if any(mk(:)), text(mean(xs(mk)), mean(ys(mk)), strrep(nm{k}, ' ', char(10)), 'HorizontalAlignment', 'center', 'FontSize', 7); end
end
for v = 10:10:90
  text(0.5 * v / 100 - 0.035, H * v / 100, num2str(v), 'FontSize', 6, 'HorizontalAlignment', 'center');
  text(1 - v / 100, -0.03, num2str(v), 'FontSize', 6, 'HorizontalAlignment', 'center');
  text(1 - 0.5 * (100 - v) / 100 + 0.035, H * (100 - v) / 100, num2str(v), 'FontSize', 6, 'HorizontalAlignment', 'center');
end
text(0.2, 0.5 * H + 0.05, 'Clay (%)', 'Rotation', 60, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
text(0.5, -0.08, 'Sand (%)', 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
text(0.8, 0.5 * H + 0.05, 'Silt (%)', 'Rotation', -60, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
axis equal off; xlim([-0.08 1.08]); ylim([-0.12 H + 0.05]);
print('-dpng', '-r150', 'figure_matlab.png');
