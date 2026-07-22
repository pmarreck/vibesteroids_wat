---
description: "Decimal fixed point in WAT needs a sealed float adapter and rescaled collision squares."
datetime: 2026-07-17T08:06:07-04:00 # America/New_York (EDT)
tags: [decimal, fixed, point, wat, wasm, webassembly, sealed, float, adapter, rescaled, collision, squares]
---
Schema 3 migrated every gameplay scalar in Vibesteroids from IEEE-754 values
to signed `i64` decimal millionths (`SCALE = 1,000,000`). GPUI and the v0 ABI
still require `f32` viewport/draw scalars, so the WAT marks one mechanically
audited adapter region containing only `$from_host` and `$to_host`; a source
classifier rejects every non-constant `f32.*` operation and every float
load/store outside it. Converted host values never feed back into gameplay.

Directly squaring fixed-point coordinates can overflow `i64` at large
viewports. Collision comparisons divide coordinate deltas and radii by 1,000
before squaring. This retains 0.001-pixel resolution while keeping both terms
safe at an 8K viewport. Exact integer tests also prove the selected ship drag:
`2_500_000 * 995_000 / 1_000_000 == 2_487_500` after one tick.

The migration intentionally bumped snapshot schema once, from 2 to 3, so the
transactional live loader restarts instead of attempting to restore bytes from
the incompatible float layout.
