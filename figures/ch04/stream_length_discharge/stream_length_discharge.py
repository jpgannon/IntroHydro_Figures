"""Stream length vs discharge (expansion and contraction of the network)
Chapter 4 draft; data supplied by the chapter author (figs/fig12.csv)
Run: python3 stream_length_discharge.py  ->  figure_python.png"""
import numpy as np
import pandas as pd
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

a = pd.read_csv("fig12.csv")

fig, axes = plt.subplots(1, 1, figsize=(7, 5), squeeze=False)
axes = axes[:, 0]
ax = axes[0]
ax.plot(a[a["record_type"] == "fit"]["discharge_mm_per_d"], a[a["record_type"] == "fit"]["stream_length_fit_km"], color="#1f4e79", lw=1.6, ls="-", label="Fit")
ax.scatter(a[a["record_type"] == "observation"]["discharge_mm_per_d"], a[a["record_type"] == "observation"]["stream_length_obs_km"], s=30, color="#e8743b", label="Observed surveys", zorder=3)
ax.set_xscale("log")
ax.set_xlabel("Discharge (mm/day)")
ax.set_ylabel("Flowing stream length (km)")
ax.legend(frameon=False, loc="upper left", fontsize=8)
ax.grid(alpha=0.25)
for s in ("top", "right"): ax.spines[s].set_visible(False)

fig.tight_layout()
fig.savefig("figure_python.png", dpi=150)
