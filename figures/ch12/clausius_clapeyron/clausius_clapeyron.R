# Chapter 12, Figure X.3 - The Clausius-Clapeyron relationship (saturation vapor pressure vs temperature)
es0 <- 6.11; T0 <- 273.15; L <- 2.501e6; Rv <- 461.5
es  <- function(Tc) es0 * exp((L / Rv) * (1 / T0 - 1 / (Tc + 273.15)))          # hPa
rho <- function(Tc) es(Tc) * 100 / (Rv * (Tc + 273.15)) * 1000                  # g/m3
Tc <- seq(10, 30, length.out = 400)
png("figure_r.png", width = 1140, height = 870, res = 150)
par(mar = c(6, 4.5, 3, 5), family = "serif")
plot(Tc, es(Tc), type = "n", xlim = c(10, 30), ylim = c(10, 48.5), xlab = "Temperature (°C)",
     ylab = "Saturation vapor pressure, es (hPa)", main = "The Clausius–Clapeyron relationship", col.lab = "#1b4f72")
grid(col = "grey90", lty = 1)
lines(Tc, es(Tc), col = "#1b4f72", lwd = 3.5)
Tref <- 15; cols <- c("#1b4f72", "#e67e22", "#c0392b"); dT <- c(0, 2, 4)
for (i in 1:3) { Tp <- Tref + dT[i]; segments(Tp, 0, Tp, es(Tp), lty = 2, col = cols[i]); points(Tp, es(Tp), pch = 19, col = cols[i], cex = 1.3) }
lab <- function(d) sprintf("%+d°C\n%.1f hPa (%.1f g/m³)\n%.0f%% more water vapor", d, es(Tref + d), rho(Tref + d), (es(Tref + d) / es(Tref) - 1) * 100)
text(10.4, es(Tref) + 5, sprintf("15°C\n%.1f hPa\n(%.1f g/m³)", es(Tref), rho(Tref)), col = cols[1], adj = c(0, 0), cex = 0.8)
text(14.4, es(17) + 3, lab(2), col = cols[2], adj = c(0, 0), cex = 0.8)
text(18.4, es(19) + 5, lab(4), col = cols[3], adj = c(0, 0), cex = 0.8)
# right-hand axis: absolute humidity at saturation, placed at the matching vapor-pressure positions
rt <- seq(10, 30, by = 2.5); axis(4, at = approx(rho(Tc), es(Tc), rt)$y, labels = rt, las = 1)
mtext("Water vapor in air at saturation (g per m³)", side = 4, line = 3, col = "#6e4a2f")
mtext("es(T) = es0 exp[ L/Rv (1/T0 - 1/T) ];  rho = es/(Rv T);  es0 = 6.11 hPa, T0 = 273.15 K, L = 2.501e6 J/kg, Rv = 461.5 J/(kg K)", side = 1, line = 4.5, cex = 0.55)
dev.off()
