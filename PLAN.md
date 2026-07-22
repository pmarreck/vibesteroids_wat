# Plan

This file tracks active work plus the most recent green milestones. Earlier
implementation history remains recoverable in Git through commit `8df6b11`.

## Active work

- [ ] Finish the two visually gated deep-review improvements.
	- [x] Create an inspectable Help/power-up HUD concept sheet at honest gameplay
	  scale. (2026-07-21 22:48 EDT)
	- [ ] Receive Peter's approval or requested revisions for the two-column Help
	  layout and `LASER`/`RAPID` countdown badges.
	- [ ] TDD the approved production geometry, copy, deterministic timer display,
	  and mechanical visibility assertions.
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
	- [ ] Receive Peter's visual approval or requested revisions before encoding
	  production drawing or visual assertions.
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
	- [x] Replace opaque lifecycle/input flag masks with named operations and a
	  structural regression guard.
	- [x] Hoist swept bullet segments/AABB rejection and replace per-tick projectile
	  square roots with schema-9 precomputed lifetimes; the compilation-heavy WAST
	  mean moved from 243.6 ms to 222.1 ms across matched 20-run samples.
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
