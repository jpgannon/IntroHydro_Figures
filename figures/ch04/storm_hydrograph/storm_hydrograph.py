"""Storm hydrograph with rainfall, baseflow and stormflow
Chapter 4 draft; data supplied by the chapter author (figs/fig1_timeseries.csv)
Run: python3 storm_hydrograph.py  ->  figure_python.png"""
import numpy as np
import pandas as pd
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

a = pd.read_csv("fig1_timeseries.csv")

fig, axes = plt.subplots(2, 1, figsize=(8, 6), squeeze=False, gridspec_kw={"height_ratios": [1.5, 2.6]})
axes = axes[:, 0]
ax = axes[0]
ax.bar(a["time_d"], a["rainfall_mm_per_h"], width=0.010416666666666666, color="#1f4e79", edgecolor="none")
ax.set_xlim(0, 2.5)
ax.set_ylim(40, 0)
ax.set_ylabel("Rainfall (mm/h)")
ax.grid(alpha=0.25)
for s in ("top", "right"): ax.spines[s].set_visible(False)
ax.xaxis.set_ticks_position("top") if False else None

ax = axes[1]
ax.plot(a["time_d"], a["streamflow_m3_per_s"], color="#222222", lw=2, ls="-", label="Streamflow")
ax.plot(a["time_d"], a["baseflow_m3_per_s"], color="#5a9e6f", lw=1.6, ls="--", label="Baseflow")
ax.plot(a["time_d"], a["stormflow_m3_per_s"], color="#e8743b", lw=1.6, ls="--", label="Stormflow")
ax.set_xlim(0, 2.5)
ax.set_xlabel("Time (days)")
ax.set_ylabel("Discharge (m³/s)")
ax.legend(frameon=False, loc="upper right", fontsize=8)
ax.grid(alpha=0.25)
for s in ("top", "right"): ax.spines[s].set_visible(False)

fig.tight_layout()
fig.savefig("figure_python.png", dpi=150)
