# Chapters 1 and 5 - The Budyko curve (conceptual): ET/P vs PET/P (Budyko 1974) with energy and water limits
x <- seq(0.01, 5, length.out = 500)
budyko <- sqrt(x * tanh(1 / x) * (1 - exp(-x)))
png("figure_r.png", width = 1050, height = 750, res = 150)
par(mar = c(4.5, 4.5, 1, 1), bty = "l")
plot(x, pmin(x, 1), type = "l", lwd = 2, xlim = c(0, 5), ylim = c(0, 1.1),
     xlab = "Aridity index, PET / P", ylab = "Evaporative index, ET / P")
lines(x, budyko, col = "#1b4f72", lwd = 4)
abline(v = 1, lty = 3, col = "grey50")
text(0.5, 0.12, "energy-limited\n(humid)"); text(3, 0.62, "water-limited\n(arid)")
legend("bottomright", bty = "n", lwd = c(2, 4), col = c("black", "#1b4f72"),
       legend = c("Energy limit (ET = PET) and water limit (ET = P)", "Budyko curve"))
dev.off()
