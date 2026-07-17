# Vibesteroids Aedicule

Vibesteroids Aedicule is the WAT-authored native conversion and extension of
Peter Marreck's original browser Vibesteroids. It is a real downstream
application of the separately versioned Mecha Aedicule GPUI frontplane.

This repository owns game state, simulation, controls, menus, rendering intent,
audio programs, behavior specifications, fidelity decisions, gameplay research,
and playtest work. It owns no Rust, GPUI adapter, Wasmtime host, or native audio
implementation.

The flake pins Mecha Aedicule, packages `code.wat` independently, and composes
them only in a launch wrapper. This keeps WAT edits fast and prevents game/host
concern blending.

**Status:** playable enhanced proof of concept.

**Main branch:** yolo

## Terms

**Aedicule** — the native host/frontplane supplied by Mecha Aedicule.

**Application** — this repository's WAT game and its application-owned data.

**Behavior oracle** — the companion WAST scenarios specifying observable game
rules without duplicating those rules in Rust.

**Decimal fixed point** — signed integers scaled by one million for all
internal game quantities. Float conversion exists only at the host ABI edge.

**State schema** — the integer identifying the meaning of the opaque snapshot
layout. It changes when an equal-length layout or semantics become incompatible
with live restoration.

**Death Blossom** — the once-per-life semi-secret radial weapon activated with
`B` when available.
