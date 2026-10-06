# Roadmap

Ideas to develop later. Not published on the site.

## Anchored publications (planned)

**Idea:** every paper, article, report or case study published by Industrial Automata gets a SHA-256 fingerprint recorded on the Internet Computer when it is released. Anyone holding a copy can check that it is the exact original, and see when and by whom it was anchored. It's provenance applied to our own output, demonstrating the research claim on the site itself.

**First candidates:**
- IEEE ISSC 2025 paper (author's accepted version, or a fingerprint of the published PDF)
- MSc thesis (2024)
- Technological-evolution paper and the `pu_ratchet_analysis` code, once accepted
- Case studies and notes on this site

**Building blocks that already exist:**
- `../anchor_mo/`: Motoko canister holding an append-only history of `{root, storedBy, storedAt}`. It currently runs on the local network only.
- `../py_client/`: `uv run anchor store|verify <path>` hashes a file or directory and anchors or verifies it.

**Work to do:**
1. Extend `anchor_mo` so each anchor carries a document label (title, DOI or URL) and can be looked up by hash, not only "latest". This needs a migration-aware change (see the `migrating-motoko-actors` ICP skill).
2. Deploy `anchor_mo` to mainnet with the `ia-mainnet` identity, which has ~2.2T spare cycles. Restrict `storeRoot` to the owner's principal.
3. Anchor the first publications with `py_client`.
4. Add a **Publications** page listing each document with its fingerprint, anchor date and a "verify" link.
5. Add a **verify** page: the visitor drops a file, the browser hashes it locally with WebCrypto (the file never leaves their machine), and the page queries the canister.
   - This needs a JS agent and a CSP change: add `connect-src 'self' https://icp-api.io` in `public/_headers`.
6. Optional: a hash-based live provenance checker for any dataset, the broader version of the same page.

## Smaller ideas

- Add an ORCID iD link beside GitHub (About and Research pages, footer) once the ORCID record is filled in.
- Sitemap (`@astrojs/sitemap`), `robots.txt`, and an RSS feed for Notes.
- Projects pages: Colophon, archaeology droid, provenance anchor.
- Canister-backed contact form (low priority while `mailto:` works).
- Internet Identity client area for sharing reports (when clients need it).
