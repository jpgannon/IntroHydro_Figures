# Chapter 1 - Volumes of Earth's water storage pools (Table 1.1 as a log-scale bar chart)
# Data: Table 1.1 of the Chapter 1 draft (volume and range of reported values, km^3)
pools <- data.frame(
  name = c("Ocean, deep","Ocean, mixed layer","Ice sheets & glaciers","Groundwater","Permafrost",
           "Lakes (fresh)","Lakes (saline)","Soil moisture","Wetlands","Reservoirs",
           "Atmosphere (over ocean)","Atmosphere (over land)","Snowpack","Rivers","Biosphere"),
  vol  = c(1206e6,134e6,25.8e6,22.6e6,207e3,108e3,94.7e3,54.1e3,14.1e3,10.8e3,10e3,3e3,2.9e3,1.9e3,1.12e3),
  lo   = c(1100e6,90e6,24.064e6,8.06e6,22e3,91e3,85.4e3,16.5e3,11e3,7e3,8e3,2.7e3,2.6e3,1.25e3,NA),
  hi   = c(1300e6,170e6,29.2e6,23.4e6,300e3,125e3,104e3,122e3,17e3,15e3,12e3,3.3e3,3.5e3,2.12e3,NA)
)  # saline-lake low value: draft table reads "85,4000"; assumed 85,400
n <- nrow(pools)
png("figure_r.png", width = 1200, height = 900, res = 150)
par(mar = c(4.5, 11, 3, 1))
y <- barplot(rev(pools$vol), horiz = TRUE, log = "x", col = "#2b6cb0", border = NA,
             xlim = c(500, 5e9), names.arg = rev(pools$name), las = 1, xaxt = "n",
             xlab = "Volume (km^3), log scale", main = "Estimated sizes of global water storage pools")
axis(1, at = 10^(3:9), labels = c("1e3","1e4","1e5","1e6","1e7","1e8","1e9"))
ok <- !is.na(pools$lo)
arrows(rev(pools$lo)[rev(ok)], y[rev(ok)], rev(pools$hi)[rev(ok)], y[rev(ok)],
       angle = 90, code = 3, length = 0.03)
dev.off()
