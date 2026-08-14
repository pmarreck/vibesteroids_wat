# Plan

This file tracks active work plus the most recent green milestones. Earlier
implementation history remains recoverable in Git through commit `8df6b11`.

## Active work

- [x] Generate the star field from the seeded PRNG. It was a pure function of
  the loop index, so every seed drew the identical sky, and both coordinates
  advanced by a fixed step, laying all one hundred stars on a diagonal lattice
  (90 of 99 consecutive pairs shared one horizontal step). (Peter, 2026-08-05;
  done 2026-08-05 12:15 EDT.)
- [x] Make `./build` produce the `.aed` alongside the application, since the
  package is the distributable. (Peter, 2026-08-05; done 2026-08-05 12:08 EDT.)
- [ ] Gate boot behind a Start Game button so the first interaction is always a
  completed tap, which is the only gesture iOS accepts to unlock Web Audio.
  Peter's decisions, 2026-08-05: show it at boot, after game over without
  overlapping the game-over indication, and as "Resume" after focus loss;
  asteroids drift behind it with no ship spawned; dismissal spawns the ship
  through the ordinary respawn-safety path; a button click or any key dismisses
  it on desktop.
	- [x] Focus loss needs nothing new from Aedicule; it already arrives as
	  `AE_event` kind 8 with code 0. Peter decided on 2026-08-05 that this
	  "Resume" gate freezes simulation until dismissal, preventing death while
	  the player is away. A distinct Resume bit now joins the existing modal
	  suspension mask, and the resuming input is consumed. Deterministic tests
	  cover freezing, semantic action selection, game-over restart, absent boot
	  ship, and raw-pointer rejection. (Done 2026-08-05 18:41 EDT; native-button
	  boundary revised 2026-08-11 12:32 EDT.)
	- [ ] Obtain Peter's live visual approval for Start, Resume, and the separated
	  game-over placement, then mark the gate tranche complete. First playtest
	  found that `START GAME` sits below vertical center and the button corners
	  are square, with no pressed-state feedback. Replace the canvas imitation
	  with Aedicule's real `AE_button_place_q16`, which already owns centering,
	  rounded styling, interaction feedback, accessibility, and gesture occlusion.
	  Blocked on a standalone action declaration because current button labels
	  come only from permanent `AE_menu_item` entries; requested via
	  `../aedicule/inbox/2026-08-05-from-vibesteroids_wat-standalone-button-actions.md`.
	  Peter explicitly authorized Aedicule to wire through a `gpui-component`
	  button control if the existing surface cannot meet this contract; do not
	  recreate platform button behavior in guest canvas code. Button action
	  declarations must never create menu items implicitly; menus remain a
	  separate, explicit declaration surface. (Peter, 2026-08-05 19:08 EDT.)
	  (Peter, 2026-08-05 19:00 EDT.)
	- [x] Pin Aedicule ABI v0.8 at final public commit
	  `0b28ef751ed0ab65d368c877ade035f4aa66d4fc`, superseding the two
	  earlier August 5 pins. TDD the standalone Start/Resume action declarations,
	  retained button placement, kind-7 activation, and removal of the provisional
	  canvas hit-testing/rendering. The complete suite and optimized build pass;
	  Peter's live visual approval remains the parent item's final gate before
	  committing. (Done 2026-08-11 12:32 EDT.)
	- Curiosity poke: keyboard dismissal must coexist with a host-owned button
	  without allowing stale pointer events or a hidden placed action to restart
	  the game twice.
- [x] Make `./run` prefer a live Aedicule checkout while retaining a reproducible
  pinned fallback. Resolve the project root from the script, honor
  `AEDICULE_REPOSITORY`, prefer executable `../aedicule/run`, otherwise run the
	  locked `#frontplane`, watch `code.wat`, pass extra arguments unchanged, cover
	  the classifier in CI, and reconcile `README.md`. Requested by
	  `ulam-flower-wat` on 2026-08-11. The complete suite and optimized build pass.
	  (Done 2026-08-11 12:32 EDT.)
	- Curiosity poke: an explicitly configured but invalid
	  `AEDICULE_REPOSITORY` must have deterministic fallback behavior and paths
	  containing spaces must survive argument forwarding.
- [x] Receive Aedicule's disposition for source-checkout web launches. The
  preferred sibling `../aedicule/run --web` compiled successfully on 2026-08-11
  but exited because its development environment did not expose the bundled Web
  runtime. This is host launcher packaging, so the live Vibesteroids review uses
  the exact pinned Nix frontplane meanwhile. Aedicule accepted ownership and a
  TDD fix contract; no fix SHA exists yet. (Disposition received 2026-08-11;
  processed 2026-08-12 18:36 EDT.)
- [ ] Implement Peter's approved multi-contact mobile improvement: an edge
  contact owns stroke rotation plus held fire while an independent center
  contact owns held thrust. Preserve keyboard/fine-pointer mappings, the
  original 20/60/20 zones, and the `4pi`-per-viewport-height stroke mapping.
  Registered motion kind 1 delivers Death Blossom; keep a visible touch
  fallback because silence is the denied/no-sensor signal. (Approved
  2026-08-13 12:58 EDT.)
	- [x] Send Aedicule the exact touch-contact, compatibility-suppression,
	  cancellation, capability, pause, and integration-proof requirements using
	  `llmsend`. (Done 2026-08-13 13:00 EDT.)
	- [x] Receive Aedicule's TDD disposition and final immutable green pin.
	  Aedicule accepted the complete ownership contract, then shipped raw-contact
	  delivery, AVP lifetime occlusion, compatibility-pointer suppression, real
	  Chromium proof, and ordered `--touch`/`--advance` timelines at
	  `5f68591`. (Accepted 2026-08-13; final pin received 2026-08-14.)
	- [x] RED/GREEN deterministic WAST coverage for center thrust, both edge
	  directions, edge-fire cadence, simultaneous and same-zone contacts,
	  independent end and cancel, bounded overflow and slot reuse, focus cleanup,
	  and unknown/duplicate contact safety. The first RED failed on absent edge
	  ownership; the second RED failed on the absent top-center pause classifier.
	  The composed WAST and complete `./test` suite are green. (Done 2026-08-13
	  13:09 EDT.)
	- [x] Implement a bounded guest contact table keyed by opaque page-local IDs;
	  IDs have no meaning and never survive end, cancel, focus loss, or restore.
	  A bounded fixed-point stroke rotation applies the original `4pi` mapping
	  without a floating-point gameplay path. (Done 2026-08-13 13:09 EDT.)
	- [x] Pin Aedicule `5f68591`, import and require
	  `AE_touch_interest(8, 0)`, declare ABI minor 10, update every WAST host,
	  and add a game-behavior actual-binary timeline gate. The oracle must assert
	  gameplay state/rendering across interleaved contacts and ticks, never mere
	  host event counts. The new gate failed with 14 behavioral errors against
	  the prior package, then passed against the source correction and final host
	  pin; the complete suite and optimized build pass. (Done 2026-08-14 13:33
	  EDT.)
	- [x] Peter live-tested Aedicule's staging-only opt-in shim on iPhone Safari
	  and reported "It works." This validates simultaneous mobile control on the
	  final host behavior but does not replace landing the guest source correction
	  or the repository-owned actual-binary gate. (2026-08-14 13:22 EDT.)
	- [ ] Commit and push the matching immutable source/package savepoint after
	  its complete suite and optimized build pass. Report source SHA, exact `.aed`
	  path/bytes/SHA-256, WAT SHA-256, Aedicule pin, and the still-open
	  Start/Resume visual-approval uncertainty to Aedicule.
	- [ ] Implement Aedicule's six guest-owned mobile refinements TDD-first:
		- [ ] Latch coarse-pointer mode from device-change bit 0 and raw touch;
		  pausing in that mode also opens Help.
		- [ ] Render touch-control help only in coarse/touch mode, within the
		  vertically bounded overlay.
		- [ ] Import/register `AE_motion_interest(1, 0, 0)` and route event
		  kind 16/code 1 through the existing Death Blossom eligibility gates.
		- [ ] Increase deterministic gift frequency by a bounded, documented amount.
		- [ ] Add a visible bow to the gift; Peter supplies final visual acceptance.
		- [ ] Defer saucer and satellite spawns when the candidate region overlaps
		  or will soon be crossed by any asteroid, with bounded retries.
	  Curiosity poke: coarse-mode state must not become a global "mobile" switch;
	  hybrid keyboard/pointer/touch ownership stays concurrent, and predictive
	  spawn safety must classify sets of trajectories without starvation.
	- [ ] Process the five authoritative Aedicule notes into `inbox/processed/`
	  after their contracts, supersessions, and required replies are reflected in
	  implementation and documentation. (Added 2026-08-14 13:22 EDT.)
	- Curiosity poke: ending one contact must not clear an action still owned by
	  another contact, and compatibility pointer echoes must never double-fire.
- [ ] Confirm Aedicule `1b4cde7` is CI-green, then pin it. Peter's playtest
  against `61f287f` is finished and the rebuild hold is lifted. The new pin
  supersedes `2ca03e5` and includes device-change delivery, the ghost-tap fix,
  gesture-end audio unlock, and ABI-v0.7 registered motion input.
- [x] Standing policy from Peter, 2026-08-05: Aedicule's demo manifest always
  tracks the latest demos, so send a new `.aed` pin pair after each tranche
  worth demoing rather than waiting to be asked. First pair sent for
  `df61ffe`. (2026-08-05 12:07 EDT.)
- [x] Key the hazardous blast extent off a viewport reference that leans toward
  the smaller dimension instead of the diagonal, which made blasts span too
  much of a tall phone. The projectile-range portion of the original change was
  later superseded by viewport-edge termination. (Peter, 2026-08-04 playtest;
  done 2026-08-04 21:45 EDT; proof retargeted 2026-08-05 17:27 EDT.)
	- [x] Metamorphic WAST proving equal-area viewports render equal peak blast
	  radii whatever their aspect ratio.
	- [x] Keep `$hazardous_blast_radius` recomputed because blasts are rare.
- [x] Replace cached projectile range and per-shot countdowns with Peter's rule:
  a player projectile persists until it hits or clears the viewport, and never
  wraps. (Done 2026-08-05 17:30 EDT.)
	- [x] Observe the old countdown and wrap oracles fail under edge termination,
	  then replace them with an exact 60-Hz-source/120-Hz-production boundary.
	- [x] Preserve swept collision and let an overlapping target claim a
	  zero-net-velocity shot before the inert-record guard retires it.
	- [x] Update the Death Blossom pool proof to account for all 130 shots still
	  being in flight before any can reach the nearest edge.
	- [x] Remove dead range/lifetime helpers and reconcile `SPEC.md` plus the
	  fidelity matrix.
	- [x] Pass the complete suite and optimized build.
	- Curiosity poke: a resize translates active projectiles with the world; an
	  immediately out-of-bounds translated shot should retire on the next tick.

- [ ] Add `W/A/D` keyboard aliases for thrust/rotate-left/rotate-right and make
  the Help overlay advertise both arrow and letter controls.
	- [x] Obtain documented stable physical-key IDs and a tested native/browser
	  delivery pin from Aedicule: W=`13`, A=`14`, D=`15`, delivered by pin
	  `baad5069…`. (2026-07-25 18:31 EDT)
	- [x] RED/GREEN independent thrust ownership so releasing `Up`, `W`, or
	  secondary-pointer thrust cannot cancel another source that remains held.
	  (2026-07-24 10:38 EDT)
	- [x] RED/GREEN WAST coverage proving each letter exactly aliases its arrow
	  action on down/up, takes heading authority consistently, and cannot create
	  a stuck held control across focus, pause, or reload boundaries. Rotation
	  gained per-direction arrow/letter source sets mirroring the thrust design;
	  the RED run failed on the very first W-down thrust assertion.
	  (2026-07-25 18:47 EDT)
	- [x] RED/GREEN the revised Help copy (`LEFT/A RIGHT/D`, `UP/W`) without
	  changing the approved two-column geometry. (2026-07-24 10:41 EDT)
	- [x] Document the aliases and source-ownership rule in `SPEC.md` and the
	  `README.md` controls table. (2026-07-25 18:49 EDT)
	- [ ] Pass the full suite, optimized build, real-host gate, and package.
	- Curiosity poke: pressing an arrow and its letter alias together must not
	  let releasing only one prematurely clear an action still held by the other.
- [ ] Restore audible Vibesteroids audio on Aedicule's web platform without
  adding guest-side browser behavior.
	- [x] Trace the host boundary: Aedicule's browser runtime discards every
	  synthesized `AE_audio` event, while its muted browser gate proves only that
	  one packaged-sample request reached JavaScript. (2026-07-24 10:25 EDT)
	- [x] Deliver the source evidence and MFIC-strengthened RED/GREEN proposal to
	  the Aedicule agent. (2026-07-24 10:25 EDT)
	- [x] Physically classify the browser paths: Peter heard Voyager's packaged
	  Greta sample while synthesized game audio remained silent, isolating the
	  live defect to `AE_audio`. (2026-07-24 10:37 EDT)
	- [x] Pin Aedicule `baad5069c3f7b5cf4dcbdf0b8ce539a0e9c42aeb` (explicit rev
	  override, not an unconstrained update; `original` stays `ref = yolo`). It
	  carries the web-synth repair `aab2bf6…`, W/A/D IDs `e8736f9…`, and the
	  browser mouse-chord/touch-focus fixes as ancestors. (2026-07-25 18:31 EDT)
	- [x] Adopt Aedicule's announced executable hard cutover, which the new pin
	  forced: `gpui-wasm`→`aedicule`, `gpui-wasm-render`→`aedicule-render`,
	  `GPUI_WASM_DEFAULT_PLUGIN`→`AEDICULE_DEFAULT_APPLICATION`. The pin turned
	  `tests/cli/aedicule_runtime` and `tests/cli/application_derivation_layout`
	  RED; six `flake.nix` lines plus one `README.md` line turned them GREEN.
	  New names verified against the built binaries, not just the inbox note.
	  (2026-07-25 18:33 EDT)
	- [x] Rerun the complete guest suite and optimized package build against the
	  pin: `./test` EXIT=0 with silent output, both formerly-RED checks
	  reconfirmed individually, `./build` EXIT=0. (2026-07-25 18:33 EDT)
	- [x] Adopt Aedicule's next tested pin
	  `73891e6da037552e731245971b74c4856df21b92` (2026-07-27, "Drop the untested
	  keystroke buffering from the gpui_web pin"), which carries the confirmed
	  iOS software-keyboard fix. SHA resolved against the repository before use.
	  `./test` EXIT=0 with zero failures, `./build` EXIT=0, and the executable
	  names carried over with no further cutover. (2026-08-02 11:22 EDT)
	- [ ] Deploy the exact `.aed` from the pinned host, then have Peter
	  physically verify an ordinary synthesized sound (shot is simplest); the
	  packaged Greta sample path stays as the already-green control.
	- [ ] Regenerate and re-pin `vibesteroids.aed` only AFTER the tranche is
	  committed and Aedicule greens `75697fe`. Aedicule's
	  `tests/cli/demo_snapshots` pins a (commit, sha256) pair, currently
	  `935740771883…` / `b22e5002…`, verified byte-identical to the July-22
	  archive; a hash generated from an uncommitted tree would cite a commit
	  that does not exist. Zstandard packaging and the 16px touch slop both
	  live in `75697fe`, whose `./test_browser` is red, so regenerating at
	  `73891e6` yields another Stored 1,401,454-byte archive
	  (`tests/main.wast` alone is 1,151,223 bytes, 82%).
	- Curiosity poke: a Web Audio source can be started yet still be silent or
	  disconnected, so acceptance must observe non-zero rendered/output PCM.
- [ ] Correct the two remaining HUD-layout discrepancies and add restrained
  thrust audio from Peter's live `.aed` playtest.
	- [x] TDD a Help panel whose computed bottom edge and final content baseline
	  stay inside the shortest supported viewport. (2026-07-23 13:42 EDT)
	- [x] TDD power-up mode/countdown text centered vertically in the approved HUD
	  badge geometry, including two-digit remaining time.
	  (2026-07-23 13:43 EDT)
	- [x] TDD a quiet low static-rumble thrust voice with a bounded lifecycle that
	  neither retriggers every tick nor continues after thrust ends.
	  (2026-07-23 13:50 EDT)
	- [x] Pass `./test`, optimized `./build`, the working-tree host runtime, and
	  launch the exact updated `.aed`. (2026-07-23 13:52 EDT)
	- [x] Preserve the power-up badge centering accepted in Peter's second live
	  playtest. (2026-07-23 14:07 EDT)
	- [x] Replace the rejected viewport-bottom Help sizing with a panel derived
	  from the final content baseline plus fixed padding.
	  (2026-07-23 14:10 EDT)
	- [x] Replace the rejected brown-noise/sine thrust layers with a
	  static-forward filtered-noise design informed by classic Asteroids'
	  discrete sound circuit. (2026-07-23 14:12 EDT)
	- [x] Repass every gate and launch the exact revised `.aed`.
	  (2026-07-23 14:15 EDT)
	- [x] TDD Pause as an event boundary: clear held controls on entry, reject
	  gameplay input, and retain unpause/native-command/resize/focus events.
	  (2026-07-23 14:29 EDT)
	- [x] Replace the rejected low-band thrust chatter with a single smoother
	  filtered-white-noise bed. (2026-07-23 14:31 EDT)
	- [x] Repass clean tests/build/runtime/package gates and launch the exact
	  Pause/thrust revision. (2026-07-23 14:33 EDT)
	- [ ] Receive Peter's visual/audio approval, then commit and push.
	- Curiosity poke: very short windows, timer-width changes, and overlapping
	  gameplay sounds must not make these fixes regress or become fatiguing.
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
  complete the approved multi-contact work item near the top of this plan.
	- [x] Receive the touch/device-flags runtime pin. `1b4cde7` supersedes the
	  earlier `2ca03e5`; Aedicule reported CI pending when it sent the pin on
	  2026-08-05, so confirm green before adopting it.
	- [x] Agree that guests discover concurrent input capabilities/modalities,
	  not an OS or global `mobile` mode, and deliver the host/guest ownership
	  proposal to Aedicule. (2026-07-24 09:05 EDT)
	- [x] Receive Aedicule's disposition accepting both the semantic-capability
	  event and the raw multi-contact ownership boundary; exact assignments and
	  immutable pin remain pending host RED/GREEN work. (2026-07-24 10:42 EDT)
	- [x] RED/GREEN deterministic WAST coverage is tracked by the primary
	  multi-contact work item above.
	- [ ] Trigger Death Blossom from registered Aedicule motion kind 1. The host
	  owns the 15 m/s² shake threshold and 1500 ms cooldown and emits event kind
	  16/code 1; keep a tap affordance for devices that deny motion permission.
	- [ ] Peter-playtest whether to retain the original top-center pause zone now
	  that Aedicule owns the registered pause lifecycle; do not assume general
	  mobile autofire, which the original explicitly disabled.
	- Curiosity poke: do touch end and cancel both clear every contact-owned action
	  before the next fixed tick, including when another contact remains active?
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
