---
description: "WAT subtraction negates a value only when zero is pushed before it."
datetime: 2026-07-17T08:06:07-04:00 # America/New_York (EDT)
tags: [wat, wasm, webassembly, subtraction, negates, value, when, zero, pushed]
---
WebAssembly text uses stack operand order for noncommutative operations: the
left-hand operand must be pushed before the right-hand operand. To negate
`value`, emit `i64.const 0`, then `value`, then `i64.sub`; emitting `value`,
then zero, computes `value - 0` and silently preserves the wrong sign.

The Vibesteroids thruster exposed this visually when its animated flame length
was drawn through the ship's nose. Keep the regression in local ship space:
with the hull tail at x=-10, the distinct flame tip must have x < -10. This
proves the semantic geometry independently of heading and GPUI's float-only
projection boundary.
