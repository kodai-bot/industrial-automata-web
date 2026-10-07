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

## Accept ICP payments

The audience for technical work is likely to include people already on the IC or holding crypto. Regular clients will pay by bank transfer, so crypto is an extra option, not a replacement.

**1. Simple: done 2026-10-07.** The Contact page shows the IA_Account ICP account identifier with a build-time QR code (ICP only). Remaining: add a ckUSDC/ckBTC ICRC-1 address if wanted (check whether NNS offers ckUSDC on IA_Account or only the main account).

Original notes:
- Add a "Pay with ICP" section to the Contact page with a receiving address and a QR code, generated at build time as a static SVG/PNG to keep the CSP strict.
- Use a **dedicated receiving account** (e.g. a separate NNS account), not the `ia-mainnet` identity that controls the website canister. That keeps payments, accounting and site control apart.
- The same principal can receive **ckUSDC** (stable, better for invoices) and **ckBTC**. Say which tokens are accepted.
- Accounting: crypto received is income at its euro value on the day it arrives. Keep a simple record (date, amount, token, EUR value, invoice).

**2. Advanced (only if crypto payments become regular):**
- A small Motoko canister that issues one **subaccount per invoice**, watches the ledger for payment and marks invoices paid, giving automatic reconciliation with no processor fees.
- Reference: the `icrc-ledger` ICP skill (ICRC-1/2 transfers and balances, ICP/ckBTC/ckUSDC ledgers).

## Sideline: simple websites on the IC for clients

The same stack (Astro + `@dfinity/static-site` + custom domain) costs roughly €10 of cycles for 2–3 years of hosting, against commercial hosts that charge extra for forms, plugins and payments. It's an offering for small businesses, clubs and sole traders that need a simple, fast, secure contact or brochure site.

**Things to decide before offering it:**
- **Template:** factor this repo into a reusable starter (tokens in `global.css`, details in `site.ts`, Markdown pages), with a per-client copy.
- **Ownership and control:** the client owns their domain. The canister can have **two controllers** (client's identity and ours), so the client is never locked in, in line with Universal Maintenance Design.
- **Cycles:** who tops up, and how. Options: a yearly care fee that includes top-ups, or a handover with a written top-up guide. Monitor balances (`icp canister status`) for all client canisters.
- **Content updates:** clients edit Markdown via GitHub, or send changes for a small fee.
- **DNS:** each client domain needs the three records per hostname (see the README's "Going live" section) and Cloudflare's Universal SSL off.
- **Forms:** keep `mailto:` by default. A canister-backed form is an optional extra.
- **Pricing:** a setup fee plus an optional care plan. The hosting cost itself is negligible.

## Smaller ideas

- Add an ORCID iD link beside GitHub (About and Research pages, footer) once the ORCID record is filled in.
- Sitemap (`@astrojs/sitemap`), `robots.txt`, and an RSS feed for Notes.
- Projects pages: Colophon, archaeology droid, provenance anchor.
- Canister-backed contact form (low priority while `mailto:` works).
- Internet Identity client area for sharing reports (when clients need it).
