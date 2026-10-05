# ia_website — agent notes

- Astro 7 static site, hosted with the ICP `@dfinity/static-site` recipe (certified-assets canister). See `icp.yaml`.
  - Configure with `public/_headers` and `public/_redirects`. **Never** use `.ic-assets.json5`, which is for the legacy asset canister.
  - Before changing hosting config, fetch the `static-site` (and, for domains, `custom-domains`) skill from <https://skills.internetcomputer.org>.
- The CSP in `public/_headers` forbids inline scripts and styles, and `astro.config.mjs` sets `inlineStylesheets: 'never'`.
  - Don't add inline `<script>`/`<style>`/`style=""` or external CDN fonts or scripts. Put CSS in `src/styles/global.css`, or in component `<style>` blocks, which build to files.
- Content is Markdown: `src/pages/*.md` uses `layouts/Page.astro`, and notes live in `src/content/notes/`. Site-wide details are in `src/site.ts`.
- Keep the look monochrome plus the one accent token. Restyle through the tokens at the top of `global.css`.
- Dev server: `astro dev --background` (manage with `astro dev stop|status|logs`). Docs: <https://docs.astro.build>.
- Local IC network is on port 4943. **Never** run `icp deploy -e ic`, touch DNS, or spend cycles without Dylan's explicit go-ahead.
