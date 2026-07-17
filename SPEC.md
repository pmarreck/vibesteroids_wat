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

The application implements `gpui-frontplane-v0` from Mecha Aedicule:

~~~text
fp_abi_major() -> 0
fp_abi_minor() -> 0
fp_configure()
fp_init(seed_lo, seed_hi, viewport_w, viewport_h)
fp_event(kind, code, a, b)
fp_tick(ticks)
fp_tick_hz() -> 60
fp_render()
fp_state_ptr()
fp_state_len()
fp_state_schema() -> 4
~~~

Schema 4 is 8192 bytes. The behavior specification documents the address map.
All mutable seeded values required for replay live inside that region. Render
does not mutate it.

Any layout or semantic change incompatible with the existing 8192-byte snapshot
increments the schema, even if byte length remains equal. Compatible code-only
tuning retains schema 4 so a live reload preserves the current game.

## 4. Numeric and timing model

Every internal dimensional value uses signed decimal fixed-point integers with
scale 1,000,000. Positions are logical pixels, velocity is logical pixels per
second, acceleration is logical pixels per second squared, and angles/angular
velocity use canonical per-second units. Named helpers alone integrate by the
declared tick rate or convert authored 60-Hz durations.

The only guest `f32` arithmetic is inside one mechanically marked adapter that:

1. converts viewport/event host scalars into decimal-fixed integers on ingress;
2. converts completed drawing scalars to ABI `f32` on egress; and
3. never stores a float in the snapshot or uses it in gameplay decisions.

The structural classifier rejects float loads/stores everywhere and arithmetic
outside that adapter. Collision squares rescale operands before multiplication
to remain within `i64` while preserving useful precision.

The packaged preferred rate remains 60 Hz. Before selecting 120 Hz, equal seed,
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

The game starts with a seeded ship, starfield, lives, score zero, level one, and
the opening rock wave. Fixed ticks advance only when not paused or game-over,
except for deliberately specified presentation/lifecycle timers.

Physical-key mapping is guest-owned:

~~~text
Left/Right  rotate
Up          thrust
Space       fire
F           toggle auto-fire
K           toggle Kid Mode
B           Death Blossom when available
P/Escape    pause
H/F1        help or controls
R           new game
~~~

Key-up stops held actions. Focus loss clears all held controls. New Game resets
from the configured seed. Help and pause must not corrupt input state.

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
mode. Bullets inherit relevant ship motion, expire after their authored
lifetime, wrap or terminate according to the documented rule, and resolve each
hit once.

The semi-secret Death Blossom is once per life when available. It emits a
radial burst with its own audiovisual sequence and cannot silently exceed pool,
fuel, or command budgets.

### 6.3 Rocks and progression

Rocks are seeded irregular polygons with deterministic vertex counts, rotation,
position, velocity, and wraparound. Hits score by size. Larger rocks split into
children whose directions and speeds become wilder with level while respecting
the level-scaled maximum speed. Completing a wave advances level, raises the
difficulty envelope, and spawns the next bounded wave.

### 6.4 Presentation and audio

The scene fills the drawable window. Resize regenerates the deterministic
starfield and translates all world objects by `new_center - old_center`,
preserving trajectories rather than stretching them.

The HUD clearly exposes score, level, lives, mode/status, help, and game over.
The WAT declares composable shot, thrust, explosion, extra-life, and Death
Blossom synth programs. The host knows only generic program IDs and oscillator
parameters.

## 7. Determinism and limits

Given the same seed and ordered input/tick stream, state bytes, rendered command
frames, audio/effect emissions, and wave progression are deterministic.

Pools are fixed and bounded: up to 32 rocks, 64 bullets, 150 particles, and four
ship-debris pieces in the current schema. Saturation follows an explicit
application rule and must not trap, grow memory, or exceed host output budgets.

Long headless simulations divide work across calls so Mecha Aedicule can refuel
each deterministic invocation without relaxing the per-call containment policy.

## 8. Test model

The production WAT has no test-only exports. `tests/run-wast` creates a suite in
RAM from:

1. `tests/wast/host-v0.wast`, an instrumented generic host;
2. the exact production `code.wat`;
3. a registration directive; and
4. application behavior and gameplay scenarios.

Stock `wasmtime wast` executes it. Scenarios cover schema/configuration, seed
ranges, rendering intent, controls, fixed-point behavior, firing, collision,
splitting, score, lives, waves, difficulty, resize, audio, effects, and
lifecycle. Structural lint independently enforces the float boundary.

Repository classifiers operate over complete forbidden-path and required-tool
sets. The Nix composition classifier proves that application, frontplane, and
default are distinct derivations and that the wrapper depends on both.

## 9. Packaging and development

The flake pins `github:pmarreck/aedicule/yolo` to an immutable commit in
`flake.lock` and follows the same nixpkgs input.

`packages.application` copies only `code.wat` into a data artifact.
`packages.frontplane` aliases the pinned dependency. `packages.default` creates
game-named launch and render wrappers and points them at the packaged WAT.

Ordinary game changes should use:

~~~text
./test
./build
./run
~~~

For live source editing, run the frontplane with `--watch code.wat`. For
frontplane co-development, use a command-line `--override-input` to an adjacent
checkout; never commit a path input.

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
- touch/shake parity without a native input design;
- changing to 120 Hz before equivalence tests and visual approval; or
- claiming a production-ready game or stable frontplane ABI.
