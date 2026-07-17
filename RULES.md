# Rules

1. Game state, behavior, input meaning, rendering intent, menus, audio programs,
   and effects live in `code.wat`, never in Mecha Aedicule's Rust host.
2. This repository contains no Rust, GPUI implementation, Wasmtime host, or
   frontplane behavioral tests; `tests/cli/repository_boundary` enforces this.
3. Observable game rules are specified in companion standard WAST and executed
   with stock Wasmtime. Do not add test-only exports to production WAT.
4. Internal simulation and state use signed decimal fixed point. Float
   operations are forbidden outside the single marked host-scalar adapter.
5. Determinism depends only on seed and ordered input/tick events. Rendering
   must not mutate simulation state.
6. Fixed-capacity pools and bounded loops must stay within Mecha Aedicule's fuel
   and output limits at their maximum occupancy.
7. Increment `AE_state_schema` whenever an equal-length state layout or meaning
   becomes incompatible with a live snapshot.
8. Dimensional quantities are authored in canonical per-second units; only
   named integration/duration helpers know the fixed tick rate.
9. The flake pins Mecha Aedicule. Local overrides are development conveniences,
   not committed CI inputs.
10. `packages.application` remains a data-only WAT derivation. The default
    package composes it with `packages.frontplane` only through wrappers.
11. `./test` is the complete deterministic suite and must run clean in the pure
    flake environment. `./build` is the optimized reproducible package path.
12. Fidelity changes and deliberate deviations are recorded in
    `FIDELITY_GAP_MATRIX.md`; gameplay additions need a falsifiable playtest
    hypothesis rather than feature enthusiasm alone.
13. The demo does not require localization while its UI and ABI remain a POC.
