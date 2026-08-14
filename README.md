# vibesteroids_wat

[![Proof of concept](https://img.shields.io/badge/status-playable_POC-f59e0b)](#status)
[![CI](https://github.com/pmarreck/vibesteroids_wat/actions/workflows/ci.yml/badge.svg?branch=yolo)](https://github.com/pmarreck/vibesteroids_wat/actions/workflows/ci.yml)
[![Mechatron Prime CI](https://img.shields.io/endpoint?url=https%3A%2F%2Fthelio-nixos.tail66c90.ts.net%2Fbadges%2Fvibesteroids_wat.json&style=for-the-badge)](https://thelio-nixos.tail66c90.ts.net/mechatron-prime/)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A WAT-authored, native-window conversion and extension of Peter Marreck's
original [Vibesteroids](https://github.com/pmarreck/vibesteroids), running on
the [Mecha Aedicule](https://github.com/pmarreck/aedicule) GPUI
frontplane.

The application brain is [code.wat](code.wat): simulation, fixed-point state,
input meaning, menus, rendering intent, synth declarations, score, waves,
weapons, and every game rule. This repository intentionally contains no Rust
or GPUI implementation. Its standard WAST suite owns the gameplay oracle;
Mecha Aedicule independently owns native capabilities and containment.

> [!IMPORTANT]
> This is a playable proof of concept, not a finished commercial game. Its
> purpose is both to be fun and to stress a clean WAT/native-host boundary.

## Why the repositories are separate

The GPUI/Zed Rust graph is large. Treating `code.wat` as native package source
would make every physics or tuning edit relink the frontplane and would invite
future agents to move game rules into Rust.

The flake therefore has four delivery outputs:

- `packages.frontplane`: the exact Mecha Aedicule input pinned in `flake.lock`;
- `packages.application`: the guest directory containing WAT, tests, and assets;
- `packages.aed`: the deterministic, directly shareable `vibesteroids.aed`;
- `packages.default`: a thin wrapper composing the two at launch.

Changing game code rebuilds and retests the small application artifact, not the
native frontplane. For adjacent development, override the committed input:

```console
nix build --override-input aedicule ../aedicule
```

CI remains reproducible because the ordinary build uses the locked Git commit.
A Mechatron Prime job may publish the expensive frontplane closure to Peter's
private Attic cache; downstream builds can then substitute it while still
testing fresh WAT locally.

## Play

With Nix flakes enabled:

```console
./test
./build
./run
```

The built result contains one composed game package:

```console
result/bin/vibesteroids-wat
result/bin/vibesteroids-wat-render
result/share/vibesteroids_wat/code.wat
result/share/vibesteroids_wat/assets/audio/satellite-destroyed.flac
```

Build the portable guest archive separately, then run or test it with any
compatible Aedicule delivery:

```console
nix build .#aed -o result-aed
result/bin/vibesteroids-wat result-aed/vibesteroids.aed
result/bin/vibesteroids-wat --test result-aed/vibesteroids.aed
```

Controls:

| Input | Action |
| --- | --- |
| Left / A | Rotate left |
| Right / D | Rotate right |
| Up / W | Thrust |
| Space | Fire bullets, or the temporary laser when powered up |
| F | Toggle auto-fire |
| K | Toggle Kid Mode |
| B | Activate the once-per-life Death Blossom |
| P / Escape | Pause |
| H / F1 | Help / Controls |
| R | New game |
| Ctrl+R | Reload watched WAT |
| Mouse movement | Aim toward the pointer at the ship's bounded rotation rate |
| Hold primary mouse button | Fire |
| Hold secondary mouse button | Thrust |
| Mouse wheel / trackpad scroll | Activate Death Blossom when available |
| Shake a motion-capable device | Activate Death Blossom when available |

New Game, Help / Controls, Reload, and Quit are also exposed through native
window actions.

The guest opts into Aedicule's ordered raw-contact stream for eight simultaneous
contacts. A left/right-edge contact fires and maps vertical motion over `4pi`
radians per viewport height. Independent middle contacts thrust, and lifting or
cancelling one finger leaves every other contact's action active. The top-center
touch zone retains pause/resume; pausing after coarse-pointer or raw-touch use
also opens the touch-specific Controls panel. Portrait viewports narrower than
720 logical pixels stack Touch below Keyboard; wider and landscape viewports
retain the compact side-by-side sections. WAST, an actual-binary touch/tick
timeline, and Peter's iPhone Safari playtest cover the mapping.

## Live-edit the running game

The application launcher watches the source `code.wat` automatically. It first
uses an executable `../aedicule/run`, which makes adjacent host changes live
without changing this repository's lock file:

```console
./run
```

Set `AEDICULE_REPOSITORY` to choose another source checkout. Any additional
arguments are forwarded after the canonical `--watch` pair:

```console
AEDICULE_REPOSITORY="$HOME/Code/aedicule" ./run --web
```

If the selected checkout has no executable launcher, `./run` falls back to the
exact `packages.frontplane` revision in `flake.lock` via `nix run
--no-write-lock-file`. Project and watched-file paths come from the launcher's
own location, so invocation works from any current directory.

The equivalent direct pinned invocation is:

```console
nix run --no-write-lock-file "$PWD#frontplane" -- --watch "$PWD/code.wat"
```

Mecha Aedicule compiles each saved candidate separately, validates and
initializes it, restores the opaque state only when schema and length match,
requires a valid first frame, and then swaps it into the running window. Broken
WAT never displaces the working game. A deliberate schema change starts fresh.

On July 16, 2026, Peter flew the ship while we removed its per-tick drag from
WAT. In the next simulation tick the already-running ship coasted indefinitely:
the process did not restart, Rust did not rebuild, and score, lives, wave,
bullets, and rocks remained intact. We then restored gentler `0.995` drag and
saw that change live too. The current schema-11 implementation expresses it as
exact decimal-fixed `velocity * 995000 / 1000000`; the WAT policy test forbids
IEEE-754 gameplay arithmetic outside the sealed host-scalar adapter.

That experiment is the architecture in miniature: native facilities remain
stable while application behavior changes in human-visible real time.

## Status

Implemented:

- score, level, lives, pause, restart, help, and game-over lifecycle;
- a seeded starfield and full-window, resize-aware coordinates;
- jagged rotating rocks with bounded pools, splitting, fragments, wraparound,
  escalating waves, level-scaled speed caps, and wilder shatter impulses;
- inertial ship physics with gentle drag, thrust, rotation, firing, collision,
  debris, particles, safe respawn, and extra lives;
- auto-fire, Kid Mode, and the semi-secret Death Blossom;
- independently scheduled disc UFOs with predictive, random, and defensive
  fire, physical collisions, a 2,000-point bounty, and hazardous viewport-scaled
  expanding blasts whose asteroid score follows player-kill attribution; unsafe
  asteroid entry trajectories defer for a bounded retry;
- destructible drifting packages scheduled 20% sooner and drawn as bowed gifts;
  each randomly grants either 20 seconds of finite, non-wrapping multi-target
  laser fire or doubled bounded fire rate,
  with an icon-and-text tenths countdown for the active reward;
- a compact, slowly rotating derelict Voyager that defers arrival during dense
  waves or unsafe asteroid entry trajectories, pings faintly, pulses cyan, and
  turns deliberate player fire into an asteroid-scoring multi-rock reactor
  blast while accidental contact scores nothing;
- guest-declared shot, laser, thrust, explosion, extra-life, Death Blossom,
  alert, notification, phone-home ping, and layered 1.2-second-or-longer BOOM
  synths, plus bounded packaged FLAC playback after player-triggered Voyager
  destruction;
- signed decimal-fixed internal state and physics, with one sealed float adapter
  for the host ABI;
- deterministic seeds, snapshots, WAST behavior tests, and headless SVG; and
- state-preserving live code replacement through Mecha Aedicule.

Current deliberate limits:

- the packaged simulation rate is 120 Hz, with equal-time integral and
  NTSC-derived rational-rate WAST proof;
- input-modality discovery currently exposes coarse-primary-pointer state and
  observed raw touch, not Aedicule's planned complete capability bitset for
  every hybrid device;
- presentation and tuning remain POC quality; and
- gameplay additions should be validated as experiments, not added merely
  because the frontplane can express them.

See [VIBESTEROIDS_BEHAVIOR_SPEC.md](VIBESTEROIDS_BEHAVIOR_SPEC.md) for the
source-derived algorithms and quirks, [FIDELITY_GAP_MATRIX.md](FIDELITY_GAP_MATRIX.md)
for implementation status, and [GAMEPLAY_DESIGN_RESEARCH.md](GAMEPLAY_DESIGN_RESEARCH.md)
for the Asteroids/Blasteroids engagement research and playtest proposals.

## Testing

`./test` enters a pure flake shell and accumulates all failures. It runs:

- stock Wasmtime against the production WAT plus companion WAST scenarios;
- the locked Aedicule `aedicule-render` binary through configure, initialize,
  tick, and render, with successful validation required to keep stderr silent;
- the structural decimal-fixed classifier;
- repository-boundary and Nix-composition classifiers; and
- ShellCheck over every executable test/build script.

Application behavior stays in WAST, not Rust. Scenario comments name the
user-visible contract, the regression each group catches, and paired controls
where needed. The instrumented `aedicule.v0` WAST module records emitted scenes,
audio, effects, and metadata without a custom test-only export in production
code. Its geometry boundary mirrors Aedicule's finite-coordinate, radius,
stroke-width, and flags validation, catching argument-slot errors before the
real host sees a frame. Production drawing code cannot supply raw circle flags:
semantic filled/outlined wrappers own those constants, and a source classifier
requires the raw import's complete caller set to be exactly those two wrappers.

The headless renderer produces an inspectable frame without a desktop:

```console
./build
result/bin/vibesteroids-wat-render --ticks 300 -o frame.svg
```

## Repository map

| Path | Purpose |
| --- | --- |
| `code.wat` | Complete decimal-fixed game state, rules, rendering intent, menus, and synth declarations |
| `tests/wast/` | Standard WAST behavior, state, render, effect, and lifecycle specifications |
| `tests/run-wast` | RAM-only composer and stock Wasmtime WAST runner |
| `tests/lint-wat` | Structural fixed-point/float-adapter policy classifier |
| `tests/cli/aedicule_runtime` | CI gate that runs production WAT through the locked native Aedicule renderer |
| `tests/cli/circle_argument_roles` | Set classifier that confines raw circle flags to semantic fill/outline wrappers |
| `flake.nix` | Pinned Mecha Aedicule dependency, WAT artifact, wrapper, checks, and tools |
| `VIBESTEROIDS_BEHAVIOR_SPEC.md` | Source-derived original behavior and algorithms |
| `FIDELITY_GAP_MATRIX.md` | Fidelity decisions and remaining work |
| `GAMEPLAY_DESIGN_RESEARCH.md` | Sourced engagement analysis and falsifiable experiments |

## License

`vibesteroids_wat` is available under the [MIT License](LICENSE).
