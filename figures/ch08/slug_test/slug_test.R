# Chapter 8 - Idealized slug-test response (Hvorslev) for a high-K and a low-K well
T37_HIGH <- 3; T37_LOW <- 30      # min, basic time lag
tmin <- -20; tmax <- 120
BLUE <- "#2a78d6"; ORANGE <- "#eb6834"; MUTED <- "#898781"
response <- function(T37) {          # steady, instant rise at t = 0, then H/H0 = exp(-t/T37)
  ta <- seq(0, tmax, length.out = 500)[-1]
  list(t = c(tmin, 0, 0, ta), h = c(0, 0, 1, exp(-ta / T37)))
}
png("figure_r.png", width = 1200, height = 675, res = 150)
par(mar = c(4.5, 4.5, 1, 1), bty = "n")
plot(NA, xlim = c(tmin, tmax), ylim = c(-0.05, 1.2), xlab = "Time relative to slug (min)", ylab = "Head above static level, H/H0", yaxt = "n")
axis(2, at = seq(0, 1, 0.2)); grid(col = "grey90", lty = 1)
abline(v = 0, lty = 2, col = MUTED); segments(0, 0.37, T37_LOW, 0.37, lty = 2, col = MUTED)
for (k in list(list(T37_HIGH, BLUE), list(T37_LOW, ORANGE))) {
  r <- response(k[[1]]); lines(r$t, r$h, col = k[[2]], lwd = 2.5)
  segments(k[[1]], -0.05, k[[1]], 0.37, lty = 2, col = k[[2]]); points(k[[1]], 0.37, pch = 21, bg = k[[2]], col = "white", cex = 1.6)
}
text(0, 1.2, "slug added", font = 2, cex = 0.8, adj = c(0.5, 1))
text(8, 0.14, sprintf("T37 = %d min", T37_HIGH), col = BLUE, font = 2, cex = 0.8, adj = 0)
text(36, 0.52, sprintf("T37 = %d min", T37_LOW), col = ORANGE, font = 2, cex = 0.8, adj = 0)
text(tmin + 1, 0.39, "H/H0 = 0.37", col = MUTED, cex = 0.8, adj = 0); text(tmin + 1, 0.03, "steady", col = MUTED, cex = 0.8, adj = 0)
legend("topright", bty = "n", lwd = 2.5, col = c(BLUE, ORANGE), legend = c("High K well", "Low K well"))
dev.off()
