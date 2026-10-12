# Daily snowmelt vs air temperature, Bogus Basin, April 2023 (degree-day regression)
# Chapter 6 draft; data supplied by chapter author (bogus_basin_april2023_temp_melt.csv)
# Run: Rscript temperature_melt_regression.R -> figure_r.png (base R, no packages)
d <- read.csv("bogus_basin_april2023_temp_melt.csv")
fit <- lm(melt_mm ~ temp_c, data = d)
r2 <- summary(fit)$r.squared
png("figure_r.png", width = 1050, height = 750, res = 150)
par(mar = c(4.5, 4.5, 1, 1), las = 1)
plot(d$temp_c, d$melt_mm, pch = 19, col = "#1f4e79", xlab = "Mean daily air temperature (°C)", ylab = "Daily snowmelt (mm)", bty = "l")
grid(col = "grey88")
abline(fit, col = "#e8743b", lwd = 2)
legend("topleft", bty = "n", lty = c(NA, 1), pch = c(19, NA), col = c("#1f4e79", "#e8743b"), lwd = c(NA, 2),
       legend = c("Daily observations", sprintf("Fit: melt = %.2f T %+.2f  (R² = %.2f)", coef(fit)[2], coef(fit)[1], r2)))
invisible(dev.off())
