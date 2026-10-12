# Green–Ampt vs Horton infiltration capacity
# Chapter 7 draft; parameters from the chapter author (Figures_4_5_6_and_Table1_2026_10_02.xlsx, GreenAmpt sheet)
# Run: Rscript green_ampt_vs_horton.R -> figure_r.png (base R, no packages)
# Silty clay, Campbell parameters (GreenAmpt sheet). Units: mm and hours.
phi <- 0.492; theta_i <- 0.37; Ks <- 3.72; psi_f <- 70; r <- 10
f0 <- 30; fc <- Ks; beta <- 3
dtheta <- phi - theta_i; dt <- 0.02; t <- seq(0, 3, by = dt)
I <- numeric(length(t)); ipot <- numeric(length(t)); iact <- numeric(length(t))
for (k in seq_along(t)) {
  ipot[k] <- if (I[k] > 0) Ks * (1 + psi_f * dtheta / I[k]) else Inf
  iact[k] <- min(r, ipot[k])
  if (k < length(t)) I[k + 1] <- I[k] + iact[k] * dt
}
horton <- fc + (f0 - fc) * exp(-beta * t)

A <- psi_f * dtheta
Fp <- seq(1e-3, 80, length.out = 4000); tp <- (Fp - A * log(1 + Fp / A)) / Ks; fg <- Ks * (1 + A / Fp)
png("figure_r.png", width = 1125, height = 720, res = 150)
par(mar = c(4.5, 4.5, 1, 1), las = 1)
plot(NA, xlim = c(0, 3), ylim = c(0, 45), xlab = "Time (hr)", ylab = "Infiltration capacity (mm/hr)", bty = "l"); grid(col = "grey88")
lines(tp, fg, col = "#2e8b57", lwd = 2.2); lines(t, horton, col = "#e8743b", lwd = 2.2, lty = 2); abline(h = Ks, col = "grey50", lty = 3)
legend("topright", bty = "n", lwd = 2.2, lty = c(1, 2), col = c("#2e8b57", "#e8743b"), legend = c("Green-Ampt (ponded from t = 0)", "Horton"))
invisible(dev.off())
