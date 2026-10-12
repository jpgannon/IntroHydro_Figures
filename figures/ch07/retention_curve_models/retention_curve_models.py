"""Soil water retention curves: Brooks–Corey, Campbell and van Genuchten (sandy loam and silty clay)
Chapter 7 draft; parameters from the chapter author (Figures_4_5_6_and_Table1_2026_10_02.xlsx, RetentionCurves sheet; Clapp & Hornberger 1978 / Rawls et al. parameter sets)
Run: python3 retention_curve_models.py -> figure_python.png"""
import numpy as np, matplotlib
matplotlib.use("Agg"); import matplotlib.pyplot as plt
# Parameters (RetentionCurves sheet). psi_ae = air-entry (cm); b = pore-size exponent.
soils = {"Sandy loam": dict(phi=0.435, thr=0.06, psi_ae=21.8, b_bc=3.9, b_camp=4.9, alpha=0.025, n=1.3),
         "Silty clay": dict(phi=0.492, thr=0.241, psi_ae=49.0, b_bc=4.4, b_camp=10.4, alpha=0.01, n=1.3)}
def brooks(th, s):  se = (th - s["thr"]) / (s["phi"] - s["thr"]); return s["psi_ae"] * se ** (-s["b_bc"])
def campbell(th, s): return s["psi_ae"] * (th / s["phi"]) ** (-s["b_camp"])
def vang(th, s):
    se = (th - s["thr"]) / (s["phi"] - s["thr"]); m = 1 - 1 / s["n"]
    return (se ** (-1 / m) - 1) ** (1 / s["n"]) / s["alpha"]
fig, axes = plt.subplots(1, 2, figsize=(10, 4.6), sharey=True)
for ax, (name, s) in zip(axes, soils.items()):
    th = np.linspace(s["thr"] + 0.01, s["phi"] - 0.002, 400)
    ax.plot(th, brooks(th, s), color="#1f4e79", lw=2, label="Brooks–Corey")
    ax.plot(th, campbell(th[th > 0.01], s), color="#e8743b", lw=2, ls="--", label="Campbell") if False else ax.plot(th, campbell(th, s), color="#e8743b", lw=2, ls="--", label="Campbell")
    ax.plot(th, vang(th, s), color="#2e8b57", lw=2, ls=":", label="van Genuchten")
    ax.axhline(340, color="grey", lw=0.8, ls=":"); ax.axhline(15300, color="grey", lw=0.8, ls=":")
    ax.set_yscale("log"); ax.set_ylim(1, 1e7); ax.set_title(name, loc="left", fontsize=10)
    ax.set_xlabel("Volumetric water content, θ (m³/m³)"); ax.grid(alpha=0.25)
    for sp in ("top", "right"): ax.spines[sp].set_visible(False)
axes[0].set_ylabel("Matric potential magnitude, |ψ| (cm)"); axes[0].legend(frameon=False)
fig.tight_layout(); fig.savefig("figure_python.png", dpi=150)
