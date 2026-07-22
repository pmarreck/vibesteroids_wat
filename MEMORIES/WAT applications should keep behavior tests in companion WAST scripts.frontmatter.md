---
description: "WAT applications should keep behavior tests in companion WAST scripts."
datetime: 2026-07-17T08:06:07-04:00 # America/New_York (EDT)
tags: [wat, wasm, webassembly, applications, behavior, tests, test, testing, companion, wast, scripts]
---
Standard WebAssembly Script is the native executable specification layer for a
directly authored WAT application. Compose the unchanged production module
with a deterministic WAST host module, register both under their ABI names,
and let probe modules import the public guest exports and memory. This keeps
game state offsets, mechanics, render intent, and effects out of Rust without
adding test-only exports to production WAT or inventing a custom test runner.

Language ownership is not the same as test independence. Rust still owns
generic frontplane validation and independent metamorphic controls such as
render purity, replay, scheduling, containment, and transactionality. WAST
cannot inspect source text, so structural rules such as forbidding float
opcodes outside a marked adapter require a separate source lint rather than a
fake behavioral assertion.
