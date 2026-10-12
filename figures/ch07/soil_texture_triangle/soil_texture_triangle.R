# USDA soil texture triangle
# Chapter 7 draft (Figure "Texture"); classes computed from the standard USDA texture-class rules (sand, silt, clay in % by weight)
# Run: Rscript soil_texture_triangle.R -> figure_r.png (base R, no packages)
nm <- c("Sand", "Loamy sand", "Sandy loam", "Loam", "Silt loam", "Silt", "Sandy clay loam", "Clay loam", "Silty clay loam", "Sandy clay", "Silty clay", "Clay")
classify <- function(sand, silt, clay) {   # USDA texture class index (1-12) from percent sand, silt, clay
  cl <- rep(NA_integer_, length(sand))
  rules <- list(
    silt + 1.5 * clay < 15,
    silt + 1.5 * clay >= 15 & silt + 2 * clay < 30,
    (clay >= 7 & clay < 20 & sand > 52 & silt + 2 * clay >= 30) | (clay < 7 & silt < 50 & silt + 2 * clay >= 30),
    clay >= 7 & clay < 27 & silt >= 28 & silt < 50 & sand <= 52,
    (silt >= 50 & clay >= 12 & clay < 27) | (silt >= 50 & silt < 80 & clay < 12),
    silt >= 80 & clay < 12,
    clay >= 20 & clay < 35 & silt < 28 & sand > 45,
    clay >= 27 & clay < 40 & sand > 20 & sand <= 45,
    clay >= 27 & clay < 40 & sand <= 20,
    clay >= 35 & sand > 45,
    clay >= 40 & silt >= 40,
    clay >= 40 & sand <= 45 & silt < 40)
  for (k in seq_along(rules)) cl[is.na(cl) & rules[[k]]] <- k
  cl
}
H <- sqrt(3) / 2
gx <- seq(0, 1, length.out = 600); gy <- seq(0, H, length.out = 520)
g <- expand.grid(x = gx, y = gy)
clay <- 100 * g$y / H; silt <- 100 * (g$x - 0.5 * clay / 100); sand <- 100 - clay - silt
ins <- clay >= 0 & silt >= 0 & sand >= 0
cls <- rep(NA_integer_, nrow(g)); cls[ins] <- classify(sand[ins], silt[ins], clay[ins])
cols <- c("#8dd3c7", "#ffffb3", "#bebada", "#fb8072", "#80b1d3", "#fdb462", "#b3de69", "#fccde5", "#d9d9d9", "#bc80bd", "#ccebc5", "#ffed6f")
png("figure_r.png", width = 1125, height = 990, res = 150); par(mar = c(0.5, 0.5, 0.5, 0.5))
plot(NA, xlim = c(-0.08, 1.08), ylim = c(-0.12, H + 0.05), asp = 1, axes = FALSE, xlab = "", ylab = "")
image(gx, gy, matrix(cls, nrow = length(gx)), col = cols, breaks = 0.5:12.5, add = TRUE)
lines(c(0, 1, 0.5, 0), c(0, 0, H, 0), lwd = 2)
for (k in 1:12) { mm <- which(cls == k); if (length(mm)) text(mean(g$x[mm]), mean(g$y[mm]), if (nchar(nm[k]) > 9) gsub(" ", "\n", nm[k]) else nm[k], cex = if (k %in% c(1, 2, 6)) 0.5 else 0.6) }
for (v in seq(10, 90, 10)) {
  text(0.5 * v / 100 - 0.035, H * v / 100, v, cex = 0.5); text(1 - v / 100, -0.03, v, cex = 0.5)
  text(1 - 0.5 * (100 - v) / 100 + 0.035, H * (100 - v) / 100, v, cex = 0.5)
}
text(0.2, 0.5 * H + 0.05, "Clay (%)", srt = 60, font = 2, cex = 0.8); text(0.5, -0.08, "Sand (%)", font = 2, cex = 0.8); text(0.8, 0.5 * H + 0.05, "Silt (%)", srt = -60, font = 2, cex = 0.8)
invisible(dev.off())
