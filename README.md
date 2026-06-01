# YM Camp 2026 — Website

Static HTML/CSS website for the Vineyard Ward Young Men's Camp at Echo Lake, July 13–16, 2026.

## Open Locally

The committed root `.html` files are encrypted for GitHub Pages. Edit the local-only `src/` copies instead, then run `deploy.sh` to regenerate the encrypted pages.

`src/` is intentionally gitignored so the unencrypted camp details are not published by GitHub Pages or exposed in the public repo.

## Deploy to GitHub Pages

1. **Create or use the GitHub repo.** Current repo: `https://github.com/jkn8/ym-camp-2026`.
2. **Push this folder to the repo root:**
   ```
   git init
   git add .
   git commit -m "Initial site"
   git branch -M safestreets
   git remote add origin https://github.com/jkn8/ym-camp-2026.git
   git push -u origin safestreets
   ```
3. **Enable GitHub Pages:** repo Settings -> Pages -> Source: "Deploy from a branch" -> Branch: `safestreets` / root -> Save.
4. Site goes live in about a minute at `https://jkn8.github.io/ym-camp-2026/`.

## File Map

```
site/
├── index.html         Encrypted home page
├── agenda.html        Encrypted agenda page
├── camp.html          Encrypted camp page
├── pack.html          Encrypted packing page
├── safety.html        Encrypted safety page
├── logistics.html     Encrypted logistics page
├── leaders.html       Encrypted leaders page
├── swag.html          Encrypted gear page
├── map.html           Encrypted map page
├── styles.css         Shared stylesheet
├── deploy.sh          Encrypts local src/ into the published root files
├── README.md          This file
├── assets/
│   ├── route_map_widget.html    Encrypted interactive Leaflet map
│   └── Fehr_Lake.gpx            Recorded Gaia track, TH → Hoover Lake
├── src/               Local-only unencrypted source, gitignored
└── forms/
    └── medical-release.pdf      Parental / medical permission form
```

## Updating the Site

Edit files in `src/`, not the encrypted root `.html` files. Then deploy:

```bash
cd "/Users/jaredneilson/Downloads/Claude-Folder/YM Camp/site"
YM_CAMP_PASSWORD='your-password' ./deploy.sh "Update site"
```

The script copies `src/*.html` and `src/assets/route_map_widget.html` into the published root, encrypts them with Staticrypt, commits the encrypted output, and pushes the current branch.

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
# Example: replace placeholder in source html files
sed -i '' 's/Leader name TBD/Actual Name/g' src/*.html
```
