---
layout: ../layouts/Page.astro
title: Research
lede: Archaeology as a signal problem, and machines that can help recover the past and be maintained for the long term.
description: Industrial Automata's research on archaeological signal reconstruction, technology as structured motion, robotic cognition and maintainable machines, including a peer-reviewed IEEE ISSC 2025 paper.
---

An archaeological site is a faint, degraded trace of past human activity. Recovering what happened from what survives is an *inverse problem*, the same kind of problem signal scientists solve with radio telescopes or medical scanners. Our research treats it that way, and builds the data systems and robotic tools to work on it.

## Published

> D. Foley and E. Furey, "From Geospatial Patterns to Ancient Signals: A Signal-Based Framework for Archaeological Machine Learning," *2025 35th Irish Signals and Systems Conference (ISSC)*, IEEE, 2025. [doi:10.1109/ISSC67739.2025.11291309](https://doi.org/10.1109/ISSC67739.2025.11291309)

The paper treats archaeological features as degraded spatiotemporal signals emitted by past human activity. Each site becomes a vector in a single signal field, with time anchored to a fixed astronomical reference frame (J2000).

Applied to northwest Ireland, the framework found significant alignments between clusters of archaeological sites and territorial boundaries recorded around 1600 CE, across a span of 6,000 years. Socio-political structure leaves a spatial imprint that persists even in noisy, incomplete data.

It builds on the MSc thesis *Unveiling the Past: Geospatial Techniques in Identifying Ancient Gaelic Territories* (Atlantic Technological University, 2024).

## Research strands

### Archaeological signal reconstruction

The published framework is being turned into working tools:
- a data pipeline that converts archaeological records into signals, with provenance recorded at every step;
- an explorer for navigating signals and the past entities inferred from them through space and time.

### Technology as structured motion

This strand develops a physical definition of technology: structured motion at the boundary between an organism and its environment, measured as change in force, distance and speed. On that basis it builds a theory of how technologies accumulate and become irreversible over human evolution. A paper testing the theory against the deep-time record of stone tools is currently in review.

### A cognitive architecture for physical agents

Because that definition of technology doesn't depend on what the agent is made of, it applies to robots as well as people. We are developing a robotic cognitive architecture built around the point of contact, where perception and action happen together. It includes a memory that stores experience in space and time, so a machine can generalise to devices it has never met rather than relying on a database of known models.

### An archaeological droid

A Raspberry Pi research platform where these ideas meet hardware. It combines sensor and position fusion, discovery of nearby networks and devices, signed status reporting, and machine-to-machine maintenance communication. It is an early prototype.

### Universal Maintenance Design

Hardware and software designed to be opened, repaired and interfaced with by people, robots and AI helpers alike, rather than sealed and replaced. See the [principles](/principles/).

### Provenance on the Internet Computer

Dataset fingerprints anchored on a public blockchain, so anyone can check that an archive hasn't changed since it was recorded. A prototype anchoring service is running in development, and this website is itself served with cryptographic certification from the Internet Computer.

## Collaboration

This is early-stage, independent research. If you work on archaeological data, signal processing, robotics or digital preservation and see an overlap, [get in touch](/contact/). Progress will appear in the [notes](/notes/).
