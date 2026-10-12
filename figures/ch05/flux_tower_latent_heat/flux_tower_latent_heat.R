# Latent heat flux (LE) from an eddy-covariance flux tower, one week in summer
# Chapter 5 draft; data: Desai (2026), AmeriFlux FLUXNET-1F US-WCr Willow Creek v1.3_r1, doi:10.17190/AMF/3028955 (CC-BY-4.0)
# Run: Rscript flux_tower_latent_heat.R  ->  figure_r.png (base R, no packages needed)

a <- read.csv("flux_tower_LE.csv", stringsAsFactors = FALSE)
a$TIMESTAMP_START <- as.POSIXct(a$TIMESTAMP_START, format = "%Y-%m-%d %H:%M:%S", tz = "UTC")
a$lo <- a$LE_CORR_Wm2 - a$LE_RANDUNC_Wm2
a$hi <- a$LE_CORR_Wm2 + a$LE_RANDUNC_Wm2

png("figure_r.png", width = 1350, height = 675, res = 150)
par(mfrow = c(1, 1), mar = c(4.2, 4.6, 2.2, 1), las = 1)
plot(NA, xlim = range(c(a$TIMESTAMP_START, a$TIMESTAMP_START), na.rm = TRUE), ylim = range(c(a$hi, a$lo, a$LE_CORR_Wm2, 0), na.rm = TRUE), log = "", xlab = "", ylab = "Latent heat flux, LE (W/m²)", bty = "l", xaxt = "n", xaxs = "i")
grid(col = "grey88")
axis.POSIXct(1, x = a$TIMESTAMP_START, format = "%d %b")
polygon(c(a$TIMESTAMP_START, rev(a$TIMESTAMP_START)), c(a$hi, rev(a$lo)), col = adjustcolor("#9ec5e8", alpha.f = 0.6), border = NA)
lines(a$TIMESTAMP_START, a$LE_CORR_Wm2, col = "#1f4e79", lwd = 1, lty = 1)
legend("topright", legend = c("± random uncertainty", "LE (corrected)"), col = c("#9ec5e8", "#1f4e79"), lty = c(0, 1), pch = c(15, NA), bty = "n", cex = 0.8)

invisible(dev.off())
