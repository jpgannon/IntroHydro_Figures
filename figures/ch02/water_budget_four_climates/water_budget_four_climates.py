"""Monthly P, ET, Q and change in storage in four climates (Figure 2.7)
Chapter 2 draft; author data arrays from the code comment (truncated at Word's 2048-character comment limit); plotting completed from the figure in the draft
Run: python3 water_budget_four_climates.py -> figure_python.png"""
import numpy as np, matplotlib
matplotlib.use("Agg"); import matplotlib.pyplot as plt

months = list("JFMAMJJASOND")
climates = [
 ("Temperate (NH)", "Hubbard Brook, NH", [95,88,100,105,118,112,116,116,84,120,124,108], [5,8,22,48,84,108,120,104,78,34,12,5],
  [0.95,0.85,1.05,2.30,1.35,0.85,0.5,0.35,0.30,0.55,0.85,0.95], "snowmelt-fed spring Q, summer ET drawdown; lowest storage early autumn"),
 ("Monsoon (NH)", "Peninsular India", [10,12,14,22,40,150,300,290,180,70,20,8], [35,45,70,95,110,120,115,110,95,70,50,40],
  [0.55,0.35,0.25,0.2,0.2,0.9,2.6,2.7,1.8,1.0,0.75,0.65], "dry season empties storage; trough just before monsoon onset"),
 ("Temperate (SH)", "S. Chile / Tasmania", [55,50,70,95,150,175,180,150,120,90,70,55], [110,100,78,50,26,14,12,20,40,66,90,105],
  [0.75,0.6,0.75,1.0,1.6,2.2,2.3,1.9,1.4,1.0,0.85,0.75], "seasons flipped from NH; trough in austral autumn"),
 ("Savanna (SH)", "N. Australia (Top End)", [280,270,210,60,20,8,5,6,18,70,150,240], [130,125,120,95,78,66,62,66,82,100,115,128],
  [2.6,2.7,2.4,1.3,0.7,0.45,0.35,0.3,0.3,0.45,0.9,1.7], "long dry season; trough at end of 'the Dry'"),
]

mfull = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
C_P, C_ET, C_Q, C_S = "#78A9D6", "#D55E00", "#0072B2", "#009E73"
x = np.arange(12)
fig, axes = plt.subplots(2, 2, figsize=(12.5, 8.6))
for ax, (name, place, P, ET, Qs, note) in zip(axes.flat, climates):
    P, ET, Qs = map(lambda v: np.array(v, float), (P, ET, Qs))
    Q = Qs * ((P.sum() - ET.sum()) / Qs.sum())          # scale Q so the annual budget closes (sum P = sum ET + sum Q)
    cs = np.cumsum(P - ET - Q); S = cs - cs.min()        # change in storage, offset so its trough = 0
    trough = int(np.argmin(cs)); wy = (trough + 1) % 12  # water year starts the month after the storage trough
    ax.bar(x, P, width=0.72, color=C_P, alpha=0.55, label="P", zorder=1)
    ax.plot(x, ET, "-o", color=C_ET, lw=2, ms=3.5, label="ET", zorder=3)
    ax.plot(x, Q, "-s", color=C_Q, lw=2, ms=3.5, label="Q", zorder=3)
    ax.set_xticks(x); ax.set_xticklabels(months); ax.set_ylabel("flux  (mm month$^{-1}$)")
    ax2 = ax.twinx(); ax2.fill_between(x, 0, S, color=C_S, alpha=0.15, lw=0); ax2.plot(x, S, "--", color=C_S, lw=2, label="S")
    ax2.plot(trough, 0, "v", color=C_S, mec="k", ms=10); ax2.set_ylabel("change in storage (mm)", color=C_S); ax2.set_ylim(-0.05 * S.max(), S.max() * 1.25)
    ax.axvline(wy - 0.5, color="k", ls="--", lw=1.6)
    ax.text(wy - 0.4, ax.get_ylim()[1] * 0.97, f"water year\nstarts {mfull[wy]} 1", va="top", fontsize=9, fontweight="bold", bbox=dict(boxstyle="round", fc="w"))
    ax.text(-0.4, ax.get_ylim()[1] * 0.04, note, fontsize=7.5, style="italic", color="0.3")
    ax.set_title(f"{name}\n{place}   (P {P.sum():.0f} · ET {ET.sum():.0f} · Q {Q.sum():.0f} mm/yr, RC {100 * Q.sum() / P.sum():.0f}%)", loc="left", fontsize=9.5)
fig.text(0.5, 0.012, "Schematic monthly climatologies with a closed annual budget (ΣP = ΣET + ΣQ). Change in storage = cumulative (P − ET − Q), offset so its trough = 0.\nBars: P; orange: ET; blue: Q; green dashed: S; vertical dashed line: water-year start (storage trough).", ha="center", fontsize=8.5, color="0.3")
fig.tight_layout(rect=(0, 0.05, 1, 1)); fig.savefig("figure_python.png", dpi=150)
