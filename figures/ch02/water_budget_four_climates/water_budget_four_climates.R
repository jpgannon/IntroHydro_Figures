# Monthly P, ET, Q and change in storage in four climates (Figure 2.7)
# Chapter 2 draft; author data arrays from the code comment (truncated at Word's 2048-character comment limit); plotting completed from the figure in the draft
# Run: Rscript water_budget_four_climates.R -> figure_r.png (base R, no packages)
months <- strsplit("JFMAMJJASOND", "")[[1]]; mfull <- month.abb
climates <- list(
  list(name = "Temperate (NH)", place = "Hubbard Brook, NH", P = c(95,88,100,105,118,112,116,116,84,120,124,108), ET = c(5,8,22,48,84,108,120,104,78,34,12,5), Q = c(0.95,0.85,1.05,2.3,1.35,0.85,0.5,0.35,0.3,0.55,0.85,0.95), note = "snowmelt-fed spring Q, summer ET drawdown; lowest storage early autumn"),
  list(name = "Monsoon (NH)", place = "Peninsular India", P = c(10,12,14,22,40,150,300,290,180,70,20,8), ET = c(35,45,70,95,110,120,115,110,95,70,50,40), Q = c(0.55,0.35,0.25,0.2,0.2,0.9,2.6,2.7,1.8,1.0,0.75,0.65), note = "dry season empties storage; trough just before monsoon onset"),
  list(name = "Temperate (SH)", place = "S. Chile / Tasmania", P = c(55,50,70,95,150,175,180,150,120,90,70,55), ET = c(110,100,78,50,26,14,12,20,40,66,90,105), Q = c(0.75,0.6,0.75,1.0,1.6,2.2,2.3,1.9,1.4,1.0,0.85,0.75), note = "seasons flipped from NH; trough in austral autumn"),
  list(name = "Savanna (SH)", place = "N. Australia (Top End)", P = c(280,270,210,60,20,8,5,6,18,70,150,240), ET = c(130,125,120,95,78,66,62,66,82,100,115,128), Q = c(2.6,2.7,2.4,1.3,0.7,0.45,0.35,0.3,0.3,0.45,0.9,1.7), note = "long dry season; trough at end of 'the Dry'"))
png("figure_r.png", width = 1875, height = 1290, res = 150)
par(mfrow = c(2, 2), mar = c(3.2, 4.6, 3.6, 4.6), las = 1, oma = c(2, 0, 0, 0))
for (cl in climates) {
  P <- cl$P; ET <- cl$ET; Q <- cl$Q * ((sum(P) - sum(ET)) / sum(cl$Q))
  cs <- cumsum(P - ET - Q); S <- cs - min(cs); trough <- which.min(cs); wy <- trough %% 12 + 1     # water year starts month after trough
  ytop <- max(P, ET, Q) * 1.08
  bp <- barplot(P, col = adjustcolor("#78A9D6", 0.55), border = NA, names.arg = months, ylim = c(0, ytop), ylab = "flux  (mm/month)", space = 0.28)
  lines(bp, ET, type = "o", col = "#D55E00", lwd = 2, pch = 19, cex = 0.7); lines(bp, Q, type = "o", col = "#0072B2", lwd = 2, pch = 15, cex = 0.7)
  abline(v = (bp[wy] + bp[(wy + 10) %% 12 + 1]) / 2 + ifelse(wy == 1, 6.5, 0) * 0, lty = 2, lwd = 1.6)
  text(bp[wy] - 0.4, ytop * 0.97, sprintf("water year\nstarts %s 1", mfull[wy]), adj = c(0, 1), font = 2, cex = 0.75)
  text(bp[1] - 0.4, ytop * 0.04, cl$note, adj = c(0, 0), font = 3, cex = 0.6, col = "grey30")
  mtext(sprintf("%s, %s   (P %.0f . ET %.0f . Q %.0f mm/yr, RC %.0f%%)", cl$name, cl$place, sum(P), sum(ET), sum(Q), 100 * sum(Q) / sum(P)), side = 3, adj = 0, line = 0.6, cex = 0.7)
  par(new = TRUE); plot(bp, S, type = "n", axes = FALSE, xlab = "", ylab = "", ylim = c(-0.05 * max(S), max(S) * 1.25), xlim = range(bp) + c(-0.7, 0.7))
  polygon(c(bp, rev(bp)), c(S, rep(0, 12)), col = adjustcolor("#009E73", 0.15), border = NA); lines(bp, S, lty = 2, lwd = 2, col = "#009E73")
  points(bp[trough], 0, pch = 25, bg = "#009E73", cex = 1.6); axis(4, col.axis = "#009E73", col = "#009E73"); mtext("change in storage (mm)", side = 4, line = 3, col = "#009E73", cex = 0.7, las = 0)
}
mtext("Schematic monthly climatologies with a closed annual budget (sum P = sum ET + sum Q). Change in storage = cumulative (P - ET - Q), offset so its trough = 0.", side = 1, outer = TRUE, cex = 0.6, col = "grey30")
invisible(dev.off())
