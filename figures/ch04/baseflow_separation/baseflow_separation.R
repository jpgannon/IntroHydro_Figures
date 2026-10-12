# Baseflow separation: fixed-interval vs digital filter
# Chapter 4 draft; data supplied by the chapter author (figs/fig9.csv)
# Run: Rscript baseflow_separation.R  ->  figure_r.png (base R, no packages needed)

a <- read.csv("fig9.csv", stringsAsFactors = FALSE)
a$date <- as.Date(a$date, format = "%d-%b-%Y")

png("figure_r.png", width = 1200, height = 675, res = 150)
par(mfrow = c(1, 1), mar = c(4.2, 4.6, 2.2, 1), las = 1)
plot(NA, xlim = range(c(a$date, a$date, a$date), na.rm = TRUE), ylim = range(c(a$streamflow_cfs, a$baseflow_fixed_interval_cfs, a$baseflow_digital_filter_cfs), na.rm = TRUE), log = "", xlab = "", ylab = "Discharge (cfs)", bty = "l", xaxt = "n", xaxs = "i")
grid(col = "grey88")
axis.Date(1, x = a$date, format = "%b %Y")
lines(a$date, a$streamflow_cfs, col = "#222222", lwd = 1.6, lty = 1)
lines(a$date, a$baseflow_fixed_interval_cfs, col = "#e8743b", lwd = 1.6, lty = 1)
lines(a$date, a$baseflow_digital_filter_cfs, col = "#1f4e79", lwd = 1.6, lty = 1)
legend("topright", legend = c("Streamflow", "Baseflow (fixed interval)", "Baseflow (digital filter)"), col = c("#222222", "#e8743b", "#1f4e79"), lty = c(1, 1, 1), pch = c(NA, NA, NA), bty = "n", cex = 0.8)

invisible(dev.off())
