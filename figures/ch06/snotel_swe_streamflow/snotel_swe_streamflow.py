"""SNOTEL snow water equivalent, snow depth and USGS streamflow, WY2011–WY2012
Chapter 6 draft; data supplied by chapter author (snotel1031_usgs06614800_WY2011_WY2012.csv)
Run: python3 snotel_swe_streamflow.py  ->  figure_python.png"""
import numpy as np
import pandas as pd
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

a = pd.read_csv("snotel1031_usgs06614800_WY2011_WY2012.csv")
a["date"] = pd.to_datetime(a["date"], format="%Y-%m-%d")

fig, axes = plt.subplots(2, 1, figsize=(8, 6), squeeze=False, gridspec_kw={"height_ratios": [1, 1]})
axes = axes[:, 0]
ax = axes[0]
ax.plot(a["date"], a["swe_mm"], color="#1f4e79", lw=1.6, ls="-", label="SWE (mm)")
ax.plot(a["date"], a["depth_mm"], color="#777777", lw=1, ls="-", label="Snow depth (mm)")
ax.set_ylabel("Snow (mm)")
ax.legend(frameon=False, loc="upper right", fontsize=8)
ax.grid(alpha=0.25)
for s in ("top", "right"): ax.spines[s].set_visible(False)

ax = axes[1]
ax.plot(a["date"], a["flow_cfs"], color="#e8743b", lw=1.6, ls="-")
ax.set_ylabel("Streamflow (cfs)")
ax.grid(alpha=0.25)
for s in ("top", "right"): ax.spines[s].set_visible(False)

fig.tight_layout()
fig.savefig("figure_python.png", dpi=150)
