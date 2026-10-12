"""Chapter 3, Figure 3.16 - Hourly hyetograph for a 24-hour period (21 mm total).
Code from 'Code for Figure 4.17.docx' (the file name uses an older figure number; this is the hourly hyetograph in
Figure 3.16). Data match 'Data_Figure_3_17.xlsx' (hour-ending precipitation, mm/hr), so they are included here."""
import matplotlib.pyplot as plt

hrs = list(range(1, 25))
p = {3: 0.5, 4: 1.5, 5: 8, 6: 4, 7: 2, 8: 0.5, 14: 0.5, 15: 1.5, 16: 0.5, 20: 1.0, 21: 1.0}
v = [p.get(h, 0) for h in hrs]
assert abs(sum(v) - 21) < 1e-9          # total = 21 mm

fig, ax = plt.subplots(figsize=(8, 4), dpi=200)
ax.bar(hrs, v, width=0.9, color="#2b6cb0", edgecolor="#1a365d")
ax.set_ylim(10, 0)                       # inverted axis: bars hang from the top
ax.set_xlim(0.3, 24.7)
ax.set_xticks(range(0, 25, 3))
ax.set_xlabel("Hour ending (h, May 25, 2026)")
ax.set_ylabel("Precipitation (mm/hr)")
ax.spines[['right', 'bottom']].set_visible(False)
ax.xaxis.set_label_position("top")
ax.xaxis.tick_top()
plt.tight_layout()
plt.savefig("figure_python.png")
