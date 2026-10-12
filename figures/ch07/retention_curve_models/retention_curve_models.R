# Soil water retention curves: Brooks–Corey, Campbell and van Genuchten (sandy loam and silty clay)
# Chapter 7 draft; parameters from the chapter author (Figures_4_5_6_and_Table1_2026_10_02.xlsx, RetentionCurves sheet; Clapp & Hornberger 1978 / Rawls et al. parameter sets)
# Run: Rscript retention_curve_models.R -> figure_r.png (base R, no packages)
soils <- list("Sandy loam" = c(phi = 0.435, thr = 0.06, psi_ae = 21.8, b_bc = 3.9, b_camp = 4.9, alpha = 0.025, n = 1.3),
              "Silty clay" = c(phi = 0.492, thr = 0.241, psi_ae = 49, b_bc = 4.4, b_camp = 10.4, alpha = 0.01, n = 1.3))
brooks  <- function(th, s) { se <- (th - s["thr"]) / (s["phi"] - s["thr"]); s["psi_ae"] * se^(-s["b_bc"]) }
campbell <- function(th, s) s["psi_ae"] * (th / s["phi"])^(-s["b_camp"])
vang <- function(th, s) { se <- (th - s["thr"]) / (s["phi"] - s["thr"]); m <- 1 - 1 / s["n"]; (se^(-1 / m) - 1)^(1 / s["n"]) / s["alpha"] }
png("figure_r.png", width = 1500, height = 690, res = 150)
par(mfrow = c(1, 2), mar = c(4.5, 4.8, 2, 1), las = 1)
for (nm in names(soils)) {
  s <- soils[[nm]]; th <- seq(s["thr"] + 0.01, s["phi"] - 0.002, length.out = 400)
  plot(NA, xlim = range(th), ylim = c(1, 1e7), log = "y", xlab = "Volumetric water content, θ (m³/m³)",
       ylab = if (nm == "Sandy loam") "Matric potential magnitude, |ψ| (cm)" else "", bty = "l", yaxt = "n")
  axis(2, at = 10^(0:7), labels = c("1", "10", "100", "1e3", "1e4", "1e5", "1e6", "1e7")); grid(col = "grey88")
  abline(h = c(340, 15300), lty = 3, col = "grey50")
  lines(th, brooks(th, s), col = "#1f4e79", lwd = 2); lines(th, campbell(th, s), col = "#e8743b", lwd = 2, lty = 2)
  lines(th, vang(th, s), col = "#2e8b57", lwd = 2, lty = 3)
  mtext(nm, side = 3, adj = 0, font = 2, cex = 0.8, line = 0.5)
  if (nm == "Sandy loam") legend("topright", bty = "n", legend = c("Brooks–Corey", "Campbell", "van Genuchten"), col = c("#1f4e79", "#e8743b", "#2e8b57"), lty = 1:3, lwd = 2)
}
invisible(dev.off())
