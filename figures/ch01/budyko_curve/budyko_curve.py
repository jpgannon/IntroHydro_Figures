"""Chapters 1 and 5 - The Budyko curve (conceptual).
Evaporative index (ET/P) as a function of aridity index (PET/P), using Budyko's (1974) equation
plus the energy limit (ET = PET) and the water limit (ET = P). The authors asked for their own version of this
figure; the scatter of real catchments needs a catchment dataset and is not included."""
import numpy as np
import matplotlib.pyplot as plt

x = np.linspace(0.01, 5, 500)                       # aridity index PET/P
budyko = np.sqrt(x * np.tanh(1 / x) * (1 - np.exp(-x)))
energy_limit = np.minimum(x, 1)                      # ET/P cannot exceed PET/P ...
water_limit = np.ones_like(x)                        # ... or 1 (all precipitation)

fig, ax = plt.subplots(figsize=(7, 5))
ax.plot(x, np.minimum(x, 1), "k-", lw=1.5, label="Energy limit (ET = PET) and water limit (ET = P)")
ax.plot(x, budyko, color="#1b4f72", lw=3, label="Budyko curve")
ax.axvline(1, color="grey", ls=":", lw=1)
ax.text(0.5, 0.12, "energy-limited\n(humid)", ha="center", fontsize=11)
ax.text(3, 0.62, "water-limited\n(arid)", ha="center", fontsize=11)
ax.set_xlim(0, 5); ax.set_ylim(0, 1.1)
ax.set_xlabel("Aridity index, PET / P"); ax.set_ylabel("Evaporative index, ET / P")
ax.legend(loc="lower right", frameon=False)
ax.spines[["top", "right"]].set_visible(False)
fig.tight_layout(); fig.savefig("figure_python.png", dpi=150)
