# Plan

- [x] Derive a source-specific behavior and algorithm specification from the
  original Vibesteroids. (2026-07-16 EDT)
  - Curiosity poke: which quirks are deliberate game feel and which are browser
    accommodations or historical accidents?
- [x] Replace the minimal demonstration with score/lives/levels, irregular
  rocks, splitting, bullets, particles, debris, respawn, and progression.
  (2026-07-16 EDT)
  - Curiosity poke: which fixed-capacity limits become visible during extreme
    Death Blossom and fragmentation overlap?
- [x] Move gameplay arithmetic to signed decimal fixed point and seal float
  conversion at the host boundary. (2026-07-16 EDT)
  - Curiosity poke: which squared-distance calculations need explicit rescaling
    to retain precision without overflowing `i64`?
- [x] Move every game behavior oracle to standard WAST and retain structural
  WAT checks only for properties WAST cannot observe. (2026-07-17 EDT)
  - Curiosity poke: which examples need an independent metamorphic control in
    addition to source-derived expectations?
- [x] Separate Vibesteroids from Mecha Aedicule with preserved history, a
  pinned flake input, a data-only WAT derivation, and a composed wrapper.
  (2026-07-17 EDT)
  - Curiosity poke: can local input overrides remain ergonomic without leaking
    an impure adjacent checkout into CI?
- [x] Publish the public game repository, now canonical at
  `pmarreck/vibesteroids_wat`.
  (2026-07-17 08:38 EDT: history-preserving `yolo` push and default branch
  independently verified; CI observation remains part of the ship gate)
  - Curiosity poke: does a cold GitHub runner substitute the frontplane or spend
    most of its budget rebuilding the GPUI closure?
- [x] Normalize the project/repository/path identifier to `vibesteroids_wat`,
  retain hyphens for `vibesteroids-wat` commands, and enforce the distinction.
  (2026-07-17 09:06 EDT: red/green set classifier, canonical GitHub rename,
  locked `aedicule` input, complete suite/build, and packaged SVG smoke test)
  - Curiosity poke: should the wrapper eventually provide its own product-level
    `--about` text while delegating every other option to the generic host?
- [ ] Replace the one-wake/one-tick native loop with Mecha Aedicule's injected
  monotonic accumulator, then prove equal elapsed-time behavior at 60 and 120
  Hz in WAST before changing this game's preferred rate.
  - Curiosity poke: which collision differences are desirable reduced tunneling
    and which are unintended difficulty changes?
- [ ] Perform Peter-guided playtests of the highest-priority findings in
  `GAMEPLAY_DESIGN_RESEARCH.md`, one falsifiable experiment at a time.
  - Curiosity poke: which change improves repeated voluntary play rather than
    merely making the feature list longer?
- [ ] Revisit sound texture, visual polish, and input feel against the original
  game after the architectural split is stable.
  - Curiosity poke: can source fidelity and a stronger native presentation be
    evaluated independently?
