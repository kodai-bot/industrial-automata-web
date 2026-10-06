---
title: "Case study: Colophon, a point-of-sale system for a small bookshop"
date: 2026-10-02
description: A zero-cost Linux point-of-sale system for a volunteer-run bookshop, built with the staff who use it and designed so a non-technician can recover it.
---

**The problem.** A small, volunteer-run bookshop in Ireland recorded stock and sales with pen and paper. It sells a handful of items a day and has no IT budget. Subscription POS products cost too much for that volume, and open-source alternatives assume someone to administer a web server and database.

**What we built.** [Colophon](https://github.com/kodai-bot/colophon), an open-source (AGPL-3.0) point-of-sale system: a single Python program with a terminal interface. It runs on a Linux laptop the shop already owned.
- A USB barcode scanner reads ISBNs and in-house codes into a local SQLite catalog.
- A thermal receipt printer prints receipts and opens the cash drawer.
- Every night, cron writes CSV reports to the office share and takes a backup.
- Card payments stay on a separate standalone reader.

There is no cloud account and no subscription, and the shop's data stays on its own machines.

**Designed to be maintained, not just to work.**
- *A manual floor.* The daily CSV reports mean the shop can always fall back to a spreadsheet. The printer and drawer are enhancements, so neither is needed to take a sale.
- *Tolerant of failure.* If the network share is down, reports go to a local folder. The nightly backup is safe while the app is running, and a down NAS can't hang the machine at boot.
- *History kept, not overwritten.* Voids and price changes keep an audit trail.
- *Fix what the evidence supports.* Larger schema changes proposed in review were deferred until real problems justify them.
- *Recoverable by a non-technician.* A written recovery order, plain documentation, and a handover rule that records where secrets are kept, never what they are.

**Built with the people who use it.** Staff who had never seen the system used it on real trading days. Problems they reported were fixed by a coding agent on the shop laptop before the next shift. This is the human and AI team working in practice, and it's why the interface matches how the counter actually works.

**Next.** The same software will move unchanged to a dedicated Linux mini PC with a touchscreen, set up as an appliance:
- it starts on boot and restarts itself;
- it powers back on after a power cut;
- it can be repaired remotely.

It will run alongside the laptop for a few days before the old till is retired.

The code is public, so you can [read it on GitHub](https://github.com/kodai-bot/colophon).
