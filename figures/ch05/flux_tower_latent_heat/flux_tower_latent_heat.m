% Latent heat flux (LE) from an eddy-covariance flux tower, one week in summer
% Chapter 5 draft; data: Desai (2026), AmeriFlux FLUXNET-1F US-WCr Willow Creek v1.3_r1, doi:10.17190/AMF/3028955 (CC-BY-4.0)
% Run: run flux_tower_latent_heat.m  ->  figure_matlab.png (works in MATLAB and GNU Octave)
clear; close all;

fid = fopen('flux_tower_LE.csv'); fgetl(fid);
C = textscan(fid, '%s%s%f%f', 'Delimiter', ',', 'EmptyValue', NaN); fclose(fid);
a.TIMESTAMP_START = C{1};
a.TIMESTAMP_END = C{2};
a.LE_CORR_Wm2 = C{3};
a.LE_RANDUNC_Wm2 = C{4};
a.TIMESTAMP_START = strrep(a.TIMESTAMP_START, '"', '');
a.TIMESTAMP_END = strrep(a.TIMESTAMP_END, '"', '');
a.TIMESTAMP_START = datenum(a.TIMESTAMP_START, 'yyyy-mm-dd HH:MM:SS');
a_t0 = floor(min(a.TIMESTAMP_START));  a.TIMESTAMP_START = a.TIMESTAMP_START - a_t0;   % offset keeps plotting precision (Octave uses single precision)
a.lo = a.LE_CORR_Wm2 - a.LE_RANDUNC_Wm2;
a.hi = a.LE_CORR_Wm2 + a.LE_RANDUNC_Wm2;

figure('Visible', 'off', 'Position', [100 100 900 450], 'Color', 'w');
subplot(1, 1, 1); hold on;
xx = a.TIMESTAMP_START(:)'; hi_ = a.hi(:)'; lo_ = a.lo(:)'; ok = ~isnan(hi_); h0 = patch('XData', [xx(ok) fliplr(xx(ok))]', 'YData', [hi_(ok) fliplr(lo_(ok))]', 'FaceColor', [0.62, 0.773, 0.91], 'EdgeColor', 'none', 'FaceAlpha', 0.6);
h1 = plot(a.TIMESTAMP_START, a.LE_CORR_Wm2, '-', 'Color', [0.122, 0.306, 0.475], 'LineWidth', 1);
xt = get(gca, 'XTick'); set(gca, 'XTick', xt, 'XTickLabel', datestr(xt + a_t0, 'dd mmm'));
ylabel('Latent heat flux, LE (W/m²)');
box off; grid on; set(gca, 'GridAlpha', 0.2, 'Layer', 'top');
legend([h0, h1], {'± random uncertainty', 'LE (corrected)'}, 'Location', 'northeast'); legend boxoff;

print('-dpng', '-r150', 'figure_matlab.png');
