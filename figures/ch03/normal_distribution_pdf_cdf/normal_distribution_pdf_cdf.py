"""Figures 3.21 and 3.22: normal PDF and CDF of annual precipitation; effect of standard deviation
Chapter 3 draft; parameters read from the draft figure (mean 40 in; sigma 5 and 10 in for Fig 3.22; sigma 8 in assumed for the Fig 3.21 schematic)
Run: python3 normal_distribution_pdf_cdf.py -> figure_python.png"""
import numpy as np, matplotlib
from math import erf
matplotlib.use("Agg"); import matplotlib.pyplot as plt
pdf = lambda x, mu, sd: np.exp(-0.5 * ((x - mu) / sd) ** 2) / (sd * np.sqrt(2 * np.pi))
cdf = lambda x, mu, sd: 0.5 * (1 + np.vectorize(erf)((x - mu) / (sd * np.sqrt(2))))
mu, sd, xq = 40, 8, 46                      # mean and SD (in); xq = example observation value
x = np.linspace(10, 70, 600)
fig, axs = plt.subplots(1, 3, figsize=(14, 4.2))
ax = axs[0]; ax.plot(x, pdf(x, mu, sd), color="#1f4e79", lw=2); m = x <= xq
ax.fill_between(x[m], 0, pdf(x[m], mu, sd), color="#9ec5e8", label=f"P(X ≤ {xq} in) = {cdf(xq, mu, sd):.2f}")
ax.set_title("(a) Probability density function", loc="left", fontsize=10); ax.set_ylabel("Probability density"); ax.legend(frameon=False)
ax = axs[1]; ax.plot(x, cdf(x, mu, sd), color="#1f4e79", lw=2); ax.fill_between(x[m], 0, cdf(x[m], mu, sd), color="#9ec5e8")
ax.plot([xq, xq], [0, cdf(xq, mu, sd)], "k:", lw=1); ax.plot([10, xq], [cdf(xq, mu, sd)] * 2, "k:", lw=1)
ax.set_title("(b) Cumulative distribution function", loc="left", fontsize=10); ax.set_ylabel("Cumulative probability")
ax = axs[2]
for s, c in ((5, "#4682b4"), (10, "#ff8c00")): ax.plot(x, pdf(x, mu, s), color=c, lw=2.2, label=f"σ = {s} in")
ax.set_title("(c) Narrower vs wider standard deviation", loc="left", fontsize=10); ax.set_ylabel("Probability density"); ax.legend(frameon=False)
for ax in axs:
    ax.set_xlabel("Annual precipitation (inches)"); ax.grid(alpha=0.25)
    for s in ("top", "right"): ax.spines[s].set_visible(False)
fig.tight_layout(); fig.savefig("figure_python.png", dpi=150)
