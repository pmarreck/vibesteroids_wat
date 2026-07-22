# Plan

This file tracks active work plus the most recent green milestones. Earlier
implementation history remains recoverable in Git through commit `8df6b11`.

## Active work

- [x] Double the shared UFO/Voyager hazardous-blast radius so it supports the
  intended strategic multi-asteroid clear and remains genuinely dangerous.
	- [x] TDD a 240-pixel visual/damage radius, including asteroid/hull radii:
	  clustered rocks and a ship 240 pixels away are hit, while an asteroid just
	  beyond the expanded boundary survives. (2026-07-22 13:42 EDT)
	- [x] Keep player attribution unchanged: collateral rocks score only when the
	  player caused the originating UFO/Voyager explosion. (2026-07-22 13:42 EDT)
	- Curiosity poke: chain reactions between two hazardous foreign objects remain
	  a separate rule; a larger blast must not introduce them accidentally.
- [x] Play Peter's 1.381604-second Greta "How Dare You" digitized-audio clip
  one simulated second after player-attributed Voyager destruction.
	- [x] Inspect the untouched source asset: 13,172-byte MP3, 48 kHz stereo,
	  SHA-256 `084b45085a03def28987c6d3cf80907c88630b4573e65fa73d0b4cf6a4e5be53`.
	  (2026-07-22 12:23 EDT)
	- [x] Produce a RAM-only FFmpeg FLAC candidate preserving 48 kHz stereo and
	  1.381604-second duration: 56,711 bytes, SHA-256
	  `d8aa38ecf43e5933abd0d5738b3f2ae2e7b3a5885353b00b6790379b8107aa5c`.
	  (2026-07-22 12:30 EDT)
	- [x] Agree with Aedicule on one virtual-root layout runnable directly as a
	  directory or as a deterministic stored ZIP with the `.aed` extension;
	  `code.wat` is the entry point, `assets/` is the declared-asset namespace,
	  and `tests/` carries the portable WAST behavior suite.
	  (2026-07-22 12:48 EDT)
	- [x] TDD the source-directory layout and exact high-compression, 16-bit FLAC
	  bytes; keep the local asset uncommitted until Peter's working audition.
	  (2026-07-22 12:53 EDT)
	- [x] TDD a clean application derivation containing `code.wat`, the declared
	  asset, a generated portable `tests/main.wast`, `README.md`, and `LICENSE`,
	  without leaking
	  `.git`, inbox notes, memories, or CI-only worktree files.
	  The built directory runs its own WAST entry point cleanly without executing
	  packaged shell code. (2026-07-22 13:11 EDT)
	- [x] Pin Aedicule `d6028b396bca5b1777f894d97a0a5606f9ac7b76`
	  with its generic sampled-audio declarations, bounded FLAC decoding, native
	  playback, asset-aware headless renderer, and capturable diagnostics.
	  (2026-07-22 16:44 EDT)
	- [x] TDD schema-11 fixed-tick one-second deferred playback at 60, 120, and
	  NTSC-derived rational rates; arm it only for player-attributed destruction,
	  never asteroid collision. (2026-07-22 12:27 EDT)
	- [x] TDD the pinned host's digitized-audio declaration and exact packaged
	  asset bytes across direct-directory and `.aed` launch without changing the
	  guest-owned timing/attribution path. (2026-07-22 16:18 EDT)
	- [x] Prove the packaged guest runs through the pinned real Aedicule runtime;
	  Peter confirmed that the sampled quote plays successfully.
	  (2026-07-22 16:18 EDT)
	- [x] Make both the normal native wrapper and a first-class deterministic
	  `packages.aed` output carry the entire virtual application root; execute
	  the wrapper renderer and the archive's bundled WAST through the pinned
	  runtime. (2026-07-22 16:44 EDT)
	- Curiosity poke: should a second player-attributed reactor blast replace,
	  queue, or overlap a still-pending/playing quote if later gameplay permits
	  multiple derelicts at once?
- [x] Fix Peter's playtest finding that Help inputs/actions drift horizontally
  instead of matching the mockup's four explicit left-aligned columns.
	- [x] Reproduce centered combined rows with a failing fake-host alignment and
	  anchor classifier. (2026-07-22 00:50 EDT)
	- [x] Split inputs/actions into exact mockup columns and inspect the real SVG
	  frame. (2026-07-22 00:53 EDT)
	- [x] Obtain Peter's live approval for the four-column alignment.
	  (2026-07-22 11:39 EDT)
	- [x] TDD proportional vertical compaction inside the panel so every Help
	  element remains above the lower edge of a 600px-tall live viewport.
	  (2026-07-22 11:49 EDT)
	- Curiosity poke: do narrow viewports need a separate degradation layout once
	  the approved 1024×768 geometry is exact?
- [x] Replace Voyager's descending "sad trombone" sweep with a faint deep-space
  sonar ping while preserving its existing three-second repetition cadence.
	- [x] TDD one constant-pitch sine transient plus two diminishing delayed
	  reflections using Aedicule's existing composable-voice ABI.
	  (2026-07-22 11:49 EDT)
	- [x] Pass the complete `./test` suite and optimized `./build`.
	  (2026-07-22 11:50 EDT)
	- [x] Have Peter audition and approve the improved live result.
	  (2026-07-22 12:19 EDT)
	- Curiosity poke: does the echo remain audible without masking nearby threats
	  or turning the quiet derelict into a navigational alarm?
- [x] Finish the two visually gated deep-review improvements.
	- [x] Create an inspectable Help/power-up HUD concept sheet at honest gameplay
	  scale. (2026-07-21 22:48 EDT)
	- [x] Receive Peter's enthusiastic approval for the two-column Help layout and
	  `LASER`/`RAPID` countdown badges. (2026-07-22 00:03 EDT)
	- [x] TDD the approved production geometry, copy, deterministic timer display,
	  and mechanical visibility assertions. (2026-07-22 00:10 EDT)
	- Curiosity poke: can the countdown remain useful during intense play without
	  competing with score, lives, or incoming threats?
- [ ] Consume the Aedicule-owned deep-review ABI tranche after its agent sends a
  pushed, full-suite-green revision.
	- [x] Obtain explicit Aedicule ownership/disposition for generated synth
	  enum/range documentation, normative v0 budget/minor-version semantics, and
	  ordered headless `--event` injection. (2026-07-21 22:47 EDT)
	- [ ] Pin the tested Aedicule SHA and mirror its published synth constraints in
	  the self-contained fake host.
	- [ ] Drive initial, Help, pause, and menu-selected conditional frames through
	  the locked real renderer.
	- Curiosity poke: can one ordered event script exercise every conditional frame
	  without introducing application semantics into Aedicule?
- [ ] Add an independently scheduled 45--120-second derelict satellite that can
  overlap UFOs/packages, pings faintly without an arrival cue, pulses visually,
  and detonates on player fire or physical collision.
	- [x] Create a Voyager-derived SVG concept at inspection and honest gameplay
	  scales. (2026-07-21 19:17 EDT)
	- [x] Receive Peter's visual approval with three revisions: keep the bent boom
	  joined, render the craft about 33% smaller, and give it seeded slow rotation
	  in either direction. (2026-07-22 00:05 EDT)
	- [x] TDD the independent schedule, but defer each spawn while 15 or more
	  asteroids are active; do not impose the still-undecided once-per-level cap.
	  (2026-07-22 00:28 EDT)
	- [x] TDD the approved connected Voyager geometry, seeded spin, quiet phone-home
	  ping, glow pulse, collision/destruction rules, and attributed blast.
	  (2026-07-22 00:28 EDT)
	- [x] Pass the complete `./test` suite and optimized `./build` with schema 10.
	  (2026-07-22 00:30 EDT)
	- [x] Have Peter playtest and approve the live schema-10 release candidate.
	  (2026-07-22 12:19 EDT)
	- Curiosity poke: does its blast radius create deliberate asteroid-grouping
	  tactics without letting accidental chain clears dominate ordinary play?
- [ ] After Aedicule deploys touch `AE_event` kinds 11--14, pin that runtime and
  implement multi-contact left/right-zone and stroke-direction semantics using
  opaque, page-local contact IDs.
	- Curiosity poke: do touch end and cancel both clear every contact-owned action
	  before the next fixed tick?
- [ ] Peter-playtest UFO pressure, both gift outcomes, HUD readability, laser
  power, sound texture, and the highest-priority design experiments one at a
  time.
	- Curiosity poke: which change improves repeated voluntary play rather than
	  merely expanding the feature list?

## Deep-review resolution milestone

- [x] Resolve every application-owned nonvisual finding in `CODE_REVIEW.md`
  with isolated RED/GREEN or covered-refactor commits. (2026-07-21 22:48 EDT)
	- [x] Preserve persistent flags on focus loss; translate active blast centers;
	  correct i64 spawn oracles; and make the real-host gate portable.
	- [x] Enforce fake-host geometry, frame/path/transform lifecycle, and complete
	  stable-ID checks with independent accept/reject controls.
	- [x] Cover rational-rate timers, all toroidal sweep margins, and both foreign
	  actor entry edges as set classifiers.
	- [x] Retain actionable WAST diagnostics and eliminate duplicate CI/Nix work.
	- [x] Lock the full synth signature and isolate intent-named cue declarations.
	- [x] Replace raw scalar snapshot addresses and opaque lifecycle/input flag
	  masks with named globals/operations and structural regression guards.
	- [x] Hoist swept bullet segments/AABB rejection and replace per-tick projectile
	  square roots with schema-9 precomputed lifetimes; exact expiry is proved at
	  all four rational rates, and the compilation-heavy WAST mean moved from
	  243.6 ms to 222.1 ms across matched 20-run samples.
	- [x] Reconcile README, SPEC, and the fidelity ledger with current behavior.
	- Curiosity poke: which remaining cleanup would add an independent control or
	  measured maintenance win rather than churn?

## Recent green milestones

- [x] Pin Aedicule's title-bar pointer-occlusion fix and have Peter click-test
  Reload, New Game, Help, and Quit while gameplay pointer input remains active.
  (2026-07-21 19:12 EDT)
- [x] Switch production to deterministic 120/1 scheduling with equal-time WAST
  proof at 60, 120, 60000/1001, and 120000/1001 Hz. (2026-07-20 15:38 EDT)
- [x] Add rate-limited pointer aim, held primary fire, held secondary thrust,
  release/focus cleanup, and wheel Death Blossom. (2026-07-20 15:38 EDT)
- [x] Add player-dangerous, score-attributed UFO blasts and randomized 20-second
  laser/rapid-fire gifts with distinct semantic sounds. (2026-07-20 15:02 EDT)
