"""Chapter 1 - Volumes of Earth's water storage pools (Table 1.1 as a log-scale bar chart).
Data: Table 1.1 of the Chapter 1 draft (volume and range of reported values, km^3)."""
import numpy as np
import matplotlib.pyplot as plt

pools = [  # name, volume, low, high (km^3)
    ("Ocean, deep", 1_206_000_000, 1_100_000_000, 1_300_000_000),
    ("Ocean, mixed layer", 134_000_000, 90_000_000, 170_000_000),
    ("Ice sheets & glaciers", 25_800_000, 24_064_000, 29_200_000),
    ("Groundwater", 22_600_000, 8_060_000, 23_400_000),
    ("Permafrost", 207_000, 22_000, 300_000),
    ("Lakes (fresh)", 108_000, 91_000, 125_000),
    ("Lakes (saline)", 94_700, 85_400, 104_000),   # draft table reads "85,4000"; assumed 85,400
    ("Soil moisture", 54_100, 16_500, 122_000),
    ("Wetlands", 14_100, 11_000, 17_000),
    ("Reservoirs", 10_800, 7_000, 15_000),
    ("Atmosphere (over ocean)", 10_000, 8_000, 12_000),
    ("Atmosphere (over land)", 3_000, 2_700, 3_300),
    ("Snowpack", 2_900, 2_600, 3_500),
    ("Rivers", 1_900, 1_250, 2_120),
    ("Biosphere", 1_120, None, None),
]
names = [p[0] for p in pools]
vol = np.array([p[1] for p in pools], float)
lo = np.array([p[2] if p[2] else np.nan for p in pools], float)
hi = np.array([p[3] if p[3] else np.nan for p in pools], float)
y = np.arange(len(pools))[::-1]

fig, ax = plt.subplots(figsize=(8, 6))
ax.barh(y, vol, color="#2b6cb0", height=0.7)
ax.errorbar(vol, y, xerr=[vol - lo, hi - vol], fmt="none", ecolor="k", capsize=3, lw=1)
ax.set_xscale("log")
ax.set_xlim(500, 5e9)
ax.set_yticks(y)
ax.set_yticklabels(names)
ax.set_xlabel("Volume (km$^3$), log scale")
ax.set_title("Estimated sizes of global water storage pools")
ax.grid(axis="x", alpha=0.3)
ax.spines[["top", "right"]].set_visible(False)
fig.tight_layout()
fig.savefig("figure_python.png", dpi=150)
