"""Chapter 12, Figure X.3 - The Clausius-Clapeyron relationship.
Based on the code pasted as a comment in the Chapter 12 draft (J. Gannon). The pasted code was cut off part-way
through the third annotation, so the end of the script (right-hand axis, footer, save) was completed to match the
figure in the draft."""
import numpy as np
import matplotlib.pyplot as plt

es0 = 6.11        # hPa at T0
T0 = 273.15       # K
L = 2.501e6       # J/kg, latent heat of vaporization
Rv = 461.5        # J/(kg*K), gas constant for water vapor

def es(T_celsius):
    """Saturation vapor pressure (hPa), constant-L Clausius-Clapeyron"""
    T = T_celsius + 273.15
    return es0 * np.exp((L / Rv) * (1.0 / T0 - 1.0 / T))

def rho_sat(T_celsius):
    """Saturation absolute humidity (g/m^3) from the ideal gas law: rho = e / (Rv * T)"""
    T = T_celsius + 273.15
    e_pa = es(T_celsius) * 100.0          # hPa -> Pa
    return e_pa / (Rv * T) * 1000.0       # kg/m^3 -> g/m^3

T = np.linspace(10, 30, 400)
es_vals = es(T)
rho_vals = rho_sat(T)

def es_to_rho(e):
    return np.interp(e, es_vals, rho_vals)

def rho_to_es(r):
    return np.interp(r, rho_vals, es_vals)

plt.rcParams['font.family'] = 'DejaVu Serif'
fig, ax = plt.subplots(figsize=(7.6, 5.8))
ax.plot(T, es_vals, color='#1b4f72', lw=2.4, zorder=3)

T_ref = 15.0
for dT, color in [(0, '#1b4f72'), (2, '#e67e22'), (4, '#c0392b')]:
    Tp = T_ref + dT
    ax.plot([Tp, Tp], [0, es(Tp)], ls='--', lw=1.1, color=color, alpha=0.8, zorder=2)
    ax.plot(Tp, es(Tp), 'o', color=color, ms=6, zorder=4)

ax.annotate(f'{T_ref:.0f}°C\n{es(T_ref):.1f} hPa\n({rho_sat(T_ref):.1f} g/m³)',
            xy=(T_ref, es(T_ref)), xytext=(T_ref-4.6, es(T_ref)+5.0), fontsize=9.3, color='#1b4f72', linespacing=1.4)
ax.annotate(f'+2°C\n{es(T_ref+2):.1f} hPa ({rho_sat(T_ref+2):.1f} g/m³)\n'
            f'{(es(T_ref+2)/es(T_ref)-1)*100:.0f}% more water vapor',
            xy=(T_ref+2, es(T_ref+2)), xytext=(T_ref-0.6, es(T_ref+2)+3.0), fontsize=9.3, color='#e67e22', linespacing=1.4)
ax.annotate(f'+4°C\n{es(T_ref+4):.1f} hPa ({rho_sat(T_ref+4):.1f} g/m³)\n'
            f'{(es(T_ref+4)/es(T_ref)-1)*100:.0f}% more water vapor',
            xy=(T_ref+4, es(T_ref+4)), xytext=(T_ref+3.4, es(T_ref+4)+5.0), fontsize=9.3, color='#c0392b', linespacing=1.4)

# ---- completed from here (the original code was cut off) ----
ax.set_xlim(10, 30); ax.set_ylim(10, 48.5)
ax.set_xlabel('Temperature (°C)', fontsize=12)
ax.set_ylabel('Saturation vapor pressure, $e_s$ (hPa)', fontsize=12, color='#1b4f72')
ax.grid(alpha=0.25)
ax.spines[['top']].set_visible(False)
sec = ax.secondary_yaxis('right', functions=(es_to_rho, rho_to_es))
sec.set_ylabel('Water vapor in air at saturation (g per m³)', fontsize=12, color='#6e4a2f')
ax.set_title('The Clausius–Clapeyron relationship', fontsize=14, fontweight='bold')
fig.text(0.5, 0.01, r'$e_s(T)=e_{s0}\exp[\frac{L}{R_v}(\frac{1}{T_0}-\frac{1}{T})]$;  $\rho_{v,sat}=e_s/(R_vT)$.  '
         r'$e_{s0}$=6.11 hPa at $T_0$=273.15 K, L=2.501e6 J/kg, $R_v$=461.5 J/(kg K)', ha='center', fontsize=8)
fig.tight_layout(rect=(0, 0.04, 1, 1))
fig.savefig('figure_python.png', dpi=150)
