% Chapter 1 - Volumes of Earth's water storage pools (Table 1.1 as a log-scale bar chart)
% Data: Table 1.1 of the Chapter 1 draft (volume and range of reported values, km^3)
names = {'Ocean, deep','Ocean, mixed layer','Ice sheets & glaciers','Groundwater','Permafrost', ...
         'Lakes (fresh)','Lakes (saline)','Soil moisture','Wetlands','Reservoirs', ...
         'Atmosphere (over ocean)','Atmosphere (over land)','Snowpack','Rivers','Biosphere'};
vol = [1206e6 134e6 25.8e6 22.6e6 207e3 108e3 94.7e3 54.1e3 14.1e3 10.8e3 10e3 3e3 2.9e3 1.9e3 1.12e3];
lo  = [1100e6 90e6 24.064e6 8.06e6 22e3 91e3 85.4e3 16.5e3 11e3 7e3 8e3 2.7e3 2.6e3 1.25e3 NaN];
hi  = [1300e6 170e6 29.2e6 23.4e6 300e3 125e3 104e3 122e3 17e3 15e3 12e3 3.3e3 3.5e3 2.12e3 NaN];
% (saline-lake low value: draft table reads "85,4000"; assumed 85,400)
n = numel(vol); y = n:-1:1;
fig = figure('Position',[100 100 900 650]);
ax = axes(fig); hold(ax,'on'); set(ax,'XScale','log');
for k = 1:n
    patch(ax, [500 vol(k) vol(k) 500], [y(k)-0.35 y(k)-0.35 y(k)+0.35 y(k)+0.35], [0.17 0.42 0.69], 'EdgeColor','none');
end
ok = ~isnan(lo);
for k = find(ok)
    plot(ax, [lo(k) hi(k)], [y(k) y(k)], 'k-', 'LineWidth',1);
end
set(ax,'YTick',sort(y),'YTickLabel',fliplr(names),'XLim',[500 5e9],'YLim',[0.4 n+0.6]);
xlabel(ax,'Volume (km^3), log scale'); title(ax,'Estimated sizes of global water storage pools');
grid(ax,'on'); box(ax,'off');
print(fig,'-dpng','-r150','figure_matlab.png');
