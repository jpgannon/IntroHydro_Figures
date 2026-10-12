"""Latent heat flux (LE) from an eddy-covariance flux tower, one week in summer
Chapter 5 draft; data: Desai (2026), AmeriFlux FLUXNET-1F US-WCr Willow Creek v1.3_r1, doi:10.17190/AMF/3028955 (CC-BY-4.0)
Run: python3 flux_tower_latent_heat.py  ->  figure_python.png"""
import numpy as np
import pandas as pd
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

a = pd.read_csv("flux_tower_LE.csv")
a["TIMESTAMP_START"] = pd.to_datetime(a["TIMESTAMP_START"], format="%Y-%m-%d %H:%M:%S")
a["lo"] = a["LE_CORR_Wm2"] - a["LE_RANDUNC_Wm2"]
a["hi"] = a["LE_CORR_Wm2"] + a["LE_RANDUNC_Wm2"]

fig, axes = plt.subplots(1, 1, figsize=(9, 4.5), squeeze=False)
axes = axes[:, 0]
ax = axes[0]
ax.fill_between(a["TIMESTAMP_START"], a["lo"], a["hi"], color="#9ec5e8", alpha=0.6, lw=0, label="± random uncertainty")
ax.plot(a["TIMESTAMP_START"], a["LE_CORR_Wm2"], color="#1f4e79", lw=1, ls="-", label="LE (corrected)")
import matplotlib.dates as mdates
ax.xaxis.set_major_formatter(mdates.DateFormatter("%d %b"))
ax.set_ylabel("Latent heat flux, LE (W/m²)")
ax.legend(frameon=False, loc="upper right", fontsize=8)
ax.grid(alpha=0.25)
for s in ("top", "right"): ax.spines[s].set_visible(False)

fig.tight_layout()
fig.savefig("figure_python.png", dpi=150)
