#!/usr/bin/env python3
"""Generate the GitHub Pages site (index.html + one page per figure) from figures/<chapter>/<figure>/.
Run after run_all.sh (which writes figure_python.png / figure_r.png / figure_matlab.png).
Usage: python3 build_site.py"""
import html, json, os
ROOT = os.path.dirname(os.path.abspath(__file__))
CHAPTERS = {"ch01": "Chapter 1 · Water on Earth", "ch02": "Chapter 2 · Watersheds and the Water Budget", "ch03": "Chapter 3 · Precipitation",
            "ch04": "Chapter 4 · Streamflow, Runoff Generation, and Overland Flow", "ch05": "Chapter 5 · Energy Cycle and Evapotranspiration",
            "ch06": "Chapter 6 · Snow and Snowmelt", "ch07": "Chapter 7 · Soil Moisture and Infiltration", "ch08": "Chapter 8 · Groundwater",
            "ch12": "Chapter 12 · Climate Change"}
CSS = """:root{--bg:#fff;--fg:#1d2733;--mut:#5b6877;--line:#d8dee6;--acc:#1f5f8b;--card:#f6f8fa}
@media (prefers-color-scheme:dark){:root{--bg:#10161d;--fg:#e6ebf0;--mut:#9aa8b6;--line:#2b3641;--acc:#7fb7e6;--card:#18212b}}
*{box-sizing:border-box}body{margin:0;background:var(--bg);color:var(--fg);font:16px/1.5 system-ui,-apple-system,Segoe UI,Roboto,sans-serif}
main{max-width:1000px;margin:0 auto;padding:24px 16px 64px}a{color:var(--acc)}h1{font-size:1.6rem;margin:.2em 0}h2{font-size:1.2rem;margin:2em 0 .6em;border-bottom:1px solid var(--line);padding-bottom:.3em}
.grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(220px,1fr));gap:14px}.card{display:block;border:1px solid var(--line);border-radius:8px;background:var(--card);text-decoration:none;color:inherit;overflow:hidden}
.card img{width:100%;height:150px;object-fit:contain;background:#fff;display:block}.card span{display:block;padding:8px 10px;font-size:.9rem}
.tabs{display:flex;gap:6px;margin:16px 0 0}.tabs button{border:1px solid var(--line);background:var(--card);color:var(--fg);padding:6px 14px;border-radius:6px 6px 0 0;cursor:pointer;font:inherit}
.tabs button[aria-selected=true]{background:var(--acc);color:#fff;border-color:var(--acc)}.panel{border:1px solid var(--line);padding:12px;border-radius:0 6px 6px 6px}
.panel img{max-width:100%;height:auto;background:#fff;display:block;margin:0 auto 12px}pre{overflow:auto;background:var(--card);border:1px solid var(--line);padding:12px;border-radius:6px;font-size:.82rem;line-height:1.4;max-height:520px}
.note{border-left:4px solid var(--acc);padding:6px 12px;background:var(--card);margin:14px 0}.mut{color:var(--mut);font-size:.9rem}"""
def page(title, body):
    return f"<!doctype html><html lang=en><head><meta charset=utf-8><meta name=viewport content='width=device-width,initial-scale=1'><title>{html.escape(title)}</title><style>{CSS}</style></head><body><main>{body}</main></body></html>"
figs = {}
for ch in sorted(os.listdir(f"{ROOT}/figures")):
    for slug in sorted(os.listdir(f"{ROOT}/figures/{ch}")):
        d = f"{ROOT}/figures/{ch}/{slug}"; meta = json.load(open(f"{d}/meta.json"))
        figs.setdefault(ch, []).append((slug, meta))
        tabs, panels = [], []
        for i, (lang, ext, fig_png, label) in enumerate([("python", "py", "figure_python.png", "Python"), ("r", "R", "figure_r.png", "R"), ("matlab", "m", "figure_matlab.png", "MATLAB")]):
            code = open(f"{d}/{slug}.{ext}", encoding="utf-8").read()
            sel = "true" if i == 0 else "false"
            tabs.append(f"<button role=tab aria-selected={sel} data-t={lang}>{label}</button>")
            panels.append(f"<div class=panel data-p={lang} {'hidden' if i else ''}><img src='{fig_png}' alt='{html.escape(meta['title'])} ({label} output)'><p class=mut>Code: <a href='{slug}.{ext}'>{slug}.{ext}</a> · image: <a href='{fig_png}'>{fig_png}</a></p><pre><code>{html.escape(code)}</code></pre></div>")
        data = sorted(f for f in os.listdir(d) if f.endswith((".csv", ".xlsx", ".txt")))
        dl = ("<p><b>Data:</b> " + ", ".join(f"<a href='{f}'>{f}</a>" for f in data) + "</p>") if data else "<p class=mut>No external data file: values are small and embedded in the code.</p>"
        note = f"<div class=note>{html.escape(meta['notes'])}</div>" if meta.get("notes") else ""
        js = "document.querySelectorAll('.tabs button').forEach(b=>b.onclick=()=>{document.querySelectorAll('.tabs button').forEach(x=>x.setAttribute('aria-selected',x===b));document.querySelectorAll('.panel').forEach(p=>p.hidden=p.dataset.p!==b.dataset.t)})"
        body = (f"<p><a href='../../../index.html'>← All figures</a></p><p class=mut>{CHAPTERS.get(ch, ch)}</p><h1>{html.escape(meta['title'])}</h1><p>{html.escape(meta['caption'])}</p>"
                f"<p class=mut>Source: {html.escape(meta['source'])}</p>{note}{dl}<div class=tabs role=tablist>{''.join(tabs)}</div>{''.join(panels)}<script>{js}</script>")
        open(f"{d}/index.html", "w", encoding="utf-8").write(page(meta["title"], body))
body = "<h1>Hydrology Textbook – figures with code</h1><p>Click a figure to see it and the code that makes it in <b>Python</b>, <b>R</b> and <b>MATLAB</b>. Each figure folder also contains the data (when the authors supplied it).</p>"
for ch in sorted(figs):
    body += f"<h2>{CHAPTERS.get(ch, ch)}</h2><div class=grid>"
    for slug, meta in figs[ch]:
        body += f"<a class=card href='figures/{ch}/{slug}/index.html'><img loading=lazy src='figures/{ch}/{slug}/figure_python.png' alt=''><span>{html.escape(meta['title'])}</span></a>"
    body += "</div>"
open(f"{ROOT}/index.html", "w", encoding="utf-8").write(page("Hydrology Textbook figures", body))
print(sum(len(v) for v in figs.values()), "figure pages written")
