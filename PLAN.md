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
- [x] Hard-cut the application and WAST harness to Aedicule's `aedicule.v0`
  import module and `AE_*` host/import lifecycle namespace.
  (2026-07-17 13:04 EDT: red/green set classifier, production WAT/WAST
  migration, companion host rename, contract documentation, complete test, and
  optimized package build)
  - Curiosity poke: can a set-based classifier make accidental mixed old/new
    ABI surfaces mechanically impossible during the cross-repository cutover?
- [x] Specify rational display-refresh events and simulation-rate selection in
  WAST, including 60, 120, 60000/1001, and 120000/1001 equal-time coverage.
  (2026-07-17 13:04 EDT: red/green selector/follow fixtures and RAM-generated
  production WAT matrix; actual `(0,0)` host adoption remains Aedicule-owned)
  - Curiosity poke: do exact-boundary inputs and non-integral tick durations
    preserve the same lifecycle thresholds without rounding drift?
- [x] Reconcile the game contract and WAST lifecycle proof with Aedicule's
  generated WAT ABI reference.
  (2026-07-18 01:32 EDT: self-contained ABI contract classifier, production
  lifecycle WAST proof, and corrected 16,384-byte schema documentation)
  - Curiosity poke: can a self-contained application check catch ABI/document
    drift without coupling CI to an uncommitted sibling checkout?
- [x] Add a classic disc-shaped enemy ship with deterministic 60--180 second
  scheduling, bidirectional traversal, predictive/random/defensive fire,
  asteroid and player collisions, and a 2,000-point player kill award.
  (2026-07-18 20:07 EDT: fixed-point interception, threat-priority targeting,
  finite hostile shots, collision/score lifecycle, rendering, full test/build)
  - Curiosity poke: can iterative fixed-point interception remain accurate
    when source, target, and projectile all have different world velocities?
- [x] Add a drifting package on the same independent 60--180 second schedule
  that grants 20 seconds of finite, non-wrapping, multi-target laser fire.
  (2026-07-18 20:19 EDT: drift/collection lifecycle, clipped piercing beam,
  split-child snapshot, UFO bounty, vector presentation, descending synth,
  full test/build)
  - Curiosity poke: should one beam resolve only the asteroids present when it
    fired, preventing freshly split children from being recursively erased?
- [ ] Playtest UFO pressure, package readability, laser power, and the
  synthesized descending-sweep laser timbre with Peter.
  - Curiosity poke: are the long randomized spawn windows fun in ordinary
    sessions, or should a test/demo override be exposed later by Aedicule?
- [x] Make the application launcher independent of the caller's working
  directory and correct the adjacent-Aedicule development instructions.
  (2026-07-19 11:44 EDT: foreign-cwd red/green CLI proof, root-qualified
  application flake, Aedicule fix `0af1575`, direct sibling invocation
  verification, complete suite/build)
  - Curiosity poke: do every repository-level convenience script and its
    documented sibling invocation resolve paths from the script itself?
- [x] Gate `code.wat` through the locked Aedicule runtime in CI and repair the
  rejected laser synth declaration.
  (2026-07-20 10:06 EDT: reproduced the reported filter rejection through
  `gpui-wasm-render`, strengthened the WAST fake into a value classifier,
  introduced a safe swept-voice helper, and passed the complete suite/build)
  - Curiosity poke: which permissive WAST-host stubs should become ABI-value
    classifiers, even after the real-host integration gate is authoritative?
- [ ] Have Aedicule mirror initial-load and watched-candidate rejection details
  to stderr while retaining the in-window error and previous live plugin.
  - Curiosity poke: should a stable diagnostic prefix be Aedicule's public CLI
    contract, or should it additionally expose a structured diagnostic mode?
- [x] Add independently testable live-reload sounds for UFO arrival, package
  arrival, package collection, and package loss or projectile destruction.
  - [x] UFO arrival: two-pulse red-alert saw sweep. (2026-07-20 11:57 EDT)
  - [x] Package arrival: ascending two-note notification. (2026-07-20 12:00 EDT)
  - [x] Package collection: ascending major arpeggio. (2026-07-20 12:02 EDT)
  - [x] Unclaimed off-screen package: descending failure buzzer.
    (2026-07-20 12:05 EDT)
  - [x] Player bullets/lasers and UFO shots route through the failure cue.
    (2026-07-20 12:13 EDT)
  - Curiosity poke: can each short synthesized cue remain recognizable without
    masking firing, thrust, or collision sounds already in progress?
- [x] Increase per-level asteroid count, player projectile speed, and asteroid
  speed cap by a linear 20%; retain the bounded player fire-rate curve after
  live playtesting; escalate successive UFO visits; and shorten independent
  UFO/package appearance windows to 45--120 seconds.
  - [x] Shorten both independent schedules to 45--120 seconds and prove
    simultaneous appearances. (2026-07-20 12:22 EDT)
  - [x] Scale wave count, player projectile speed, and asteroid cap; restore the
    original fire cadence after Peter's level-23 playtest. (2026-07-20 12:29 EDT)
  - [x] Scale successive UFO radius, traversal, projectile speed, and fire rate
    while keeping enemy cadence below the player's. (2026-07-20 12:29 EDT)
  - Curiosity poke: which capped pool or minimum cooldown becomes the first
    difficulty ceiling during a long session?
- [x] Preserve physical UFO/asteroid collisions while making packages intangible
  to asteroids, destructible by either side's projectiles, and the UFO's priority
  over player/random aim after immediate asteroid defense.
  - [x] Player bullets destroy packages and trigger the failure cue.
    (2026-07-20 12:07 EDT)
  - [x] Player lasers destroy packages from their pre-fire target snapshot.
    (2026-07-20 12:10 EDT)
  - [x] UFO projectiles destroy packages. (2026-07-20 12:13 EDT)
  - [x] UFO targeting prioritizes an active package over player/random after
    immediate asteroid defense. (2026-07-20 12:16 EDT)
  - [x] Lock the existing package/asteroid intangibility into a regression proof.
    (2026-07-20 12:18 EDT)
  - Curiosity poke: should a laser resolve package membership from the same
    pre-fire snapshot that already protects newly split asteroid children?
- [ ] Add precise pointer aim and primary-fire in WAT; after Aedicule documents
  and emits secondary button ID 2, pin it and map secondary down/up to thrust.
  - Curiosity poke: should keyboard rotation temporarily override pointer aim,
    or should the most recent input modality own heading until the other moves?
- [ ] Add a snapshot-based, player-dangerous UFO blast with score attribution,
  a flickering orange expansion/contraction, one-frame high-contrast flash, and
  a layered explosion synth lasting at least 1.2 seconds.
  - Curiosity poke: can blast attribution stay correct when a scored parent rock
    splits while the same explosion is still resolving its original snapshot?
- [ ] Add an independently scheduled 45--120-second derelict satellite that can
  overlap UFOs/packages, pings faintly without an arrival cue, pulses visually,
  and detonates on player fire or physical collision.
  - Curiosity poke: does its blast radius create deliberate asteroid-grouping
    tactics without making accidental chain clears dominate ordinary play?
- [ ] Make each collected gift deterministically choose between 20 seconds of
  piercing lasers and 20 seconds of doubled bounded player fire rate.
  - Curiosity poke: what minimal visual distinction tells Peter which timed
    reward is active without introducing a localization-heavy status label?
- [ ] After Aedicule wires its injected monotonic accumulator into the live
  host, pin that revision and prove equal elapsed-time behavior at 60 and 120
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
