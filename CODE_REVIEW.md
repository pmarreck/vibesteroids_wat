# Deep Code Review — vibesteroids_wat

**Date:** 2026-07-21
**Reviewer:** Codex, using the `deep-code-review` skill
**Scope:** Full read-only audit of WAT/WAST, Bash, Nix, specifications, and the
Aedicule guest/host boundary
**Constraint:** No builds or tests were run, and no source code was changed.

## Summary

- **CRITICAL:** 0
- **WARNING:** 12
- **ADVISORY:** 9

The implementation has good fundamentals: deterministic fixed-point state,
bounded pools, a self-contained WAST oracle, a pinned native-host gate, and no
reachable linear-memory overlap found. The highest-value next work is not a
rewrite. It is four small correctness fixes and stronger independent controls:

1. Preserve persistent flags on focus loss.
2. Make the standalone runtime gate impossible to skip when `capture` is absent.
3. Translate an active hazardous blast when the viewport is resized.
4. Correct two i64 spawn assertions that currently read only their low words.
5. Expand fake/real host validation of conditional render frames.

The audit used direct file reads and `rg`. The local `codescan` index was stale
and contained no WAT/WAST, so no finding relies on it.

## Resolution update — 2026-07-21

Every application-owned nonvisual finding is resolved in isolated green
commits. The final full application gate remains pending only on the two visual
decisions and Aedicule's accepted host-owned tranche.

| Finding group | Disposition |
| --- | --- |
| Focus state, blast resize, i64 spawn oracle | Fixed with failing WAST regressions, then full `./test` and `./build` |
| Fake-host geometry/lifecycle and conditional stable IDs | Fixed with independent accepting and rejecting controls on every companion render |
| Rational timers, toroidal sweeps, bidirectional spawns | Expanded into deterministic matrices/set classifiers |
| Portable runtime gate and failure diagnostics | Fixed with repository-contained adapters and explicit failure propagation |
| Duplicate CI/Nix work | Fixed with one manifest, one flake evaluation, and a post-flake mode that skips only already-proved checks |
| Positional synth configuration | Full 14-scalar signature locked; host call centralized; each cue isolated behind an intent-named declaration function |
| Raw scalar addresses and opaque lifecycle/input flags | Every scalar snapshot address plus every flag bit/composite/mutation is named; structural lint rejects raw scalar load/store addresses and opaque flag composites |
| Bullet collision/expiry hot paths | Segment setup hoisted per bullet with AABB rejection; schema 9 uses cached-range, per-shot lifetime countdowns instead of per-tick square roots |
| Stale public documentation and PLAN history | README/SPEC/fidelity ledger reconciled; active plan pruned while Git preserves history |
| Mouse Help rows and active gift identity | Concept sheet awaiting Peter's required visual approval before production geometry/assertions |
| Synth ranges, host budgets/minor negotiation, real conditional-frame injection | Aedicule accepted ownership; tested pushed pin pending in `inbox/2026-07-21-from-aedicule-deep-review-dispositions.md` |

## 1. Inconsistent, Incomplete, or Undefined Functionality

### WARNING — Focus loss destroys persistent game state

**Location:** `code.wat:1900`; contract at `SPEC.md:127`

The focus-loss branch stores `flags & 16`. That retains only pause while erasing
Auto-fire (`32`), Kid Mode (`64`), active Death Blossom (`128`), the once-per-life
Death Blossom charge (`256`), Help (`512`), and all held controls. The contract
promises only that focus loss clears held controls. Use the same `flags & -16`
policy as `AE_after_restore`, with an explicit test for which modal flags survive.

### ADVISORY — Help omits every implemented mouse control

**Location:** `code.wat:80`; implemented input at `code.wat:1865-1898`

The overlay documents only the keyboard despite pointer aim, held primary fire,
held secondary thrust, and wheel Death Blossom being live. Add concise mouse
rows to Help and the README control table; keep undeployed touch controls marked
separately.

### ADVISORY — The random gift has neither accurate public documentation nor HUD identity

**Location:** `SPEC.md:162`; selection at `code.wat:1476-1490`; render at
`code.wat:2128-2244`

The specification and README still describe a laser-only package, while the
game randomly chooses lasers or doubled fire rate. The active kind and remaining
20-second timer are never rendered, so rapid fire must be inferred from cadence.
Document both outcomes and add a small deterministic icon/countdown after Peter
approves its appearance.

## 2. Inadequate Test Coverage

### WARNING — Resize omits the active hazardous-blast coordinates

**Location:** blast state at `code.wat:1362-1368`; translator at
`code.wat:1772-1824`; coverage at `tests/wast/vibesteroids.wast:349-373`

`$translate_entities` moves bullets, foreign actors, laser endpoints, rocks,
particles, and debris, but not the active blast at `26632/26640`. Resizing during
the 1.2-second blast therefore detaches its visual center from the recentered
world. First add a failing resize fixture with an active blast, then translate
its coordinates by the same delta. Expand the fixture to cover every other
coordinate-bearing pool while there.

### WARNING — Cross-rate proofs do not exercise timer conversion

**Location:** `tests/wast/equal-time.wast:1`; conversion at `code.wat:262`

The four rate variants prove projectile travel and some damping, but no
`$ticks_from_sixty` lifecycle. Title, invulnerability, respawn, Death Blossom,
spawn schedules, power-up duration, fire cooldown, and blast duration all use
that conversion. Add one short boundary, one long boundary, and one lifecycle
transition across 60, 120, 60000/1001, and 120000/1001 Hz at equal elapsed time.

### ADVISORY — Swept-collision coverage lacks its toroidal-wrap negative control

**Location:** guard at `code.wat:943-972`; positive proof at
`tests/wast/gameplay.wast:345`

The suite proves that a finite segment catches tunneling but not that an edge
wrap avoids a false screen-wide chord. Add paired left/right and top/bottom wrap
cases with an asteroid on that apparent chord, alongside the existing positive
case so neither accept-all nor reject-all logic passes.

### ADVISORY — Bidirectional spawn tests never prove both directions or paired edges

**Location:** `tests/wast/enemy-and-powerup.wast:83-97` and `:226-241`

Each test accepts one direction in `{-1,+1}` and checks only a vertical range.
A mutation that always selects one direction or spawns in the middle still
passes. Classify a deterministic seed set that observes both directions and
assert the corresponding left/right x coordinate and retirement edge.

## 3. Futile or Non-constraining Test Coverage

### WARNING — Two i64 spawn ranges are asserted through i32 loads

**Location:** `tests/wast/enemy-and-powerup.wast:94-97` and `:238-241`;
helper at `tests/wast/vibesteroids.wast:132-137`

UFO and package y positions are i64 fixed-point fields, but both assertions use
`state_i32_between`. Any corrupt i64 with an acceptable low word passes. Use the
existing i64 range helper and i64 bounds; keep the i32 helper for actual i32
countdown/cadence fields.

### WARNING — Actor render assertions accept invisible geometry

**Location:** `tests/wast/aedicule-v0.wast:195-241`; assertions at
`tests/wast/enemy-and-powerup.wast:107-109`, `:242-244`, and `:410-412`

UFO/package paths and lasers are counted largely by stable ID. Empty paths,
zero-length lines, or zero-width lines can satisfy the tests. Record only the
minimum mechanical invariants—nonzero path segments/extent, line length/width,
and circle radius—with accept/reject controls. Peter remains the appearance
oracle; these checks merely prevent disappearance.

## 4. Fast Test Coverage

### ADVISORY — CI repeats the complete WAST/policy work and reevaluates one flake repeatedly

**Location:** `.github/workflows/ci.yml:32`; `flake.nix:66-90`; `test:31-32`;
`tests/cli/flake_composition:6-24`

`nix flake check` already runs the WAST/lint check, after which CI runs `./test`
and repeats it. The composition classifier also starts four Nix evaluations for
values available from one flake/system evaluation. Preserve `./test` as the
one-command local gate, but make CI execute every independent control once and
return all three derivation paths from one Nix expression.

No sleeps, timing hacks, headless browsers, or nondeterministic clock reads were
found in the test suite.

## 5. Superfluous or Duplicated Functionality

No material issue was retained. There is low-risk cleanup available—canonical
WAST initialization is copied fifteen times, the master test manifest is listed
twice, and the unused `"WAVE"` data segment remains at `code.wat:77`—but none is
urgent enough to displace the correctness work above.

## 6. Suboptimal, Inconcise, or Disorganized Code

### WARNING — Older synth declarations retain an error-prone positional ABI surface

**Location:** `code.wat:126-240`

`AE_configure` is a 115-line mixture of menu setup and 14-scalar synth calls.
Newer cues use `$declare_swept_voice`, whose comment documents the exact class
of parameter-order error that previously caused a native reload rejection.
Extract cue-specific configure helpers and route declarations through a small
set of named envelope/filter helpers. This is especially worthwhile before the
satellite adds its repeating ping and explosion layers.

### ADVISORY — Raw state addresses and flag masks hide the schema

**Location:** state map at `code.wat:10-39`; flags at `code.wat:616-620` and
`code.wat:1836-1901`

Scalar state is accessed through pervasive absolute literals, and flags use raw
bits plus opaque composites such as `528` and `656`. The focus-loss bug is an
example of the review burden this creates. Add named immutable address/mask
globals and small set/clear/toggle helpers incrementally, without introducing a
generator or changing the snapshot layout.

## 7. Algorithmic Complexity

### WARNING — Bullet segment setup is repeated inside the bullet×asteroid product

**Location:** `code.wat:947-972` and `:974-1002`

At documented maxima the loop considers 256×32 = 8,192 pairs per tick. For each
asteroid it reconstructs and rescales the same bullet segment again, including
multiple i64 divisions. Hoist prior/current endpoints once per active bullet and
perform a cheap swept-AABB rejection before the full segment/circle projection.
A spatial grid is not justified for only 32 asteroids.

### WARNING — Bullet expiry recalculates two invariant square roots every tick

**Location:** `$integer_sqrt` at `code.wat:353`; calls at `code.wat:1176-1179`

Every active bullet recomputes both its constant speed magnitude and the
viewport diagonal. At 256 bullets and 120 Hz that permits 61,440 Newton square
roots per second. Cache the half-diagonal on init/resize and compute a remaining
range or lifetime once when firing; then update with an integer decrement or
addition. Profile before and after rather than assuming a win.

## 8. Files Without Clear Purpose

### WARNING — The current-state documents disagree with production

**Location:** `FIDELITY_GAP_MATRIX.md:20-63`; `SPEC.md:274`

The matrix still says 60 Hz, schema 4, repeated 20,000-point ships, and all
pointer controls deferred. Production is 120 Hz/schema 8, uses 30,000-point
geometrically growing thresholds, and implements desktop pointer controls.
Give each document one role: `SPEC.md` for current contract, `PLAN.md` for active
work, and the matrix only for source-versus-port deltas. Update present-tense
facts and remove the completed 120-Hz migration from current non-goals.

### ADVISORY — PLAN.md obscures active work with superseded completed history

**Location:** `PLAN.md:3-244`

The plan retains old 16 KiB schema and 60–180-second schedule milestones long
after later items superseded them; active items are scattered through 244 lines.
Keep active work plus the last few green milestones. Preserve older history
non-destructively in Git or a clearly labeled implementation-history document.

## 9. Not Leveraging Language Features

No separate issue was retained. During the safe refactors above, WAT memarg
`offset=` immediates can replace at least 115 explicit `i32.const; i32.add`
field-address sequences, and indexed fixture memory can replace synth-counter
equality ladders. These are opportunistic simplifications, not prerequisites.

## 10. Memory Safety and Resource Leaks

No reachable WAT linear-memory violation or pool overlap was found. The audit
checked the 32 KiB snapshot, legacy and tail bullet pools, blast base, fixed
capacities, and one-page memory boundary. Tail bullet storage ends exactly where
blast state begins, with no overlap.

## 11. FFI / Aedicule Host Boundary Correctness

### WARNING — Conditional frames are not subjected to the real host transaction

**Location:** fake host at `tests/wast/aedicule-v0.wast:179-258`; native gate at
`flake.nix:55`; tracked work at `PLAN.md:218-231`

The fake host now catches duplicate stable IDs but still accepts nested/missing
frames, transform imbalance, unterminated paths, invalid flags/ranges, and
command/segment-budget overflow. The locked native gate renders only initial
state. Add a small fake-host transaction state machine with mutation controls.
Once Aedicule exposes deterministic headless event/menu injection, pin it and
drive Help, pause, debris, UFO/package, blast, and satellite frames through the
real renderer. This is partly acknowledged in PLAN.md, but the fake-host half
is not.

### WARNING — Aedicule's public synth ABI omits accepted enums and ranges

**Location:** `../aedicule/WAT_ABI.md:102-108`; validation currently in
`../aedicule/src/lib.rs:2505-2545`

The document names each `AE_synth_voice` field but not waveform/filter enums,
duration/delay/cooldown limits, combined duration limits, frequency bounds, or
gain bounds. A guest cannot intentionally conform without reading Rust or
learning through rejection—the same boundary ambiguity behind the earlier
unsupported-filter failure. **Aedicule owns this fix:** generate enum/range
tables from the validation source. Vibesteroids should then mirror those public
constraints in its self-contained fake host.

### ADVISORY — Host budgets are contractual but unpublished

**Location:** `../aedicule/WAT_ABI.md:7,306`; current defaults at
`../aedicule/src/lib.rs:731-750`

The ABI promises finite limits and atomic rejection without stating normative
minimums for commands, path segments, effects, audio events, voices, ticks, or
snapshots. **Aedicule owns the contract:** publish guaranteed minima and expose
capabilities if adapters may lower them. Vibesteroids can then prove its fixed
maximum frame and tick batch remain within those minima.

All 18 production imports, mandatory/optional export signatures, 120/1 tick
selector, schema-8 snapshot boundary, and dropped-import-status transaction
behavior match the pinned host.

## 12. Error Handling Gaps

### WARNING — A missing private `capture` helper silently skips the runtime gate

**Location:** `tests/cli/aedicule_runtime:6-24`

The script sources `$HOME/dotfiles/bin/src/capture.bash` without checking the
source or function. If absent, `capture` is command-not-found, but preinitialized
`rc=0` remains unchanged and the script exits successfully without running
`nix build .#checks.<system>.runtime`. Make capture/status collection
repository-contained or fail explicitly if the helper/function is unavailable.
Add an isolated negative control proving the script cannot pass without actually
executing its command.

### ADVISORY — Failures discard or hide their best diagnostics

**Location:** `tests/run-wast:6-10,32-48`;
`tests/cli/flake_composition:6-27`; `test:15-20`

The generated aggregate WAST cited by Wasmtime is unconditionally deleted on
failure unless retention was requested in advance. Nix evaluation stderr is
redirected to fixed, undisclosed `$TMPDIR` files, while the master accumulator
does not print the failed check name. Retain the generated suite automatically
on failure; use per-run temporary diagnostics, replay them only on failure, and
label the failing check/status. Explicitly gate every suite-composition command
before invoking Wasmtime so a partial aggregate cannot obscure the first error.

## 13. Database Access Patterns

Not applicable. Runtime, test, and build paths use no application database or
persistent query store. `.codescan/index.sqlite3` is local tooling only and is
not referenced by project code.

## Suggested order of work

1. TDD the focus-loss flag preservation and active-blast resize defects.
2. TDD the absent-capture negative control and make the runtime gate portable.
3. Correct the two i64 assertions, then add degenerate-render controls.
4. Add timer-rate and toroidal-wrap matrices.
5. Harden conditional-frame ABI validation in both fake and real hosts.
6. Update current-state documentation before the satellite behavior lands.
7. Profile the two projectile hot paths before optimizing them.
