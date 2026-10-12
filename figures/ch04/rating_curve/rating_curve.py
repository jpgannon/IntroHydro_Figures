"""Stage–discharge rating curve with 95% interval
Chapter 4 draft; data supplied by the chapter author (figs/fig8_measurements_with_fit.csv, fig8_rating_fit.csv)
Run: python3 rating_curve.py  ->  figure_python.png"""
import numpy as np
import pandas as pd
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

a = pd.read_csv("fig8_measurements_with_fit.csv")

b = pd.read_csv("fig8_rating_fit.csv")

fig, axes = plt.subplots(1, 1, figsize=(7, 5), squeeze=False)
axes = axes[:, 0]
ax = axes[0]
ax.fill_between(b["gage_height_ft"], b["Q_lower_95_cfs"], b["Q_upper_95_cfs"], color="#9ec5e8", alpha=0.6, lw=0, label="95% interval")
ax.plot(b["gage_height_ft"], b["Q_fit_cfs"], color="#1f4e79", lw=1.6, ls="-", label="Fitted rating")
ax.scatter(a["gage_height_ft"], a["discharge_cfs"], s=14, color="#e8743b", label="Measurements", zorder=3)
ax.set_yscale("log")
ax.set_xlabel("Gage height (ft)")
ax.set_ylabel("Discharge (cfs)")
ax.legend(frameon=False, loc="lower right", fontsize=8)
ax.grid(alpha=0.25)
for s in ("top", "right"): ax.spines[s].set_visible(False)

fig.tight_layout()
fig.savefig("figure_python.png", dpi=150)
