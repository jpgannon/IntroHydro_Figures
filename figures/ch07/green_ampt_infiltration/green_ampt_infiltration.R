# Green–Ampt infiltration under constant rainfall (silty clay)
# Chapter 7 draft; parameters from the chapter author (Figures_4_5_6_and_Table1_2026_10_02.xlsx, GreenAmpt sheet); explicit time stepping dt = 0.02 h as in the workbook
# Run: Rscript green_ampt_infiltration.R -> figure_r.png (base R, no packages)
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

png("figure_r.png", width = 1125, height = 720, res = 150)
par(mar = c(4.5, 4.5, 1, 1), las = 1)
plot(NA, xlim = c(0, 3), ylim = c(0, 40), xlab = "Time (hr)", ylab = "Rate (mm/hr)", bty = "l"); grid(col = "grey88")
lines(t, pmin(ipot, 60), col = "#2e8b57", lwd = 2, lty = 2); lines(t, iact, col = "#1f4e79", lwd = 2.4)
abline(h = r, col = "#e8743b", lwd = 1.6); abline(h = Ks, col = "grey50", lty = 3)
legend("topright", bty = "n", lwd = c(2, 2.4, 1.6, 1), lty = c(2, 1, 1, 3), col = c("#2e8b57", "#1f4e79", "#e8743b", "grey50"),
       legend = c("Green-Ampt capacity", "Actual infiltration", "Rainfall rate", "Ks"))
invisible(dev.off())
