"""Velocity–area (mid-section) discharge measurement
Chapter 4 draft; data supplied by the chapter author (figs/fig7_midsection.csv)
Run: python3 midsection_gauging.py  ->  figure_python.png"""
import numpy as np
import pandas as pd
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

a = pd.read_csv("fig7_midsection.csv")
a["negd"] = -a["depth_ft"]

fig, axes = plt.subplots(2, 1, figsize=(8, 6.5), squeeze=False, gridspec_kw={"height_ratios": [1, 1]})
axes = axes[:, 0]
ax = axes[0]
ax.fill_between(a["distance_ft"], 0, a["negd"], color="#7fb3d5", alpha=0.8, lw=0, label="Water depth")
ax.set_xlabel("Distance from left edge of water (ft)")
ax.set_ylabel("Depth (ft, below water surface)")
ax.legend(frameon=False, loc="lower right", fontsize=8)
ax.grid(alpha=0.25)
for s in ("top", "right"): ax.spines[s].set_visible(False)

ax = axes[1]
ax.bar(a["distance_ft"], a["discharge_ft3_per_s"], width=3.0, color="#e8743b", edgecolor="none")
ax.set_xlabel("Distance from left edge of water (ft)")
ax.set_ylabel("Station discharge (ft³/s)")
ax.grid(alpha=0.25)
for s in ("top", "right"): ax.spines[s].set_visible(False)

fig.tight_layout()
fig.savefig("figure_python.png", dpi=150)
