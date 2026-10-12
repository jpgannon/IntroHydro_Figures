"""Conductivity ratio vs slope for different hillslope length-to-depth ratios
Chapter 4 draft; data supplied by the chapter author (figs/fig11.csv)
Run: python3 hydraulic_conductivity_ratio.py  ->  figure_python.png"""
import numpy as np
import pandas as pd
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

a = pd.read_csv("fig11.csv")

fig, axes = plt.subplots(1, 1, figsize=(7, 5), squeeze=False)
axes = axes[:, 0]
ax = axes[0]
ax.plot(a["slope"], a["Kratio_LD_10m"], color="#08306b", lw=1.6, ls="-", label="10 m")
ax.plot(a["slope"], a["Kratio_LD_20m"], color="#08519c", lw=1.6, ls="-", label="20 m")
ax.plot(a["slope"], a["Kratio_LD_30m"], color="#2171b5", lw=1.6, ls="-", label="30 m")
ax.plot(a["slope"], a["Kratio_LD_40m"], color="#4292c6", lw=1.6, ls="-", label="40 m")
ax.plot(a["slope"], a["Kratio_LD_50m"], color="#6baed6", lw=1.6, ls="-", label="50 m")
ax.plot(a["slope"], a["Kratio_LD_100m"], color="#9ecae1", lw=1.6, ls="-", label="100 m")
ax.plot(a["slope"], a["Kratio_LD_200m"], color="#c6dbef", lw=1.6, ls="-", label="200 m")
ax.set_xscale("log")
ax.set_yscale("log")
ax.set_xlabel("Slope (m/m)")
ax.set_ylabel("K ratio")
ax.legend(frameon=False, loc="upper right", fontsize=8)
ax.grid(alpha=0.25)
for s in ("top", "right"): ax.spines[s].set_visible(False)

fig.tight_layout()
fig.savefig("figure_python.png", dpi=150)
