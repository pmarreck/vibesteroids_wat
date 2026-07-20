---
description: "Per-level fire-rate curves need endpoint playtests in discrete-tick games."
datetime: 2026-07-20T12:28:21-04:00 # America/New_York (EDT)
tags: [gameplay, difficulty, fire-rate, cadence, fixed-timestep, discrete-time, playtest, wat, wasm, webassembly]
---
A mathematically exact linear increase in firing rate is not perceptually linear
once converted into whole fixed-tick intervals. Applying +20% of baseline rate
per level reduced Vibesteroids from one shot per 16 ticks at level 1 to one per
4 ticks at level 20, which Peter immediately identified during a level-23 live
playtest as an unfun machine gun.

Test the low, middle, and capped difficulty endpoints as exact tick cadences,
then require a live high-level playtest before accepting a rate curve. Keep
temporary rapid-fire powerups separate from the ordinary progression curve so
their intensity is an explicit, time-bounded reward rather than permanent
late-game noise.
