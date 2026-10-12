"""Baseflow separation: fixed-interval vs digital filter
Chapter 4 draft; data supplied by the chapter author (figs/fig9.csv)
Run: python3 baseflow_separation.py  ->  figure_python.png"""
import numpy as np
import pandas as pd
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

a = pd.read_csv("fig9.csv")
a["date"] = pd.to_datetime(a["date"], format="%d-%b-%Y")

fig, axes = plt.subplots(1, 1, figsize=(8, 4.5), squeeze=False)
axes = axes[:, 0]
ax = axes[0]
ax.plot(a["date"], a["streamflow_cfs"], color="#222222", lw=1.6, ls="-", label="Streamflow")
ax.plot(a["date"], a["baseflow_fixed_interval_cfs"], color="#e8743b", lw=1.6, ls="-", label="Baseflow (fixed interval)")
ax.plot(a["date"], a["baseflow_digital_filter_cfs"], color="#1f4e79", lw=1.6, ls="-", label="Baseflow (digital filter)")
ax.set_ylabel("Discharge (cfs)")
ax.legend(frameon=False, loc="upper right", fontsize=8)
ax.grid(alpha=0.25)
for s in ("top", "right"): ax.spines[s].set_visible(False)

fig.tight_layout()
fig.savefig("figure_python.png", dpi=150)
