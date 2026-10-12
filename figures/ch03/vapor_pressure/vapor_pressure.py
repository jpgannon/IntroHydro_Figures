"""Chapter 3, Figure 3.11 - Temperature versus saturation vapor pressure (dew point and RH).
Starts from the code in 'Code for Figure 3.11.docx' (J. Gannon); the pasted code stopped part-way through the
annotations, so the remaining labels were completed to match the figure in the chapter draft."""
import numpy as np
import matplotlib.pyplot as plt

def es(T):
    """Saturation vapor pressure over liquid water (hPa), Bolton (1980); T in deg C."""
    return 6.112 * np.exp(17.67 * T / (T + 243.5))

def dewpoint(e):
    x = np.log(e / 6.112)
    return 243.5 * x / (17.67 - x)

T0, e0 = 25.0, 20.0
Td = dewpoint(e0)
RH = 100 * e0 / es(T0)
T = np.linspace(-20, 40, 600)

fig, ax = plt.subplots(figsize=(11, 8))
ax.fill_between(T, es(T), 80, color="#fbe3e3")
ax.fill_between(T, 0, es(T), color="#deebf7")
ax.plot(T, es(T), "k", lw=2.5)
ax.set_xlim(-20, 40); ax.set_ylim(0, 80)
ax.set_xlabel("Temperature (°C)", fontsize=14, labelpad=30)
ax.set_ylabel("Water-vapor pressure (hPa)", fontsize=14)
ax.set_title("Figure 3.11: Temperature versus saturation vapor pressure.", fontsize=15, fontweight="bold", pad=14)
ax.text(31.5, 68, r"$e_{s}(T)$", fontsize=15)

# Parcel and cooling path at constant vapor pressure
ax.plot([T0], [e0], "ko", ms=9, zorder=5)
ax.annotate("", xy=(Td, e0), xytext=(T0 - 0.6, e0),
            arrowprops=dict(arrowstyle="-|>", lw=3, color="k", mutation_scale=18))
ax.plot([Td], [e0], "ko", ms=9, zorder=5)
ax.plot([-20, Td], [e0, e0], "k", ls=(0, (2, 3)), lw=1)
ax.plot([Td, Td], [0, e0], "k--", lw=1)
ax.plot([T0, T0], [0, e0], "k--", lw=1)
ax.text(T0, e0 + 2.5, f"RH ≈ {RH:.0f}%", ha="center", fontsize=12)
ax.text((T0 + Td) / 2, e0 - 3, "air parcel cools at\nnearly constant\nvapor pressure",
        ha="center", va="top", style="italic", fontsize=11, zorder=6, bbox=dict(fc="#deebf7", ec="none", pad=2))

# Dew point annotation
ax.annotate("saturation reached:\nRH = 100%,\ndew point", xy=(Td - 0.4, e0 + 0.6), xytext=(-8, 27),
            fontsize=11, ha="center", arrowprops=dict(arrowstyle="-|>", color="k"))

# Below dew point: vapor pressure follows es(T) (condensation)
Tc = np.linspace(Td, -14, 100)
ax.plot(Tc, es(Tc), color="#cc0000", lw=3.5, zorder=4)
ax.annotate("", xy=(-15, es(-15)), xytext=(-13, es(-13)),
            arrowprops=dict(arrowstyle="-|>", color="#cc0000", lw=3, mutation_scale=18))
ax.text(-19, 6.5, "condensation begins;\nvapor pressure limited\nto $e_s(T)$ as parcel\ncools further",
        color="#cc0000", style="italic", fontsize=11, va="bottom")

# ---- completed from here (the original code was cut off) ----
ax.text(-7.5, 56, "supersaturated conditions\n($e > e_s$; beyond scope)", color="#cc0000", fontsize=14, ha="center")
ax.text(34, 31, "unsaturated\nair parcels\n($e < e_s$)", color="#1f5fbf", fontsize=14, ha="center")
ax.annotate("", xy=(6, 33), xytext=(19, 33), arrowprops=dict(arrowstyle="-|>", color="#2740c0", lw=2))
ax.text(12.5, 35, "RH increases\nas T decreases", color="#2740c0", style="italic", fontsize=13, ha="center")
ax.text(Td, -5.5, f"$T_d$ = {Td:.1f}°C", ha="center", va="top", fontsize=11)
ax.text(T0, -5.5, "25°C", ha="center", va="top", fontsize=11)
fig.text(0.5, 0.025, r"$RH = \dfrac{e}{e_s(T)} \times 100\%$   (actual vapor pressure $e$ / saturation vapor pressure $e_s$)",
         ha="center", fontsize=13, bbox=dict(boxstyle="round", fc="white"))
fig.subplots_adjust(bottom=0.2)
fig.savefig("figure_python.png", dpi=150)
