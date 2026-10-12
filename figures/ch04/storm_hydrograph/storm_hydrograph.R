# Storm hydrograph with rainfall, baseflow and stormflow
# Chapter 4 draft; data supplied by the chapter author (figs/fig1_timeseries.csv)
# Run: Rscript storm_hydrograph.R  ->  figure_r.png (base R, no packages needed)

a <- read.csv("fig1_timeseries.csv", stringsAsFactors = FALSE)

png("figure_r.png", width = 1200, height = 900, res = 150)
par(mfrow = c(2, 1), mar = c(4.2, 4.6, 2.2, 1), las = 1)
layout(matrix(1:2, ncol = 1), heights = c(1.5,2.6))
par(mar = c(4.2, 4.6, 2.2, 1), las = 1)
plot(NA, xlim = c(0, 2.5), ylim = c(40, 0), log = "", xlab = "", ylab = "Rainfall (mm/h)", bty = "l", xaxs = "i")
grid(col = "grey88")
rect(a$time_d - 0.010416666666666666/2, 0, a$time_d + 0.010416666666666666/2, a$rainfall_mm_per_h, col = "#1f4e79", border = NA)

plot(NA, xlim = c(0, 2.5), ylim = range(c(a$streamflow_m3_per_s, a$baseflow_m3_per_s, a$stormflow_m3_per_s), na.rm = TRUE), log = "", xlab = "Time (days)", ylab = "Discharge (m³/s)", bty = "l", xaxs = "i")
grid(col = "grey88")
lines(a$time_d, a$streamflow_m3_per_s, col = "#222222", lwd = 2, lty = 1)
lines(a$time_d, a$baseflow_m3_per_s, col = "#5a9e6f", lwd = 1.6, lty = 2)
lines(a$time_d, a$stormflow_m3_per_s, col = "#e8743b", lwd = 1.6, lty = 2)
legend("topright", legend = c("Streamflow", "Baseflow", "Stormflow"), col = c("#222222", "#5a9e6f", "#e8743b"), lty = c(1, 2, 2), pch = c(NA, NA, NA), bty = "n", cex = 0.8)

invisible(dev.off())
