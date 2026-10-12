"""Figure 3.9: Hyetographs for a frontal storm (March) and a convective storm (June)
Chapter 3 draft; data supplied by chapter author (Figure_3_9_Timeseries.xlsx; Hubbard Brook rain gage, 15-min)
Run: python3 hyetographs_frontal_convective.py  ->  figure_python.png"""
import numpy as np
import pandas as pd
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

a = pd.read_csv("hyetograph_frontal_march.csv")
a["datetime"] = pd.to_datetime(a["datetime"], format="%Y-%m-%d %H:%M:%S")

b = pd.read_csv("hyetograph_convective_june.csv")
b["datetime"] = pd.to_datetime(b["datetime"], format="%Y-%m-%d %H:%M:%S")

fig, axes = plt.subplots(2, 1, figsize=(8, 6), squeeze=False)
axes = axes[:, 0]
ax = axes[0]
ax.bar(a["datetime"], a["precip_mm"], width=0.010416666666666666, color="#1f4e79", edgecolor="none")
import matplotlib.dates as mdates
ax.xaxis.set_major_formatter(mdates.DateFormatter("%H:%M"))
ax.set_ylim(1.0, 0)
ax.set_xlabel("Time of day")
ax.set_ylabel("Precipitation (mm per 15 min)")
ax.set_title("(a) Frontal storm, 31 March 2025", loc="left", fontsize=10)
ax.grid(alpha=0.25)
for s in ("top", "right"): ax.spines[s].set_visible(False)
ax.xaxis.set_ticks_position("top") if False else None

ax = axes[1]
ax.bar(b["datetime"], b["precip_mm"], width=0.010416666666666666, color="#1f4e79", edgecolor="none")
import matplotlib.dates as mdates
ax.xaxis.set_major_formatter(mdates.DateFormatter("%H:%M"))
ax.set_ylim(6, 0)
ax.set_xlabel("Time of day")
ax.set_ylabel("Precipitation (mm per 15 min)")
ax.set_title("(b) Convective storm, 6 June 2025", loc="left", fontsize=10)
ax.grid(alpha=0.25)
for s in ("top", "right"): ax.spines[s].set_visible(False)
ax.xaxis.set_ticks_position("top") if False else None

fig.tight_layout()
fig.savefig("figure_python.png", dpi=150)
