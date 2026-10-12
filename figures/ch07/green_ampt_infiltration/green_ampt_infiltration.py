"""Green–Ampt infiltration under constant rainfall (silty clay)
Chapter 7 draft; parameters from the chapter author (Figures_4_5_6_and_Table1_2026_10_02.xlsx, GreenAmpt sheet); explicit time stepping dt = 0.02 h as in the workbook
Run: python3 green_ampt_infiltration.py -> figure_python.png"""
import numpy as np, matplotlib
matplotlib.use("Agg"); import matplotlib.pyplot as plt
# Silty clay, Campbell parameters (GreenAmpt sheet). Units: mm and hours.
phi, theta_i = 0.492, 0.37          # porosity, initial water content
Ks = 3.72                            # saturated hydraulic conductivity (mm/hr)
psi_f = 70.0                         # wetting-front suction head (mm) -- see note in README
r = 10.0                             # constant rainfall rate (mm/hr)
f0, fc, beta = 30.0, Ks, 3.0         # Horton: initial capacity, final capacity (= Ks), decay (1/hr)
dtheta = phi - theta_i
dt = 0.02; t = np.arange(0, 3.0 + dt / 2, dt)
I = np.zeros_like(t); ipot = np.full_like(t, np.nan); iact = np.zeros_like(t)
for k in range(len(t)):
    ipot[k] = Ks * (1 + psi_f * dtheta / I[k]) if I[k] > 0 else np.inf   # Green-Ampt capacity
    iact[k] = min(r, ipot[k])
    if k + 1 < len(t): I[k + 1] = I[k] + iact[k] * dt
horton = fc + (f0 - fc) * np.exp(-beta * t)

fig, ax = plt.subplots(figsize=(7.5, 4.8))
ax.plot(t, np.minimum(ipot, 60), color="#2e8b57", lw=2, ls="--", label="Green–Ampt capacity, $i_{pot}$")
ax.plot(t, iact, color="#1f4e79", lw=2.4, label="Actual infiltration, $i_{act}$")
ax.axhline(r, color="#e8743b", lw=1.6, label="Rainfall rate, r"); ax.axhline(Ks, color="grey", lw=1, ls=":", label="$K_s$")
ax.set_ylim(0, 40); ax.set_xlabel("Time (hr)"); ax.set_ylabel("Rate (mm/hr)"); ax.legend(frameon=False); ax.grid(alpha=0.25)
for s in ("top", "right"): ax.spines[s].set_visible(False)
fig.tight_layout(); fig.savefig("figure_python.png", dpi=150)
