# YM Camp 2026 — Website

Static HTML/CSS website for the Vineyard Ward Young Men's Camp at Echo Lake, July 13–16, 2026.

## Open Locally

Double-click `index.html`, or open in any browser. No build step, no server required.

## Deploy to GitHub Pages (Free Hosting)

1. **Create a public GitHub repo.** Suggested name: `ym-camp-2026`.
2. **Push everything in this folder to the repo root:**
   ```
   git init
   git add .
   git commit -m "Initial site"
   git branch -M main
   git remote add origin https://github.com/<your-username>/ym-camp-2026.git
   git push -u origin main
   ```
3. **Enable GitHub Pages:** repo Settings → Pages → Source: "Deploy from a branch" → Branch: `main` / root → Save.
4. Site goes live in about a minute at `https://<your-username>.github.io/ym-camp-2026/`.
5. Optional: connect a custom domain (~$12/yr at Cloudflare Registrar). Add a `CNAME` file with the domain to the repo root + DNS record at the registrar.

## File Map

```
site/
├── index.html         Home + headline timeline
├── agenda.html        Full hour-by-hour day-by-day
├── camp.html          Echo Lake info, weather, what's there
├── pack.html          Pack list (Wix-structured)
├── safety.html        Survival night, bears, firearms, medical, comms
├── logistics.html     Drop-off, vehicles, food, costs, drive routes
├── leaders.html       4 leader cards with roles + contacts
├── swag.html          Hoodie design + ordering
├── map.html           Map page (embeds the interactive widget)
├── styles.css         Shared stylesheet
├── README.md          This file
├── assets/
│   ├── route_map_widget.html    Interactive Leaflet map (Fehr_Lake.gpx baked in)
│   └── Fehr_Lake.gpx            Recorded Gaia track, TH → Hoover Lake
└── forms/
    └── medical-release.pdf      Parental / medical permission form
```

## Updating the Site

Edit any `.html` file in a code editor (Dreamweaver, VS Code) or directly in github.com via the pencil icon. Commit and push (or save via GitHub web UI) — site updates within a minute.

Common updates to plan for:

| Section | What to update | When |
|---|---|---|
| **Leaders** | Replace `Leader name TBD` and phone numbers | After leaders confirm contact info |
| **SWAG** | Replace design preview placeholder + add Google Form ordering link | After Wednesday YM design meeting |
| **Agenda** | Confirm departure/return locations | After parent meeting |
| **Safety** | Confirm firearm policy decision | After Speaker B checks church policy |
| **Map** | Drop in road GPX from recon hike (optional) | After recon hike |

## Tags

The `tbd` tag (yellow background) marks anything still pending a decision. Search the codebase for `tag tbd` to find them all.

## Search & Replace

To bulk-update leader names once confirmed:
```bash
# Example: replace placeholder in all html files
sed -i '' 's/Leader name TBD/Actual Name/g' leaders.html
```
