# Figure 3.9: Hyetographs for a frontal storm (March) and a convective storm (June)
# Chapter 3 draft; data supplied by chapter author (Figure_3_9_Timeseries.xlsx; Hubbard Brook rain gage, 15-min)
# Run: Rscript hyetographs_frontal_convective.R  ->  figure_r.png (base R, no packages needed)

a <- read.csv("hyetograph_frontal_march.csv", stringsAsFactors = FALSE)
a$datetime <- as.POSIXct(a$datetime, format = "%Y-%m-%d %H:%M:%S", tz = "UTC")

b <- read.csv("hyetograph_convective_june.csv", stringsAsFactors = FALSE)
b$datetime <- as.POSIXct(b$datetime, format = "%Y-%m-%d %H:%M:%S", tz = "UTC")

png("figure_r.png", width = 1200, height = 900, res = 150)
par(mfrow = c(2, 1), mar = c(4.2, 4.6, 2.2, 1), las = 1)
plot(NA, xlim = range(c(a$datetime), na.rm = TRUE), ylim = c(1.0, 0), log = "", xlab = "Time of day", ylab = "Precipitation (mm per 15 min)", bty = "l", xaxt = "n", xaxs = "i")
grid(col = "grey88")
axis.POSIXct(1, x = a$datetime, format = "%H:%M")
rect(a$datetime - 900.0/2, 0, a$datetime + 900.0/2, a$precip_mm, col = "#1f4e79", border = NA)
mtext("(a) Frontal storm, 31 March 2025", side = 3, adj = 0, line = 0.5, cex = 0.8, font = 2)

plot(NA, xlim = range(c(b$datetime), na.rm = TRUE), ylim = c(6, 0), log = "", xlab = "Time of day", ylab = "Precipitation (mm per 15 min)", bty = "l", xaxt = "n", xaxs = "i")
grid(col = "grey88")
axis.POSIXct(1, x = b$datetime, format = "%H:%M")
rect(b$datetime - 900.0/2, 0, b$datetime + 900.0/2, b$precip_mm, col = "#1f4e79", border = NA)
mtext("(b) Convective storm, 6 June 2025", side = 3, adj = 0, line = 0.5, cex = 0.8, font = 2)

invisible(dev.off())
