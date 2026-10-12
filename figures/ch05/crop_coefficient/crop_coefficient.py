"""Chapter 5 - Crop coefficient curve for sweet corn (Idaho, USA).
Data: 'Fig # - CropCoefficientCurve.xlsx' (days, Kc). The spreadsheet repeats several points (e.g. day 30 and 60 appear
twice); the duplicates are removed here. Stages follow the draft: initial, development, mid-season, late-season.
Reference: FAO Irrigation and Drainage Paper 56 (https://www.fao.org/4/x0490e/x0490e0b.htm)."""
import matplotlib.pyplot as plt

days = [0, 30, 60, 90, 110]
kc = [0.30, 0.30, 1.15, 1.15, 1.05]
stages = [(0, 30, "Initial", "#e8f1d4"), (30, 60, "Development", "#d3e6f5"),
          (60, 90, "Mid-season", "#f7e6c4"), (90, 110, "Late season", "#f3d9d4")]

fig, ax = plt.subplots(figsize=(7, 4.5))
for a, b, name, c in stages:
    ax.axvspan(a, b, color=c, lw=0)
    ax.text((a + b) / 2, 1.3, name, ha="center", fontsize=10)
ax.plot(days, kc, "-o", color="#1b4f72", lw=2.5)
ax.set_xlim(0, 110); ax.set_ylim(0, 1.4)
ax.set_xlabel("Days after planting"); ax.set_ylabel("Crop coefficient, $K_c$")
ax.set_title("Crop coefficient curve, sweet corn (Idaho, USA)")
ax.spines[["top", "right"]].set_visible(False)
fig.tight_layout(); fig.savefig("figure_python.png", dpi=150)
