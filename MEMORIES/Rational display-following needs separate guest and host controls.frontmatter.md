---
description: "Rational display following needs separate guest and host controls."
datetime: 2026-07-17T13:05:19-04:00 # America/New_York (EDT)
tags: [rational, display, gui, graphics, following, separate, guest, host, controls]
---
An application-owned WAST fixture can prove that a guest receives an exact
rational display-refresh event, records its payload, receives the prior
simulation rate in its selector, and returns an exact replacement or `(0, 0)`.
It cannot independently prove that the host interprets `(0, 0)` as adopting the
latest display rate without reimplementing the host's negotiation logic in the
test. Keep that adoption, event ordering, and accumulator behavior in Aedicule
runtime tests; retain guest-visible contract fixtures and equal-time game
behavior in this repository's WAST suite.

For rate matrices, compose RAM-only variants from the exact production WAT by
changing only explicit rate declarations. Drive a collision-free scenario with
fixed state setup, keep one distant rock so normal wave progression does not
enter the measurement, and account for whole ticks due at fractional rates.
This tests production integration without adding test-only exports or storing
generated modules.
