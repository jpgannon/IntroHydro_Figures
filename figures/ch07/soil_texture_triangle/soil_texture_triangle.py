"""USDA soil texture triangle
Chapter 7 draft (Figure "Texture"); classes computed from the standard USDA texture-class rules (sand, silt, clay in % by weight)
Run: python3 soil_texture_triangle.py -> figure_python.png"""
import numpy as np, matplotlib
matplotlib.use("Agg"); import matplotlib.pyplot as plt
names = ["Sand", "Loamy sand", "Sandy loam", "Loam", "Silt loam", "Silt", "Sandy clay loam", "Clay loam", "Silty clay loam", "Sandy clay", "Silty clay", "Clay"]
def classify(sand, silt, clay):
    """USDA texture class index (0-11) from percent sand, silt, clay (rules as in the NRCS soil-texture calculator)."""
    c = np.full(np.shape(sand), -1)
    rules = [
        (0,  silt + 1.5 * clay < 15),
        (1,  (silt + 1.5 * clay >= 15) & (silt + 2 * clay < 30)),
        (2,  ((clay >= 7) & (clay < 20) & (sand > 52) & (silt + 2 * clay >= 30)) | ((clay < 7) & (silt < 50) & (silt + 2 * clay >= 30))),
        (3,  (clay >= 7) & (clay < 27) & (silt >= 28) & (silt < 50) & (sand <= 52)),
        (4,  ((silt >= 50) & (clay >= 12) & (clay < 27)) | ((silt >= 50) & (silt < 80) & (clay < 12))),
        (5,  (silt >= 80) & (clay < 12)),
        (6,  (clay >= 20) & (clay < 35) & (silt < 28) & (sand > 45)),
        (7,  (clay >= 27) & (clay < 40) & (sand > 20) & (sand <= 45)),
        (8,  (clay >= 27) & (clay < 40) & (sand <= 20)),
        (9,  (clay >= 35) & (sand > 45)),
        (10, (clay >= 40) & (silt >= 40)),
        (11, (clay >= 40) & (sand <= 45) & (silt < 40))]
    for k, m in rules: c = np.where((c < 0) & m, k, c)
    return c
# Triangle geometry: clay at the apex, sand at lower left, silt at lower right.
H = np.sqrt(3) / 2
xs, ys = np.meshgrid(np.linspace(0, 1, 900), np.linspace(0, H, 780))
clay = 100 * ys / H; silt = 100 * (xs - 0.5 * clay / 100); sand = 100 - clay - silt
inside = (clay >= 0) & (silt >= 0) & (sand >= 0)
cls = np.where(inside, classify(sand, silt, clay), np.nan)
fig, ax = plt.subplots(figsize=(7.5, 6.6))
ax.pcolormesh(xs, ys, cls, cmap=plt.get_cmap("Set3", 12), vmin=-0.5, vmax=11.5, shading="auto")
ax.plot([0, 1, 0.5, 0], [0, 0, H, 0], "k-", lw=1.5)
for k, n in enumerate(names):
    m = cls == k
    if m.any(): ax.text(xs[m].mean(), ys[m].mean(), n.replace(" ", "\n") if len(n) > 9 else n, ha="center", va="center", fontsize=7.5 if k not in (0, 1, 5) else 6.5)
for v in range(10, 100, 10):    # edge tick labels
    ax.text(0.5 * v / 100 - 0.035, H * v / 100, str(v), fontsize=7, ha="center")                      # clay, left edge
    ax.text(1 - v / 100 + 0.0, -0.03, str(v), fontsize=7, ha="center")                                # sand, bottom edge (increases to the left)
    ax.text(1 - 0.5 * v / 100 + 0.035, H * v / 100, str(100 - v), fontsize=7, ha="center") if False else ax.text(1 - 0.5 * (100 - v) / 100 + 0.035, H * (100 - v) / 100, str(v), fontsize=7, ha="center")  # silt, right edge
ax.text(0.2, 0.5 * H + 0.05, "Clay (%)", rotation=60, ha="center", fontsize=9, fontweight="bold")
ax.text(0.5, -0.08, "Sand (%)", ha="center", fontsize=9, fontweight="bold")
ax.text(0.8, 0.5 * H + 0.05, "Silt (%)", rotation=-60, ha="center", fontsize=9, fontweight="bold")
ax.set_aspect("equal"); ax.axis("off"); ax.set_xlim(-0.08, 1.08); ax.set_ylim(-0.12, H + 0.05)
fig.tight_layout(); fig.savefig("figure_python.png", dpi=150)
