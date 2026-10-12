# Types of stream hydrographs and driving processes (Figure 2.3)
# Chapter 2 draft; author code (comment in Chapter 2 docx, truncated at Word's 2048-character comment limit) completed from the figure image in the draft
# Run: Rscript hydrograph_types.R -> figure_r.png (base R, no packages)
rise_fall <- function(t, t0, tp, peak, rec, base) {
  q <- rep(base, length(t))
  up <- t >= t0 & t < tp; s <- (t[up] - t0) / (tp - t0); q[up] <- base + peak * (3 * s^2 - 2 * s^3)
  dn <- t >= tp; q[dn] <- base + peak * exp(-(t[dn] - tp) / rec); q
}
t1 <- seq(0, 6, length.out = 1500);   q1 <- rise_fall(t1, 0.75, 1.0, 0.78, 0.22, 0.12)
t2 <- seq(0, 10, length.out = 1500);  q2 <- rise_fall(t2, 1.0, 2.7, 0.30, 3.0, 0.12)
t3 <- seq(0.5, 6.5, length.out = 1500); q3 <- rise_fall(t3, 0.8, 2.0, 0.90, 1.1, 0.03)
t4 <- seq(0, 6, length.out = 3000);   q4 <- rise_fall(t4, 0.4, 0.85, 0.55, 0.28, 0.18)
q4 <- q4 + 0.035 * sin(2 * pi * (t4 - 0.45)) * (1 - exp(-pmax(t4 - 0.85, 0) / 0.4)) * (t4 > 0.85)

png("figure_r.png", width = 1650, height = 960, res = 150)
par(mfrow = c(2, 2), mar = c(4, 2.5, 2.2, 1), oma = c(0, 0, 2, 0))
panel <- function(t, q, title, xlim, xlab, ylab, rain, ticks, labs, ann) {
  plot(NA, xlim = xlim, ylim = c(0, 1.05), xaxt = "n", yaxt = "n", xlab = toupper(xlab), ylab = toupper(ylab), bty = "l", font.lab = 2, cex.lab = 0.8)
  if (!is.null(rain)) rect(rain[1], 0, rain[2], 0.98, col = "#bcd9ef", border = NA)
  polygon(c(t, rev(t)), c(q, rep(0, length(q))), col = "#cfe3c8", border = NA); lines(t, q, col = "#1f5f8b", lwd = 2.5)
  if (is.null(ticks)) axis(1) else axis(1, at = ticks, labels = labs)
  mtext(title, side = 3, adj = 0, font = 2, cex = 0.75, line = 0.5)
  for (a in ann) { text(a[[2]], a[[3]], a[[1]], font = 2, cex = 0.65); arrows(a[[2]], a[[3]] - 0.07, a[[4]], a[[5]], length = 0.07) }
}
panel(t1, q1, "A  Flashy stream (storm response)", c(0, 6), "Time (days)", "Flow (e.g., m³/s)", c(0.7, 1.0), NULL, NULL, list(list("FLASHY\nPEAK", 1.3, 0.9, 1.02, 0.9), list("RAPID\nRISE", 0.45, 0.5, 0.85, 0.55), list("QUICK\nRECESSION", 2.0, 0.5, 1.45, 0.3)))
panel(t2, q2, "B  Non-flashy stream (storm response)", c(0, 10), "Time (days)", "Flow", c(1.0, 1.8), NULL, NULL, list(list("MODERATE\nRISE", 1.6, 0.9, 2.0, 0.28), list("SLOW\nRECESSION", 7.6, 0.62, 6.2, 0.2)))
panel(t3, q3, "C  Snowmelt-dominated stream", c(0.5, 6.5), "Time (months, April–September)", "Flow", NULL, c(1,2,3,4,5,6), c("Apr","May","Jun","Jul","Aug","Sep"), list(list("SNOWMELT\nPEAK", 3.2, 0.95, 2.1, 0.9), list("SLOW, MULTI-MONTH\nRECESSION", 5.0, 0.55, 4.0, 0.2)))
panel(t4, q4, "D  Evapotranspiration signal on baseflow", c(0, 6), "Time (days)", "Flow", c(0.4, 0.7), NULL, NULL, list(list("NIGHTTIME\nMAX", 2.5, 0.95, 1.7, 0.4), list("AFTERNOON\nMIN", 3.4, 0.12, 2.2, 0.2), list("DIURNAL\nET CYCLE", 4.6, 0.95, 3.7, 0.36)))
mtext("Types of stream hydrographs and driving processes", outer = TRUE, font = 2, cex = 1)
invisible(dev.off())
