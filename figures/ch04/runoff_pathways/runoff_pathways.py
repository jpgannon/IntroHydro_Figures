"""Hydrograph by runoff pathway (stacked)
Chapter 4 draft; data supplied by the chapter author (figs/fig3_timeseries.csv)
Run: python3 runoff_pathways.py  ->  figure_python.png"""
import numpy as np
import pandas as pd
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

a = pd.read_csv("fig3_timeseries.csv")
a["c1"] = a["groundwater_m3_per_s"]
a["c2"] = a["groundwater_m3_per_s"] + a["interflow_m3_per_s"]
a["c3"] = a["groundwater_m3_per_s"] + a["interflow_m3_per_s"] + a["overland_flow_m3_per_s"]
a["c4"] = a["groundwater_m3_per_s"] + a["interflow_m3_per_s"] + a["overland_flow_m3_per_s"] + a["channel_precip_m3_per_s"]

fig, axes = plt.subplots(2, 1, figsize=(8, 6), squeeze=False, gridspec_kw={"height_ratios": [1.5, 2.6]})
axes = axes[:, 0]
ax = axes[0]
ax.bar(a["time_d"], a["rainfall_mm_per_h"], width=0.010416666666666666, color="#1f4e79", edgecolor="none")
ax.set_xlim(0, 3)
ax.set_ylim(40, 0)
ax.set_ylabel("Rainfall (mm/h)")
ax.grid(alpha=0.25)
for s in ("top", "right"): ax.spines[s].set_visible(False)
ax.xaxis.set_ticks_position("top") if False else None

ax = axes[1]
ax.fill_between(a["time_d"], a["c3"], a["c4"], color="#7fb3d5", alpha=0.9, lw=0, label="Channel precipitation")
ax.fill_between(a["time_d"], a["c2"], a["c3"], color="#e8743b", alpha=0.9, lw=0, label="Overland flow")
ax.fill_between(a["time_d"], a["c1"], a["c2"], color="#5a9e6f", alpha=0.9, lw=0, label="Interflow")
ax.fill_between(a["time_d"], 0, a["c1"], color="#8c6d46", alpha=0.9, lw=0, label="Groundwater")
ax.set_xlim(0, 3)
ax.set_xlabel("Time (days)")
ax.set_ylabel("Discharge (m³/s)")
ax.legend(frameon=False, loc="upper right", fontsize=8)
ax.grid(alpha=0.25)
for s in ("top", "right"): ax.spines[s].set_visible(False)

fig.tight_layout()
fig.savefig("figure_python.png", dpi=150)
