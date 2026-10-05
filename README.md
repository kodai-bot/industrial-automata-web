# Industrial Automata website

The company site: [Astro](https://astro.build) static pages, served from a certified-assets canister
on the Internet Computer (`@dfinity/static-site` recipe). Every response is certified by the canister
and checked by the HTTP gateway.

## Editing content

| What | Where |
|---|---|
| Name, tagline, contact email, registration line | `src/site.ts` |
| Consulting / Research pages | `src/pages/consulting.md`, `src/pages/research.md` (plain Markdown) |
| Home page | `src/pages/index.astro` |
| Contact page | `src/pages/contact.astro` (reads `src/site.ts`) |
| Notes (blog) | add `src/content/notes/<slug>.md` with `title`, `date` (and optional `description`, `draft: true`) |
| Colours, fonts, spacing | the token block at the top of `src/styles/global.css` |
| Security / cache headers | `public/_headers` |
| Redirects | `public/_redirects` |

The current copy is **draft placeholder text**. Look for `DRAFT` and `TODO` comments.

## Develop

```bash
npm install
npm run dev            # http://localhost:4321 (hot reload, plain Astro)
npm run build          # outputs dist/
```

## Run on the local IC network

```bash
icp network start -d   # local network on :4943 (see icp.yaml; :8000 is taken on this machine)
icp deploy             # builds and syncs dist/ to the canister
# → http://website.local.localhost:4943/
icp network stop
```

## Going live (not done yet)

1. **Mainnet identity with cycles.** Create a password-protected identity with `icp identity new mainnet --storage password`. Send it ICP from the NNS dapp (address from `icp identity account-id --identity mainnet`), then convert the ICP to cycles (see the `cycles-management` ICP skill).
2. **Deploy.** Run `icp deploy -e ic --identity mainnet`. The site is then at `https://<canister-id>.icp.net`. The canister ID is stored in `.icp/data/`, which **is** committed.
3. **Domain file.** Create `public/.well-known/ic-domains` listing the domain(s), e.g. `industrialautomata.ie` and `www.industrialautomata.ie`. Set `site:` in `astro.config.mjs` and redeploy.
4. **Cloudflare DNS** (per domain):
   - Set records to **DNS only** (grey cloud), and **disable Universal SSL / edge certificates**. Otherwise they interfere with the IC's certificate issuance.
   - Add three records:
     - `CNAME <domain> → <domain>.icp1.io` (Cloudflare flattens this at the apex)
     - `TXT _canister-id.<domain> → <canister-id>`
     - `CNAME _acme-challenge.<domain> → _acme-challenge.<domain>.icp2.io`
5. **Register.** Run `curl -sL "https://icp.net/custom-domains/v1/<domain>/validate"`, then `curl -sL -X POST "https://icp.net/custom-domains/v1/<domain>"`, then poll with a GET until the status is `registered`.
6. **Redeploy any time** with `git pull && icp deploy -e ic --identity mainnet`.
