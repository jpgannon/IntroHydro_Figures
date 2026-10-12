"""Types of stream hydrographs and driving processes (Figure 2.3)
Chapter 2 draft; author code (comment in Chapter 2 docx, truncated at Word's 2048-character comment limit) completed from the figure image in the draft
Run: python3 hydrograph_types.py -> figure_python.png"""
import numpy as np, matplotlib
matplotlib.use("Agg"); import matplotlib.pyplot as plt
LINE, FILL, RAIN = "#1f5f8b", "#cfe3c8", "#bcd9ef"

def rise_fall(t, t0, tp, peak, rec, base):
    """Smooth (cubic) rise to the peak at tp, exponential recession afterwards."""
    q = np.full_like(t, base, dtype=float)
    up = (t >= t0) & (t < tp); s = (t[up] - t0) / (tp - t0)
    q[up] = base + peak * (3 * s**2 - 2 * s**3)
    dn = t >= tp; q[dn] = base + peak * np.exp(-(t[dn] - tp) / rec)
    return q

curves = []
t = np.linspace(0, 6, 1500);   curves.append((t, rise_fall(t, 0.75, 1.0, 0.78, 0.22, 0.12)))                       # A flashy
t = np.linspace(0, 10, 1500);  curves.append((t, rise_fall(t, 1.0, 2.7, 0.30, 3.0, 0.12)))                          # B non-flashy
t = np.linspace(0.5, 6.5, 1500); curves.append((t, rise_fall(t, 0.8, 2.0, 0.90, 1.1, 0.03)))                        # C snowmelt (months)
t = np.linspace(0, 6, 3000)                                                                                         # D ET signal
q = rise_fall(t, 0.4, 0.85, 0.55, 0.28, 0.18)
q += 0.035 * np.sin(2 * np.pi * (t - 0.45)) * (1 - np.exp(-np.clip(t - 0.85, 0, None) / 0.4)) * (t > 0.85)
curves.append((t, q))
panels = [{"t": "Flashy stream (storm response)", "xl": [0, 6], "xlab": "Time (days)", "ticks": None, "labs": None, "rain": [0.7, 1.0], "ylab": "Flow (e.g., m\u00b3/s)", "ann": [["FLASHY\nPEAK", 1.3, 0.9, 1.02, 0.9], ["RAPID\nRISE", 0.45, 0.5, 0.85, 0.55], ["QUICK\nRECESSION", 2.0, 0.5, 1.45, 0.3]]}, {"t": "Non-flashy stream (storm response)", "xl": [0, 10], "xlab": "Time (days)", "ticks": None, "labs": None, "rain": [1.0, 1.8], "ylab": "Flow", "ann": [["MODERATE\nRISE", 1.6, 0.9, 2.0, 0.28], ["SLOW\nRECESSION", 7.6, 0.62, 6.2, 0.2]]}, {"t": "Snowmelt-dominated stream", "xl": [0.5, 6.5], "xlab": "Time (months, April\u2013September)", "ticks": [1, 2, 3, 4, 5, 6], "labs": ["Apr", "May", "Jun", "Jul", "Aug", "Sep"], "rain": None, "ylab": "Flow", "ann": [["SNOWMELT\nPEAK", 3.2, 0.95, 2.1, 0.9], ["SLOW, MULTI-MONTH\nRECESSION", 5.0, 0.55, 4.0, 0.2]]}, {"t": "Evapotranspiration signal on baseflow", "xl": [0, 6], "xlab": "Time (days)", "ticks": None, "labs": None, "rain": [0.4, 0.7], "ylab": "Flow", "ann": [["NIGHTTIME\nMAX", 2.5, 0.95, 1.7, 0.4], ["AFTERNOON\nMIN", 3.4, 0.12, 2.2, 0.2], ["DIURNAL\nET CYCLE", 4.6, 0.95, 3.7, 0.36]]}]
fig, axs = plt.subplots(2, 2, figsize=(11, 6.4)); fig.suptitle("Types of stream hydrographs and driving processes", fontsize=13, fontweight="bold")
for ax, p, (t, q), lab in zip(axs.flat, panels, curves, "ABCD"):
    if p["rain"]: ax.axvspan(*p["rain"], ymin=0, ymax=0.93, color=RAIN, alpha=0.8, lw=0)
    ax.fill_between(t, 0, q, color=FILL, alpha=0.8, lw=0); ax.plot(t, q, color=LINE, lw=2)
    ax.set_xlim(*p["xl"]); ax.set_ylim(0, 1.05); ax.set_yticks([])
    if p["ticks"]: ax.set_xticks(p["ticks"]); ax.set_xticklabels(p["labs"])
    ax.set_xlabel(p["xlab"].upper(), fontweight="bold", fontsize=8); ax.set_ylabel(p["ylab"].upper(), fontweight="bold", fontsize=8)
    ax.set_title(f"{lab}  {p['t']}", loc="left", fontweight="bold", fontsize=10)
    for txt, tx, ty, ax_, ay_ in p["ann"]:
        ax.annotate(txt, xy=(ax_, ay_), xytext=(tx, ty), fontsize=7.5, fontweight="bold", ha="center", va="center", arrowprops=dict(arrowstyle="->"))
    for s in ("top", "right"): ax.spines[s].set_visible(False)
fig.tight_layout(rect=(0, 0, 1, 0.96)); fig.savefig("figure_python.png", dpi=150)
