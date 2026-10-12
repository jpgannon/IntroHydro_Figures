"""Chapter 8 - Idealized slug-test response (Hvorslev) for a high-K and a low-K well.
Code from a comment in the Groundwater draft (J. Gannon, 'code for this is below (claude)')."""
import numpy as np
import matplotlib.pyplot as plt

# ---- Parameters (edit these) ----
T37_HIGH = 3      # min, basic time lag for high-K well
T37_LOW = 30      # min, basic time lag for low-K well
tmin, tmax = -20, 120   # min relative to slug
BLUE, ORANGE, MUTED = "#2a78d6", "#eb6834", "#898781"

def response(T37, t_after):
    """Idealized Hvorslev response: steady before t=0, instant rise, then H/H0 = exp(-t/T37)."""
    t = np.concatenate(([tmin, 0, 0], t_after))
    h = np.concatenate(([0, 0, 1], np.exp(-t_after / T37)))
    return t, h

t_after = np.linspace(0, tmax, 500)[1:]
fig, ax = plt.subplots(figsize=(8, 4.5))
for T37, color, label in [(T37_HIGH, BLUE, "High K well"), (T37_LOW, ORANGE, "Low K well")]:
    t, h = response(T37, t_after)
    ax.plot(t, h, color=color, lw=2, label=label)
    ax.plot([T37, T37], [-0.05, 0.37], color=color, ls="--", lw=1.5)
    ax.plot(T37, 0.37, "o", color=color, mec="white", mew=1.5, ms=8, zorder=5)
ax.axvline(0, color=MUTED, ls="--", lw=1)
ax.hlines(0.37, 0, T37_LOW, color=MUTED, ls="--", lw=1)
ax.text(0, 1.22, "slug added", ha="center", va="bottom", fontsize=9, fontweight="bold")
ax.text(8, 0.14, f"T37 = {T37_HIGH} min", color=BLUE, fontsize=9, fontweight="bold")
ax.text(36, 0.52, f"T37 = {T37_LOW} min", color=ORANGE, fontsize=9, fontweight="bold")
ax.text(tmin + 1, 0.39, "H/H0 = 0.37", color=MUTED, fontsize=9)
ax.text(tmin + 1, 0.03, "steady", color=MUTED, fontsize=9)
ax.set_xlim(tmin, tmax); ax.set_ylim(-0.05, 1.2)
ax.set_yticks(np.arange(0, 1.01, 0.2))
ax.set_xlabel("Time relative to slug (min)"); ax.set_ylabel("Head above static level, H/H0")
ax.grid(alpha=0.25)
ax.spines[["top", "right"]].set_visible(False)
ax.legend(frameon=False, loc="upper right")
fig.tight_layout()
fig.savefig("figure_python.png", dpi=150)
