# SNOTEL snow water equivalent, snow depth and USGS streamflow, WY2011–WY2012
# Chapter 6 draft; data supplied by chapter author (snotel1031_usgs06614800_WY2011_WY2012.csv)
# Run: Rscript snotel_swe_streamflow.R  ->  figure_r.png (base R, no packages needed)

a <- read.csv("snotel1031_usgs06614800_WY2011_WY2012.csv", stringsAsFactors = FALSE)
a$date <- as.Date(a$date, format = "%Y-%m-%d")

png("figure_r.png", width = 1200, height = 900, res = 150)
par(mfrow = c(2, 1), mar = c(4.2, 4.6, 2.2, 1), las = 1)
layout(matrix(1:2, ncol = 1), heights = c(1,1))
par(mar = c(4.2, 4.6, 2.2, 1), las = 1)
plot(NA, xlim = range(c(a$date, a$date), na.rm = TRUE), ylim = range(c(a$swe_mm, a$depth_mm), na.rm = TRUE), log = "", xlab = "", ylab = "Snow (mm)", bty = "l", xaxt = "n", xaxs = "i")
grid(col = "grey88")
axis.Date(1, x = a$date, format = "%b %Y")
lines(a$date, a$swe_mm, col = "#1f4e79", lwd = 1.6, lty = 1)
lines(a$date, a$depth_mm, col = "#777777", lwd = 1, lty = 1)
legend("topright", legend = c("SWE (mm)", "Snow depth (mm)"), col = c("#1f4e79", "#777777"), lty = c(1, 1), pch = c(NA, NA), bty = "n", cex = 0.8)

plot(NA, xlim = range(c(a$date), na.rm = TRUE), ylim = range(c(a$flow_cfs), na.rm = TRUE), log = "", xlab = "", ylab = "Streamflow (cfs)", bty = "l", xaxt = "n", xaxs = "i")
grid(col = "grey88")
axis.Date(1, x = a$date, format = "%b %Y")
lines(a$date, a$flow_cfs, col = "#e8743b", lwd = 1.6, lty = 1)

invisible(dev.off())
