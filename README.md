# vibesteroids_wat

[![Proof of concept](https://img.shields.io/badge/status-playable_POC-f59e0b)](#status)
[![CI](https://github.com/pmarreck/vibesteroids_wat/actions/workflows/ci.yml/badge.svg?branch=yolo)](https://github.com/pmarreck/vibesteroids_wat/actions/workflows/ci.yml)
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

The flake therefore has three outputs:

- `packages.frontplane`: the exact Mecha Aedicule input pinned in `flake.lock`;
- `packages.application`: a tiny data derivation containing only `code.wat`;
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
```

Controls:

| Input | Action |
| --- | --- |
| Left / Right | Rotate |
| Up | Thrust |
| Space | Fire bullets, or the temporary laser when powered up |
| F | Toggle auto-fire |
| K | Toggle Kid Mode |
| B | Activate the once-per-life Death Blossom |
| P / Escape | Pause |
| H / F1 | Help / Controls |
| R | New game |
| Ctrl+R | Reload watched WAT |

New Game, Help / Controls, Reload, and Quit are also exposed through native
window actions.

## Live-edit the running game

Launch the source tree under observation:

```console
nix run github:pmarreck/aedicule/yolo -- --watch "$PWD/code.wat"
```

Or use an adjacent frontplane checkout:

```console
../aedicule/run --watch "$PWD/code.wat"
```

Mecha Aedicule compiles each saved candidate separately, validates and
initializes it, restores the opaque state only when schema and length match,
requires a valid first frame, and then swaps it into the running window. Broken
WAT never displaces the working game. A deliberate schema change starts fresh.

On July 16, 2026, Peter flew the ship while we removed its per-tick drag from
WAT. In the next simulation tick the already-running ship coasted indefinitely:
the process did not restart, Rust did not rebuild, and score, lives, wave,
bullets, and rocks remained intact. We then restored gentler `0.995` drag and
saw that change live too. The schema-5 implementation expresses it as
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
  fire, physical collisions, and a 2,000-point bounty;
- drifting packages that grant 20 seconds of finite, non-wrapping,
  multi-target laser fire;
- guest-declared shot, laser, thrust, explosion, extra-life, and Death Blossom
  synths;
- signed decimal-fixed internal state and physics, with one sealed float adapter
  for the host ABI;
- deterministic seeds, snapshots, WAST behavior tests, and headless SVG; and
- state-preserving live code replacement through Mecha Aedicule.

Current deliberate limits:

- the packaged simulation rate remains 60 Hz until equal-time 60/120 behavior
  and Peter's visual playtest pass;
- touch/shake browser controls have no native equivalent yet;
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
- the structural decimal-fixed classifier;
- repository-boundary and Nix-composition classifiers; and
- ShellCheck over every executable test/build script.

Application behavior stays in WAST, not Rust. The instrumented `aedicule.v0` WAST
module records emitted scenes, audio, effects, and metadata without a custom
test-only export in production code.

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
| `flake.nix` | Pinned Mecha Aedicule dependency, WAT artifact, wrapper, checks, and tools |
| `VIBESTEROIDS_BEHAVIOR_SPEC.md` | Source-derived original behavior and algorithms |
| `FIDELITY_GAP_MATRIX.md` | Fidelity decisions and remaining work |
| `GAMEPLAY_DESIGN_RESEARCH.md` | Sourced engagement analysis and falsifiable experiments |

## License

`vibesteroids_wat` is available under the [MIT License](LICENSE).
