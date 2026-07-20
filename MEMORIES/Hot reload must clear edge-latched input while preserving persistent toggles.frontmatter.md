---
description: "Hot reload must clear edge-latched input while preserving persistent toggles."
datetime: 2026-07-20T12:39:00-04:00 # America/New_York (EDT)
tags: [hot-reload, state-migration, input, edge-events, snapshots, wat, wasm, webassembly]
---
State snapshots can be restored after a replacement occurs between an input's
down and up edges. Persisting held left, right, thrust, or fire bits can then
strand a control indefinitely because the new guest is not guaranteed to see
the matching release edge.

Use the post-restore lifecycle hook to clear edge-latched controls while
retaining deliberate persistent modes such as pause, autofire, accessibility
settings, and pointer target authority. Prove the distinction with one restore
test containing both categories; ordinary down/up tests do not expose the
migration boundary.
