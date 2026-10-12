# Stage–discharge rating curve with 95% interval
# Chapter 4 draft; data supplied by the chapter author (figs/fig8_measurements_with_fit.csv, fig8_rating_fit.csv)
# Run: Rscript rating_curve.R  ->  figure_r.png (base R, no packages needed)

a <- read.csv("fig8_measurements_with_fit.csv", stringsAsFactors = FALSE)

b <- read.csv("fig8_rating_fit.csv", stringsAsFactors = FALSE)

png("figure_r.png", width = 1050, height = 750, res = 150)
par(mfrow = c(1, 1), mar = c(4.2, 4.6, 2.2, 1), las = 1)
plot(NA, xlim = range(c(b$gage_height_ft, b$gage_height_ft, a$gage_height_ft), na.rm = TRUE), ylim = range(c(b$Q_upper_95_cfs, b$Q_lower_95_cfs, b$Q_fit_cfs, a$discharge_cfs), na.rm = TRUE), log = "y", xlab = "Gage height (ft)", ylab = "Discharge (cfs)", bty = "l", xaxs = "i")
grid(col = "grey88")
polygon(c(b$gage_height_ft, rev(b$gage_height_ft)), c(b$Q_upper_95_cfs, rev(b$Q_lower_95_cfs)), col = adjustcolor("#9ec5e8", alpha.f = 0.6), border = NA)
lines(b$gage_height_ft, b$Q_fit_cfs, col = "#1f4e79", lwd = 1.6, lty = 1)
points(a$gage_height_ft, a$discharge_cfs, col = "#e8743b", pch = 19, cex = 0.47)
legend("bottomright", legend = c("95% interval", "Fitted rating", "Measurements"), col = c("#9ec5e8", "#1f4e79", "#e8743b"), lty = c(0, 1, 0), pch = c(15, NA, 19), bty = "n", cex = 0.8)

invisible(dev.off())
