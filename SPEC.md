# vibesteroids_wat application specification

## 1. Purpose

`vibesteroids_wat` is a native-window WAT conversion and extension of
Peter Marreck's original browser Vibesteroids. It is also the first substantial
downstream application for Mecha Aedicule.

This specification defines the application/frontplane boundary, state and
numeric policy, observable feature set, test ownership, packaging, and current
enhancement direction. Exact source-derived constants, algorithms, quirks, and
staged port details live in [VIBESTEROIDS_BEHAVIOR_SPEC.md](VIBESTEROIDS_BEHAVIOR_SPEC.md).
Implementation fidelity is tracked in [FIDELITY_GAP_MATRIX.md](FIDELITY_GAP_MATRIX.md).

## 2. Ownership boundary

`code.wat` owns:

- all persistent and transient game state;
- seeded randomness and object-pool allocation;
- input-to-action mapping and held-control state;
- simulation, collision, scoring, lives, waves, weapons, and difficulty;
- render commands and visible application copy;
- menus and application action IDs;
- synth program declarations and playback decisions;
- snapshot address, length, schema, and post-restore behavior; and
- fixed simulation rate declaration.

The pinned Mecha Aedicule input owns:

- WAT parsing and Wasmtime containment;
- native GPUI windowing, physical input, standard menus, and canvas painting;
- fixed-step scheduling from monotonic elapsed time;
- generated-audio synthesis and device output;
- finite command/resource/effect budgets;
- opaque snapshots and transactional live reload; and
- deterministic headless SVG serialization.

No game rule may migrate into Rust for convenience or performance without
Peter explicitly changing the experiment's premise.

## 3. Module and state contract

The application implements the hard-cutover `aedicule.v0` contract from Mecha
Aedicule:

~~~text
AE_abi_major() -> 0
AE_abi_minor() -> 8
AE_configure()
AE_init(seed_lo, seed_hi, viewport_w, viewport_h)
AE_event(kind, code, a, b)
AE_tick(ticks)
AE_tick_rate(current_numerator, current_denominator) -> (120, 1)
AE_render()
AE_state_ptr()
AE_state_len()
AE_state_schema() -> 11
~~~

Schema 11 is 32,768 bytes. The behavior specification documents the address map.
All mutable seeded values required for replay live inside that region. Render
does not mutate it.

Any layout or semantic change incompatible with the existing 32,768-byte snapshot
increments the schema, even if byte length remains equal. Compatible code-only
tuning retains schema 11 so a live reload preserves the current game.

## 4. Numeric and timing model

Every internal dimensional value uses signed decimal fixed-point integers with
scale 1,000,000. Positions are logical pixels, velocity is logical pixels per
second, acceleration is logical pixels per second squared, and angles/angular
velocity use canonical per-second units. Named helpers alone integrate by the
declared tick rate or convert authored 60-Hz durations.

Aedicule reports nominal display refresh with `AE_event` kind 9:
`code = refresh_numerator_hz` and `a = refresh_denominator`. A guest may return
`(0, 0)` from `AE_tick_rate` to follow that refresh, or an exact positive
rational simulation rate. Vibesteroids requests 120/1 independently of the
host display refresh.

The only guest `f32` arithmetic is inside one mechanically marked adapter that:

1. converts viewport/event host scalars into decimal-fixed integers on ingress;
2. converts completed drawing scalars to ABI `f32` on egress; and
3. never stores a float in the snapshot or uses it in gameplay decisions.

The structural classifier rejects float loads/stores everywhere and arithmetic
outside that adapter. Collision squares rescale operands before multiplication
to remain within `i64` while preserving useful precision.

The packaged preferred rate is 120 Hz. Equal seed,
equal simulated seconds, and an identical timestamped input script at both
rates must demonstrate:

- exact score, lives, level, flags, pool occupancy, and ordered effects outside
  intentionally collision-sensitive scenarios;
- bounded position, velocity, and facing differences stated by each WAST case;
- lifecycle boundaries within one 60-Hz tick; and
- explicit classification of each collision difference as reduced tunneling or
  regression.

No bulk recalculation of velocity constants is acceptable; rate independence is
the design being tested.

## 5. Game lifecycle and controls

The game starts behind a `START GAME` gate with a seeded starfield, lives, score
zero, level one, and the opening rock wave. The ship is absent while rocks drift
behind the gate. Aedicule presents a real native button from the guest's
standalone `START GAME` action. Its semantic action event, or any key-down, is
consumed and spawns the protected ship through the ordinary respawn path. The
same action appears below `GAME OVER` and begins a canonical fresh game.

Physical-key mapping is guest-owned:

~~~text
Left/A      rotate left
Right/D     rotate right
Up/W        thrust
Space       fire
F           toggle auto-fire
K           toggle Kid Mode
B           Death Blossom when available
P/Escape    pause
H/F1        help or controls
R           new game
~~~

Pointer mapping is also guest-owned. Motion updates a target point; the ship
turns toward it at the same bounded angular rate used by gameplay and snaps only
when another fixed step would overshoot. Holding the primary button fires,
holding the secondary button thrusts, and any delivered nonzero scroll gesture
activates Death Blossom when eligible. Button releases clear the corresponding
held state.

Motion-gesture mapping is guest-owned after host classification. Configuration
registers `AE_motion_interest(1, 0, 0)` and propagates a host rejection. Event
kind 16/code 1 routes through the ordinary Death Blossom eligibility function;
the host owns acceleration threshold, cooldown, permission, and event pacing.

Touch-contact mapping is also guest-owned and coexists with keyboard and fine
pointer input. ABI minor 10 requires the configure-time
`AE_touch_interest(8, 0)` opt-in; a rejection fails configuration instead of
silently restoring compatibility-pointer lowering. Event kinds 11 through 14
represent start, move, end, and cancel; their opaque IDs are compared only for
equality and live in an eight-record transient table outside the snapshot. A
contact's starting X selects its zone:
the outer 20% strips own held fire plus vertical-stroke heading, and the middle
60% owns held thrust. Stroke displacement maps linearly over `4pi` radians per
viewport height from the heading captured at contact start. Each terminal edge
releases only its matching owner, while focus loss, Pause, reset, and restore
clear the complete contact table. Duplicate starts, unknown moves/terminals,
and overflow starts are inert. The top-center 40--60% strip through logical Y
70 remains the guest pause toggle. Aedicule `5f68591` delivers the ordered raw
stream before fixed ticks, suppresses touch-derived compatibility pointers,
preserves real mouse input and AVP-owned contacts, and supplies the deterministic
actual-binary timeline used by this repository's runtime check.

Device-change code bit 0 latches coarse-primary-pointer mode, while any raw
touch start records observed touch use. Entering Pause in either mode also
opens Help with the touch zones and stroke grammar. Resume closes that overlay
only when Pause opened it; manually opened Help remains player-owned. Fine-only
desktop Pause retains the keyboard/pointer panel behavior.

Key-up stops held actions. Each physical source owns its action independently:
thrust is held by Up, W, or the secondary pointer button, and each rotation
direction is held by its arrow key or its letter alias. An action ends only when
its last held source releases, so letting go of one alias never cancels another
that is still down. Pressing a letter alias takes heading authority from pointer
aim exactly as its arrow does. Focus loss clears all held controls, raises a
`RESUME` gate, and freezes simulation until the host button's semantic action
or any key-down dismisses it. That resuming input is consumed. Entering Pause also
clears held gameplay controls; while paused, gameplay keys, pointer
motion/buttons, wheel, and player-mode toggles are ignored. Unpause, native
menu/button commands, resize, and focus housekeeping remain live. New Game
resets from the configured seed. Help, pause, Start, and Resume must not corrupt
input state. The guest never interprets raw canvas pointer edges as gate clicks;
Aedicule owns click completion, pressed feedback, occlusion, and accessibility.

## 6. Core behaviors

### 6.1 Ship

The ship rotates and accelerates along its facing direction. With no thrust,
velocity applies exact `0.995` drag per 60-Hz-equivalent integration step. The
thruster flame is authored in ship-local coordinates behind the hull at every
heading. World edges wrap.

Collision triggers explosion, debris, particles, life loss, a timed respawn,
and a safe-zone policy before control returns. Extra-life thresholds and game
over follow the source-derived specification.

### 6.2 Bullets and weapons

Manual fire respects cooldown and pool capacity. Auto-fire is an explicit game
mode. Bullets inherit relevant ship motion, resolve each swept hit once, never
wrap, and remain active until they hit something or clear the viewport. A
25-pixel margin lets the projectile graphic leave fully before retirement.

Extents that must scale with the window key off a single viewport reference:
the geometric mean of width and height, the side of the square with the same
area. The hazardous blast is 0.27 of that reference. The diagonal is
deliberately not used, because a portrait phone's diagonal is dominated by its
height and makes the blast span too much of the screen.

The semi-secret Death Blossom is once per life when available. It emits a
radial burst with its own audiovisual sequence and cannot silently exceed pool,
fuel, or command budgets.

### 6.3 Rocks and progression

Rocks are seeded irregular polygons with deterministic vertex counts, rotation,
position, velocity, and wraparound. Hits score by size. Larger rocks split into
children whose directions and speeds become wilder with level while respecting
the level-scaled maximum speed. Completing a wave advances level, raises the
difficulty envelope, and spawns the next bounded wave.

### 6.4 Enemy ship, random-power package, and derelict satellite

The game independently schedules one enemy saucer at uniformly selected
intervals from 45 through 120 simulated seconds and one collectible package
from 36 through 96 seconds. Both package endpoints and its mean wait are 20%
shorter than the former shared interval. A new
interval begins after the corresponding object leaves play, so neither feature
can overlap another instance of itself. All scheduling randomness is seeded and
snapshotted.

The disc-shaped saucer enters from either horizontal edge, crosses without
wrapping, and fires bounded projectiles. A rock in its forward threat corridor
takes priority; otherwise a seeded choice selects either a random bearing or a
fixed-point iterative intercept of the moving player. Enemy shots may destroy
rocks but never score. The saucer and player can each die from their mutual
collision or from rocks; player bullets and lasers destroy the saucer for 2,000
points. Every saucer destruction creates an immediate viewport-scaled snapshot
blast that can destroy nearby rocks; target radii extend that boundary, so the
player's 10-pixel hull is endangered ten pixels beyond it. Rocks score only when
the player caused the saucer destruction; contact-triggered blasts never
manufacture points. The 1.2-second presentation expands and contracts to the
same gameplay radius through the fixed clock, while damage is resolved once at
detonation so newly split children survive the parent blast.

Before a saucer becomes active, the guest classifies every asteroid's relative
trajectory over the next two simulated seconds. Current overlap or projected
intersection, including asteroid wraparound images and a ten-pixel fairness
margin, defers the proposal. A fresh candidate is drawn after one simulated
second, bounding retry work without eventually forcing an unsafe entry.

The package drifts across the viewport without wrapping and does not collide
with rocks. Player bullets, lasers, and enemy shots can destroy it; leaving the
screen or being shot emits the same failure cue. Player contact selects one of
two seeded rewards for 20 simulated seconds: laser fire or doubled bounded fire
rate. Collection emits its own success cue. Its vector parcel includes ribbon
crossbars, two attached bow loops, and a central knot.

A laser is a finite segment from the muzzle to the first viewport boundary: it
never wraps, tests all targets present when fired, and may destroy multiple
rocks without recursively targeting children created by that same beam. A
short cyan afterimage makes the otherwise instantaneous command visible.

A third independent 45--120-second schedule controls a derelict Voyager-like
satellite. A due appearance remains pending while 15 or more rocks are active,
then considers the same two-second asteroid-trajectory classifier and
one-second retry used by the saucer; no once-per-level limit exists.
It may overlap the saucer and package, crosses without wrapping, drifts and
rotates slowly in either seeded direction, and has no arrival cue. A faint
pitch-stable sonar ping with two diminishing delayed reflections starts after
1.5 simulated seconds and repeats every 3 seconds.

Player bullets and finite lasers rupture the satellite reactor. The resulting
hazardous blast shares the UFO blast radius and has no intrinsic bounty, but
clustered rocks caught in it score because the player caused the detonation.
Physical asteroid contact triggers the same blast with no score attribution.

Player-attributed destruction also arms a schema-backed one-simulated-second
countdown, after which the guest requests the packaged Greta "How Dare You"
sample at normal volume and pitch. Physical asteroid contact never arms that
quote. Paused/help-modal time does not advance the countdown.

### 6.5 Presentation and audio

The scene fills the drawable window. Resize regenerates the deterministic
starfield and translates all world objects by `new_center - old_center`,
preserving trajectories rather than stretching them.

The HUD clearly exposes score, level, lives, mode/status, help, and game over.
Start and Resume use a guest-declared retained Aedicule button backed by two
standalone actions that create no menu items. The host owns label centering,
rounded platform styling, pressed feedback, accessibility, and gesture
occlusion; game-over copy remains above its Start button without overlap.
While a timed gift is active, a text-plus-icon badge identifies `LASER` or
`RAPID` and displays the ceil-rounded remaining time in tenths; it disappears
at expiry. Help uses a filled two-column keyboard/pointer panel.
The WAT declares composable shot, thrust, explosion, extra-life, Death Blossom,
notification, and hazardous-blast synth programs. While thrust is held, a quiet
low-passed white-noise bed retriggers at a rate-independent cadence, then stops
requesting new voices on release. The hazardous blast layers three
maximum-volume 1.2--1.5-second voices beneath a flickering orange pulse and one
high-contrast background frame. Voyager adds a faint single-voice sine ping and
a pure fixed-phase 52--56-pixel cyan glow. Its connected damaged-boom silhouette
is approximately 136 by 47 logical pixels. The host knows only generic program
IDs and oscillator parameters.

## 7. Determinism and limits

Given the same seed and ordered input/tick stream, state bytes, rendered command
frames, audio/effect emissions, and wave progression are deterministic.

Pools are fixed and bounded: up to 32 rocks, 256 player bullets, 150 particles, and four
ship-debris pieces in the current schema. Saturation follows an explicit
application rule and must not trap, grow memory, or exceed host output budgets.

Long headless simulations divide work across calls so Mecha Aedicule can refuel
each deterministic invocation without relaxing the per-call containment policy.

## 8. Test model

The production WAT has no test-only exports. `tests/run-wast` creates a suite in
RAM from:

1. `tests/wast/aedicule-v0.wast`, an instrumented generic host;
2. the exact production `code.wat`;
3. a registration directive; and
4. application behavior and gameplay scenarios.

Stock `wasmtime wast` executes it. Intent comments state the behavior and
failure mode for each scenario group, including independent controls when a
single fixture could pass vacuously. Scenarios cover schema/configuration, seed
ranges, rendering intent, controls, fixed-point behavior, firing, collision,
splitting, score, lives, waves, difficulty, resize, audio, effects, and
lifecycle. Structural lint independently enforces the float boundary.

Repository classifiers operate over complete forbidden-path and required-tool
sets. The Nix composition classifier proves that application, frontplane, and
default are distinct derivations and that the wrapper depends on both.

## 9. Packaging and development

The flake pins `github:pmarreck/aedicule/yolo` to an immutable commit in
`flake.lock` and follows the same nixpkgs input.

`packages.application` constructs the bounded guest root containing `code.wat`,
its FLAC asset, documentation, and a self-contained `tests/main.wast`.
`packages.aed` deterministically packages that root as the portable guest
artifact. `packages.frontplane` aliases the pinned dependency, while
`packages.default` creates game-named launch and render wrappers pointing at
the complete application root so declared assets remain available.

Ordinary game changes should use:

~~~text
./test
./build
./run
~~~

`./run` watches `code.wat`, prefers an executable adjacent Aedicule checkout,
honors `AEDICULE_REPOSITORY`, and otherwise selects the locked
`packages.frontplane` output without writing the lock file. Build-time
frontplane experiments may still use command-line `--override-input`; never
commit a path input.

## 10. Gameplay enhancement policy

[GAMEPLAY_DESIGN_RESEARCH.md](GAMEPLAY_DESIGN_RESEARCH.md) records why classic
Asteroids and Blasteroids loops work and proposes falsifiable experiments.
Changes should preserve immediate control, legible threat, short recovery, and
clear scoring feedback. Add one hypothesis at a time, specify what observation
would reject it, and let Peter's repeated play decide.

The project is an enhanced conversion, not a cleanroom implementation and not a
feature landfill. Source-specific names and algorithms may be documented; new
mechanics still require scope discipline.

## 11. Current non-goals

- moving application logic into Rust;
- online multiplayer or service dependencies;
- unbounded entities or general ECS machinery;
- translation work during the POC;
- platform identity switches in place of concurrent input capabilities;
- claiming a production-ready game or stable frontplane ABI.
