# Chapter 3, Figure 3.16 - Hourly hyetograph for a 24-hour period (21 mm total)
hrs <- 1:24
v <- numeric(24); v[c(3,4,5,6,7,8,14,15,16,20,21)] <- c(0.5,1.5,8,4,2,0.5,0.5,1.5,0.5,1,1)
stopifnot(abs(sum(v) - 21) < 1e-9)
png("figure_r.png", width = 1200, height = 600, res = 150)
par(mar = c(1, 4.5, 4.5, 1))
plot(NA, xlim = c(0, 24.5), ylim = c(10, 0), xaxs = "i", yaxs = "i", xaxt = "n", bty = "n",
     xlab = "", ylab = "Precipitation (mm/hr)")
rect(hrs - 0.45, 0, hrs + 0.45, v, col = "#2b6cb0", border = "#1a365d")
axis(3, at = 3 * (0:8), labels = 3 * (0:8))
mtext("Hour ending (h, May 25, 2026)", side = 3, line = 2.5)
dev.off()
