# Hydrograph by runoff pathway (stacked)
# Chapter 4 draft; data supplied by the chapter author (figs/fig3_timeseries.csv)
# Run: Rscript runoff_pathways.R  ->  figure_r.png (base R, no packages needed)

a <- read.csv("fig3_timeseries.csv", stringsAsFactors = FALSE)
a$c1 <- a$groundwater_m3_per_s
a$c2 <- a$groundwater_m3_per_s + a$interflow_m3_per_s
a$c3 <- a$groundwater_m3_per_s + a$interflow_m3_per_s + a$overland_flow_m3_per_s
a$c4 <- a$groundwater_m3_per_s + a$interflow_m3_per_s + a$overland_flow_m3_per_s + a$channel_precip_m3_per_s

png("figure_r.png", width = 1200, height = 900, res = 150)
par(mfrow = c(2, 1), mar = c(4.2, 4.6, 2.2, 1), las = 1)
layout(matrix(1:2, ncol = 1), heights = c(1.5,2.6))
par(mar = c(4.2, 4.6, 2.2, 1), las = 1)
plot(NA, xlim = c(0, 3), ylim = c(40, 0), log = "", xlab = "", ylab = "Rainfall (mm/h)", bty = "l", xaxs = "i")
grid(col = "grey88")
rect(a$time_d - 0.010416666666666666/2, 0, a$time_d + 0.010416666666666666/2, a$rainfall_mm_per_h, col = "#1f4e79", border = NA)

plot(NA, xlim = c(0, 3), ylim = range(c(a$c4, a$c3, a$c3, a$c2, a$c2, a$c1, a$c1, 0), na.rm = TRUE), log = "", xlab = "Time (days)", ylab = "Discharge (m³/s)", bty = "l", xaxs = "i")
grid(col = "grey88")
polygon(c(a$time_d, rev(a$time_d)), c(a$c4, rev(a$c3)), col = adjustcolor("#7fb3d5", alpha.f = 0.9), border = NA)
polygon(c(a$time_d, rev(a$time_d)), c(a$c3, rev(a$c2)), col = adjustcolor("#e8743b", alpha.f = 0.9), border = NA)
polygon(c(a$time_d, rev(a$time_d)), c(a$c2, rev(a$c1)), col = adjustcolor("#5a9e6f", alpha.f = 0.9), border = NA)
polygon(c(a$time_d, rev(a$time_d)), c(a$c1, rev(rep(0, length(a$time_d)))), col = adjustcolor("#8c6d46", alpha.f = 0.9), border = NA)
legend("topright", legend = c("Channel precipitation", "Overland flow", "Interflow", "Groundwater"), col = c("#7fb3d5", "#e8743b", "#5a9e6f", "#8c6d46"), lty = c(0, 0, 0, 0), pch = c(15, 15, 15, 15), bty = "n", cex = 0.8)

invisible(dev.off())
