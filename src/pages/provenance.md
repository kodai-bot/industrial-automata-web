---
layout: ../layouts/Page.astro
title: Provenance
lede: Why this site runs on the Internet Computer, and what a ledger can and can't prove about a record.
description: Why Industrial Automata uses the Internet Computer, why verifiable records matter now that AI can fake documents and images, and the precise limits of what ledger-based provenance proves.
---

## Why this site is on the Internet Computer

This website is served from the Internet Computer, a public blockchain network that can host software and websites. We chose it for three reasons:

- **Low cost.** Hosting here is substantially cheaper than conventional web hosting.
- **No dependence on a mainstream provider.** The site doesn't sit on any one company's servers or terms of service.
- **A place to experiment.** The network certifies every response it serves, and it can record fingerprints of documents and datasets on a public ledger. We want to learn how well that works for authenticating real resources. The [launch note](/notes/site-launch/) explains how this site's own pages are certified.

## Why it matters

AI can now produce convincing fake documents, photographs and audio recordings cheaply. For archives, museums and archaeology, whose material is evidence about the past, that changes things. It is no longer enough for a record to look right. Increasingly it will need a verifiable history: where it came from, when, and whether it has changed since.

## What a ledger can and can't prove

It's worth being precise, because the limits matter as much as the strengths.

**What it proves.** A fingerprint (a cryptographic hash) of a record, written to a public ledger, proves that this exact record existed at that time and hasn't been altered since. Anyone with a copy can check it, without trusting us.

**What it can't prove.** It says nothing about whether the record was genuine when it was entered. A fake that is fingerprinted is still a fake, just a well-documented one.

**So the critical moment is capture.** The strongest evidence is created when a record is first made: the photograph taken, the measurement logged, the document scanned, with when, where, how and by whom recorded at that moment. It is the digital equivalent of recording an archaeological find in its context, in situ, before it is lifted. Once that moment has passed, nothing added later can fully restore what was lost.

## Where we're going

- **Anchoring our own publications.** A prototype service that records document fingerprints on the Internet Computer is running in development. Papers and case studies published here will be anchored so anyone can verify their copy.
- **Provenance from the point of capture.** Our [research](/research/) on field data capture is about recording observations with their context and provenance from the start, kept separate from later interpretation.
- **Open records, not gatekeepers.** The C2PA standard (Content Credentials) was developed by a coalition of large technology and media companies to attach signed provenance to images, video and documents. It answers a real need, and we'll stay compatible with it where that helps people check a record. It is also an example of large firms agreeing the ground on which they will then compete, with trust resting on certificates they issue and recognise. A public ledger already provides an independent, verifiable record of when something existed, and no single company controls it.

If your organisation needs records that can stand up to scrutiny, [get in touch](/contact/).
