# Hydrology Textbook – figures with code

One folder per figure in `figures/<chapter>/<figure>/` with the same figure written in **Python**, **R** (base R, no packages) and **MATLAB**, the PNG each script produces, the author's data (when supplied) and an `index.html` page showing the figure and the three scripts.
`index.html` at the top is the gallery. Source: draft chapters "Chapters 12Oct26".

## Publish on GitHub Pages
1. Create a new GitHub repository and push the *contents* of this folder (including `.nojekyll`, the PNGs and all `index.html` files).
2. Repository **Settings → Pages → Build and deployment → Source: Deploy from a branch**, branch `main`, folder `/ (root)`, Save.
3. After about a minute the gallery is at `https://<user>.github.io/<repo>/`. Links to a single figure look like `.../figures/ch04/rating_curve/`.

## Re-run everything
`./run_all.sh` runs all 25 figures (needs Python with numpy/pandas/matplotlib, Rscript, and MATLAB or GNU Octave; `USE_OCTAVE=1` forces Octave) and then `python3 build_site.py` rewrites the HTML. Each script can also be run on its own from inside its folder.
The MATLAB scripts were **tested in GNU Octave 8.4, not in MATLAB itself**; they use only core functions, but please run them once in MATLAB before publishing.

## Figures (25)
| Ch | Figure | Basis |
|---|---|---|
| 1 | storage_pools; budyko_curve | Table 1.1 values; Budyko (1974) equation |
| 2 | hydrograph_types (Fig 2.3); water_budget_four_climates (Fig 2.7) | author code (truncated, see below) |
| 3 | vapor_pressure (3.11); hyetographs_frontal_convective (3.9); hyetograph_hourly (3.16); normal_distribution_pdf_cdf (3.21, 3.22) | author code / data files; normal curves from the equation |
| 4 | storm_hydrograph, runoff_pathways, midsection_gauging, rating_curve, baseflow_separation, hydraulic_conductivity_ratio, stream_length_discharge | author CSVs in `figs/` |
| 5 | crop_coefficient; flux_tower_latent_heat | author xlsx |
| 6 | snotel_swe_streamflow; temperature_melt_regression | author CSVs |
| 7 | retention_curve_models; green_ampt_infiltration; green_ampt_vs_horton; soil_texture_triangle | author workbook parameters; USDA texture rules |
| 8 | slug_test | author code (Word comment) |
| 12 | clausius_clapeyron | author code (Word comment) |

Original spreadsheets are in `data_originals/`; the sheets actually used were converted to CSV inside the figure folders.

## Things to check (found while building)
- **Truncated author code.** Word cuts comments at 2048 characters. The code for Ch 2 Fig 2.3 and Fig 2.7, Ch 3 Fig 3.11 and Ch 12 Clausius–Clapeyron was cut off; the remainder was rebuilt to match the figure images in the drafts, so those are reconstructions, not the authors' exact code. In Fig 2.3 panel C the month ticks are now evenly spaced (the draft image's "third ruler" has uneven ticks, as flagged in the comment).
- **Ch 3 file labels.** `Code for Figure 3.11` is the vapor-pressure figure; `Code for Figure 4.17` and `Data_Figure_3_17.xlsx` reproduce the hourly hyetograph (Fig 3.16 in the draft), not figures with those numbers.
- **Ch 7 Green–Ampt.** The workbook's Ψ_front is labelled −70 cm, but its numbers only reproduce with 70 **mm**; the script uses 70 mm. The workbook's Horton column appears shifted one row early; the script computes it directly.
- **Ch 6 Bogus Basin.** The CSV has negative "melt" values and 30 rows in mm; the draft alt text says cm and n = 17. Fit: slope 0.14 mm/°C, R² = 0.55.
- **Ch 1.** Table 1.1 contains "85,4000"; 85,400 was assumed. **Ch 5.** The crop-coefficient workbook has duplicate rows; the five breakpoints are embedded.
- Figure numbering in the drafts is inconsistent ("X", "5.X"), so folder names use descriptive slugs.

## Not included
Photos, maps, schematics/illustrations, conceptual diagrams and figures that need data not in the chapter folders (e.g. catchment scatter for the Budyko curve, Ch 9–11, 13, 14 figures, Ch 8 maps and flow nets) were left out. Ch 8 advection–dispersion/Thiem plots and the Ch 14 Piper plot could be added if the authors supply parameters/data.
