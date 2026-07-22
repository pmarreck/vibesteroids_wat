# Vibesteroids Fidelity Gap Matrix

This is the implementation ledger between the source-derived behavior in
`VIBESTEROIDS_BEHAVIOR_SPEC.md` and the WAT application. A behavior is not
complete merely because it looks similar: its state, transitions, rendering,
audio event, snapshot behavior, and boundary cases must be covered where
applicable.

## Deliberate platform and product decisions

| Source behavior | GPUI/WAT decision | Reason |
|---|---|---|
| Browser URL parameters | Provide validated `--seed`; defer initial-level selection until the generic ABI has application configuration | A generic frontplane must not grow a Vibesteroids-specific `--level` switch. |
| Browser test-mode URL and in-page test UI | Keep standard WAST behavior scripts here; Mecha Aedicule independently tests generic host controls | WAST keeps application tests in the same ecosystem as the WAT while Rust remains outside this repository and outside the game boundary. |
| Eruda mobile console and HTTPS development server | Not applicable | These exist solely to support a browser/mobile runtime. |
| Device-motion permission and shake activation | Defer until a host motion capability exists | A desktop keyboard action remains available; the generic ABI must not pretend to have sensors. |
| Browser touch controls | Keep desktop pointer controls live; defer multi-contact touch until Aedicule deploys event kinds 11--14 | The guest owns left/right zones and stroke meaning; the host owns opaque contact IDs and ordered delivery. |
| Resize by proportional coordinate scaling | Translate positions by `new_center - old_center` | Peter explicitly selected center-relative preservation so resize does not stretch trajectories. |
| Ship drag `0.99` | Use `0.995` per simulation tick | Peter selected the gentler coefficient during a live, state-preserving WAT edit. |
| Refresh-rate-dependent browser delta timing | Request deterministic 120/1 integer ticks from Aedicule's monotonic scheduler | Replay, tests, and snapshots do not depend on display timing; equal-time WAST covers 60, 120, 60000/1001, and 120000/1001 Hz. |
| Ambient randomness for thrust/audio | Keep gameplay randomness seeded; keep audio noise outside gameplay state | Rendering/audio adapters must never feed nondeterminism back into simulation. |

## Numeric architecture — blocking prerequisite

| Requirement | Current state | Completion evidence |
|---|---|---|
| Decimal fixed-point world values | **Implemented** | Schema 9 stores gameplay dimensions in signed `i64` decimal millionths and velocities in canonical per-second units; WAST schema, motion, and exact-drag assertions pass. |
| Integer-only simulation | **Implemented** | A structural classifier rejects floating-point arithmetic, loads, and stores outside explicitly marked host-scalar conversion adapters. |
| Safe fixed-point multiplication and distance tests | **Implemented** | Collision deltas rescale to milli-fixed before squaring; exact `0.995`, negative values, collision equality, and 8K bounds are covered. |
| One-way host conversion | **Implemented** | Host viewport scalars convert once on ingress and completed draw scalars once on egress; no converted value re-enters gameplay state. |
| Explicit incompatible schema transitions | **Implemented** | Schema 9 records the player-bullet lifetime semantic; transactional reload restarts rather than restoring bytes with a different meaning. Earlier transitions remain preserved in Git. |

## Gameplay and state

| Requirement | Current state | Remaining work / proof |
|---|---|---|
| Seeded deterministic restart | **Implemented** | GUI and headless runners accept validated deterministic seeds; later repeated CLI values win; snapshot/replay tests are exact. |
| Five initial parent rocks, +1 per wave | **Implemented** | Retain capacity and progression tests after the schema migration. |
| Level difficulty formulas | **Implemented** | Integer interpolation covers source acceleration, rotation, bullet speed, fire delay, and pre-20 asteroid caps; endpoint/cap tests pass. |
| Ship rotation, thrust, wrap, and `0.995` drag | **Implemented** | Direction-vector rotation uses fixed small-angle sine/cosine, level-derived acceleration, and exact integer damping. |
| Bullet origin, velocity inheritance, cadence, lifetime, and cap | **Implemented** | A cached viewport diagonal and per-shot countdown retain half-diagonal expiry without per-tick square roots; source cadence/speed, swept collision, wrap negatives, and full-pool failure are covered. |
| Asteroid construction and irregular outlines | **Implemented, source-shaped spawn regions** | Seeded radii reach `[20,50)`, points span 8–12, angular motion is `[-1,1)` rad/s, and velocity limits are exact; the bounded port uses four safe edges rather than eight unweighted rectangles. |
| Bullet/ship collision and splitting | **Implemented** | Thresholds/impulses are fixed decimal; tests cover 60% children, seeded ±20 offsets, scoring, and level caps. |
| Scoring and geometrically rarer extra ships | **Implemented** | The first reserve arrives at 30,000 points; each later gap grows by 1.5x with unsigned saturation and one award per scoring event. |
| Ship death, debris, safe respawn, bomb, and game over | **Implemented** | World effects keep advancing; source-time lifecycle boundaries, 96/48 safe radii, no-score bomb, and delayed game over are tested across rational rates. |
| Pause, focus release, restart | **Implemented** | P/Escape and focus release are mapped; deterministic tests prove pause/help freeze and restart behavior. |
| Auto-fire toggle (`F`) | **Implemented** | A generic key code drives a snapshotted latch and deterministic cadence; Help lists the control. |
| Kid Mode (`K`) | **Implemented** | Tests prove score/life suppression, ordinary-HUD hiding, and retained collision/explosion behavior. |
| Death Blossom (`B`) | **Implemented** | Tests cover eligibility, once-per-life consumption, 7.2-rad/s fixed rotation, exact 12-rotation end, two-tick firing, base speed, cancellation/reset, HUD, and siren. |

## Viewport, rendering, and controls

| Requirement | Current state | Remaining work / proof |
|---|---|---|
| Game fills drawable window | **Implemented; awaiting visual gate** | The host uses a 1:1 full-bounds projection and overlays native controls/status instead of consuming game space. |
| Runtime viewport events | **Implemented** | Actual GPUI viewport sizes are coalesced by bitwise equality and delivered once per distinct finite positive size. |
| Center-relative resize | **Implemented** | Snapshot tests prove ship, bullets, enemy shots, foreign actors, beams, hazardous blasts, rocks, particles, and debris translate by the exact center delta while velocities remain unchanged. |
| 100 deterministic stars regenerated on resize | **Implemented** | Exactly 100 stars are stored/regenerated independently; a regression proves the gameplay RNG state is unchanged. |
| Recognizable vector ship/rocks/debris/particles | **Implemented, approximate** | Retain semantic scene-command tests while moving all geometry calculations to fixed decimal before draw conversion. |
| Neon title/byline splash and timing | **Implemented; awaiting visual gate** | Layered magenta/cyan/white title and byline use an exact 60/120/60-tick fade/hold/fade lifecycle without render mutation. |
| HUD, pause, game-over, and Play Again presentation | **Implemented, approximate styling** | Score/level/reserves, Kid hiding, Blossom status/message, pause/game-over, and native New Game exist; styling remains a visual comparison item. |
| Discoverable Help/Controls | **Partial; awaiting Peter's visual gate** | Standard action 7 and F1/H open a plugin-owned overlay; keyboard rows are live, and the proposed desktop-pointer rows await visual approval. |
| Desktop pointer controls | **Implemented** | Rate-limited aim, held primary fire, held secondary thrust, release/focus cleanup, and wheel Death Blossom are covered through ordered `AE_event` calls. |
| Multi-contact touch controls | **Deferred** | Pin Aedicule after event kinds 11--14 deploy, then implement guest-owned zones/strokes and clear opaque contact state on end and cancel. |
| Timed power-up identity | **Partial; awaiting Peter's visual gate** | Seeded selection between lasers and doubled fire rate is tested; the proposed active-kind icon/countdown awaits visual approval. |

## Audio

| Requirement | Current state | Remaining work / proof |
|---|---|---|
| Application-independent host audio | **Implemented** | WAT declares bounded composable voices; Rust contains no Vibesteroids IDs or sound-name switch. Invalid descriptors are classified over a test set. |
| Decimal-only synthesis | **Implemented** | Oscillator phase, ramps, envelopes, noise, filters, and mixing use integer millionths; only audio ABI ingress and rodio PCM egress use host floats. |
| Shot | **Implemented, source-shaped approximation** | One sine voice sweeps 800→400→200 Hz for 0.1 s with 0.3→0.01 gain. |
| Thrust | **Implemented, source-shaped approximation** | A cooldown-limited 60-Hz saw voice uses a 200-Hz low-pass and 0.1→0.01 gain. |
| Asteroid explosion | **Implemented, source-shaped approximation** | Swept low-pass white noise is layered with a restrained 120-Hz bass voice for 0.5 s. |
| Ship explosion | **Implemented, source-shaped approximation** | White/brown noise, band-/low-pass shaping, and a short impulse layer span 1.2 s. |
| Death Blossom siren | **Implemented** | Three scheduled 400→800→400-Hz sine whoops start 400 ms apart. |
| Extra life | **Implemented** | Five sawtooth chimes use the specified ratios, filters, and 150-ms scheduling. |
| Failure isolation and bounds | **Partial** | Invalid graphs, excessive voices/duration/events, or unavailable devices fail silently to gameplay while yielding diagnostic host state. |

## Completion gate

The fidelity phase is complete only when:

1. every non-deferred row above is covered by a deterministic test;
2. simulation snapshots contain no IEEE-754 gameplay values;
3. the float-boundary classifier passes;
4. `./test` and the optimized `./build` pass;
5. Peter visually verifies the full-window presentation, Help, sounds, and
   Death Blossom in the real GPUI window; and
6. documentation names every intentional difference from browser
   Vibesteroids.
