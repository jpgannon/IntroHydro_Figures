# Chapter 5 - Crop coefficient curve for sweet corn (Idaho, USA). Data: 'Fig # - CropCoefficientCurve.xlsx'
# (duplicate rows in the spreadsheet removed). Reference: FAO Irrigation and Drainage Paper 56.
days <- c(0, 30, 60, 90, 110); kc <- c(0.30, 0.30, 1.15, 1.15, 1.05)
st <- data.frame(a = c(0, 30, 60, 90), b = c(30, 60, 90, 110),
                 name = c("Initial", "Development", "Mid-season", "Late season"),
                 col = c("#e8f1d4", "#d3e6f5", "#f7e6c4", "#f3d9d4"))
png("figure_r.png", width = 1050, height = 675, res = 150)
par(mar = c(4.5, 4.5, 3, 1), bty = "l")
plot(NA, xlim = c(0, 110), ylim = c(0, 1.4), xaxs = "i", yaxs = "i", xlab = "Days after planting",
     ylab = expression(paste("Crop coefficient, ", K[c])), main = "Crop coefficient curve, sweet corn (Idaho, USA)")
for (i in 1:4) { rect(st$a[i], 0, st$b[i], 1.4, col = st$col[i], border = NA); text((st$a[i] + st$b[i]) / 2, 1.3, st$name[i]) }
lines(days, kc, lwd = 3, col = "#1b4f72"); points(days, kc, pch = 19, col = "#1b4f72")
dev.off()
