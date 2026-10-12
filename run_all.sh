#!/usr/bin/env bash
# Run every figure script (Python, R, MATLAB or GNU Octave) and rebuild the site pages.
# Needs: python3 (numpy, pandas, matplotlib), Rscript (base R only), and MATLAB *or* GNU Octave (set USE_OCTAVE=1).
set -u
cd "$(dirname "$0")"
for d in figures/*/*/; do
  d=${d%/}; s=$(basename "$d"); echo "== $d"
  ( cd "$d"
    python3 "$s.py" || echo "  python failed"
    Rscript "$s.R"  || echo "  R failed"
    if [ "${USE_OCTAVE:-0}" = "1" ] || ! command -v matlab >/dev/null; then
      octave --no-gui --eval "graphics_toolkit('qt'); run('$s.m')" || echo "  octave failed"   # drop the toolkit call if it errors on your install
    else
      matlab -batch "run('$s.m')" || echo "  matlab failed"
    fi )
done
python3 build_site.py
