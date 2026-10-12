"""Daily snowmelt vs air temperature, Bogus Basin, April 2023 (degree-day regression)
Chapter 6 draft; data supplied by chapter author (bogus_basin_april2023_temp_melt.csv)
Run: python3 temperature_melt_regression.py -> figure_python.png"""
import numpy as np, pandas as pd, matplotlib
matplotlib.use("Agg"); import matplotlib.pyplot as plt
d = pd.read_csv("bogus_basin_april2023_temp_melt.csv")
slope, icpt = np.polyfit(d.temp_c, d.melt_mm, 1)
r2 = np.corrcoef(d.temp_c, d.melt_mm)[0, 1] ** 2
xs = np.linspace(d.temp_c.min(), d.temp_c.max(), 50)
fig, ax = plt.subplots(figsize=(7, 5))
ax.scatter(d.temp_c, d.melt_mm, color="#1f4e79", s=28, label="Daily observations")
ax.plot(xs, icpt + slope * xs, color="#e8743b", lw=2, label=f"Fit: melt = {slope:.2f} T {icpt:+.2f}  (R² = {r2:.2f})")
ax.set_xlabel("Mean daily air temperature (°C)"); ax.set_ylabel("Daily snowmelt (mm)")
ax.legend(frameon=False); ax.grid(alpha=0.25)
for s in ("top", "right"): ax.spines[s].set_visible(False)
fig.tight_layout(); fig.savefig("figure_python.png", dpi=150)
