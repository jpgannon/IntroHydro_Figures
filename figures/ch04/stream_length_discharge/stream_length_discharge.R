# Stream length vs discharge (expansion and contraction of the network)
# Chapter 4 draft; data supplied by the chapter author (figs/fig12.csv)
# Run: Rscript stream_length_discharge.R  ->  figure_r.png (base R, no packages needed)

a <- read.csv("fig12.csv", stringsAsFactors = FALSE)

png("figure_r.png", width = 1050, height = 750, res = 150)
par(mfrow = c(1, 1), mar = c(4.2, 4.6, 2.2, 1), las = 1)
plot(NA, xlim = range(c(a[a$record_type == "fit", ]$discharge_mm_per_d, a[a$record_type == "observation", ]$discharge_mm_per_d), na.rm = TRUE), ylim = range(c(a[a$record_type == "fit", ]$stream_length_fit_km, a[a$record_type == "observation", ]$stream_length_obs_km), na.rm = TRUE), log = "x", xlab = "Discharge (mm/day)", ylab = "Flowing stream length (km)", bty = "l", xaxs = "i")
grid(col = "grey88")
lines(a[a$record_type == "fit", ]$discharge_mm_per_d, a[a$record_type == "fit", ]$stream_length_fit_km, col = "#1f4e79", lwd = 1.6, lty = 1)
points(a[a$record_type == "observation", ]$discharge_mm_per_d, a[a$record_type == "observation", ]$stream_length_obs_km, col = "#e8743b", pch = 19, cex = 1.0)
legend("topleft", legend = c("Fit", "Observed surveys"), col = c("#1f4e79", "#e8743b"), lty = c(1, 0), pch = c(NA, 19), bty = "n", cex = 0.8)

invisible(dev.off())
