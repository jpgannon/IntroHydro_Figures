# Conductivity ratio vs slope for different hillslope length-to-depth ratios
# Chapter 4 draft; data supplied by the chapter author (figs/fig11.csv)
# Run: Rscript hydraulic_conductivity_ratio.R  ->  figure_r.png (base R, no packages needed)

a <- read.csv("fig11.csv", stringsAsFactors = FALSE)

png("figure_r.png", width = 1050, height = 750, res = 150)
par(mfrow = c(1, 1), mar = c(4.2, 4.6, 2.2, 1), las = 1)
plot(NA, xlim = range(c(a$slope, a$slope, a$slope, a$slope, a$slope, a$slope, a$slope), na.rm = TRUE), ylim = range(c(a$Kratio_LD_10m, a$Kratio_LD_20m, a$Kratio_LD_30m, a$Kratio_LD_40m, a$Kratio_LD_50m, a$Kratio_LD_100m, a$Kratio_LD_200m), na.rm = TRUE), log = "xy", xlab = "Slope (m/m)", ylab = "K ratio", bty = "l", xaxs = "i")
grid(col = "grey88")
lines(a$slope, a$Kratio_LD_10m, col = "#08306b", lwd = 1.6, lty = 1)
lines(a$slope, a$Kratio_LD_20m, col = "#08519c", lwd = 1.6, lty = 1)
lines(a$slope, a$Kratio_LD_30m, col = "#2171b5", lwd = 1.6, lty = 1)
lines(a$slope, a$Kratio_LD_40m, col = "#4292c6", lwd = 1.6, lty = 1)
lines(a$slope, a$Kratio_LD_50m, col = "#6baed6", lwd = 1.6, lty = 1)
lines(a$slope, a$Kratio_LD_100m, col = "#9ecae1", lwd = 1.6, lty = 1)
lines(a$slope, a$Kratio_LD_200m, col = "#c6dbef", lwd = 1.6, lty = 1)
legend("topright", legend = c("10 m", "20 m", "30 m", "40 m", "50 m", "100 m", "200 m"), col = c("#08306b", "#08519c", "#2171b5", "#4292c6", "#6baed6", "#9ecae1", "#c6dbef"), lty = c(1, 1, 1, 1, 1, 1, 1), pch = c(NA, NA, NA, NA, NA, NA, NA), bty = "n", cex = 0.8)

invisible(dev.off())
