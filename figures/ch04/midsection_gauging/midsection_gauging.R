# Velocity–area (mid-section) discharge measurement
# Chapter 4 draft; data supplied by the chapter author (figs/fig7_midsection.csv)
# Run: Rscript midsection_gauging.R  ->  figure_r.png (base R, no packages needed)

a <- read.csv("fig7_midsection.csv", stringsAsFactors = FALSE)
a$negd <- -a$depth_ft

png("figure_r.png", width = 1200, height = 975, res = 150)
par(mfrow = c(2, 1), mar = c(4.2, 4.6, 2.2, 1), las = 1)
layout(matrix(1:2, ncol = 1), heights = c(1,1))
par(mar = c(4.2, 4.6, 2.2, 1), las = 1)
plot(NA, xlim = range(c(a$distance_ft), na.rm = TRUE), ylim = range(c(a$negd, 0), na.rm = TRUE), log = "", xlab = "Distance from left edge of water (ft)", ylab = "Depth (ft, below water surface)", bty = "l", xaxs = "i")
grid(col = "grey88")
polygon(c(a$distance_ft, rev(a$distance_ft)), c(a$negd, rev(rep(0, length(a$distance_ft)))), col = adjustcolor("#7fb3d5", alpha.f = 0.8), border = NA)
legend("bottomright", legend = c("Water depth"), col = c("#7fb3d5"), lty = c(0), pch = c(15), bty = "n", cex = 0.8)

plot(NA, xlim = range(c(a$distance_ft), na.rm = TRUE), ylim = range(c(a$discharge_ft3_per_s, 0), na.rm = TRUE), log = "", xlab = "Distance from left edge of water (ft)", ylab = "Station discharge (ft³/s)", bty = "l", xaxs = "i")
grid(col = "grey88")
rect(a$distance_ft - 3.0/2, 0, a$distance_ft + 3.0/2, a$discharge_ft3_per_s, col = "#e8743b", border = NA)

invisible(dev.off())
