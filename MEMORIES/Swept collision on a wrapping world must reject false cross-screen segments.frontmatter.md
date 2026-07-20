---
description: "Swept collision on a wrapping world must reject false cross-screen segments."
datetime: 2026-07-20T14:03:56-04:00 # America/New_York (EDT)
tags: [collision-detection, swept-collision, tunneling, toroidal-world, wrapping, fixed-point, wat, wasm, webassembly]
---
Reconstructing a projectile's prior endpoint as `current - velocity_per_tick`
works until the current endpoint has wrapped to the opposite side of a
toroidal viewport. The reconstructed point then falls outside the expanded
viewport and a naive segment test can falsely strike anything between the two
screen edges.

For Vibesteroids, classify such reconstructed endpoints against the same
expanded bounds used by bullet wrapping. Use finite swept segment–circle
collision only when the prior endpoint remains in bounds; on a wrap tick (or
zero-length segment), retain point sampling at the visible endpoint. A future
fully toroidal sweep can instead split the motion into two boundary segments.
