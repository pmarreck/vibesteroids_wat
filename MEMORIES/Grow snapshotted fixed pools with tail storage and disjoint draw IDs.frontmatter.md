---
description: "Grow snapshotted fixed pools with tail storage and disjoint draw IDs."
datetime: 2026-07-20T14:27:23-04:00 # America/New_York (EDT)
tags: [snapshot, schema, fixed-pool, address-stability, draw-commands, stable-ids, wat, wasm, webassembly]
---
When a fixed-capacity pool is embedded before other records in a snapshot,
growing it contiguously would relocate every later record and amplify the
migration. Preserve the legacy records and route logical indices through one
address function: old indices retain their original base and new indices map
to tail storage appended after the prior snapshot extent. Bump the snapshot
schema and length because the layout contract still changed.

Rendering needs the same care. A larger logical index range can make a former
`base_id + index` scheme overlap another primitive's stable IDs. Give overflow
records a separate, mechanically disjoint draw-ID range and test both storage
occupancy and emitted primitive count. Vibesteroids grew from 64 to 256 player
projectiles this way, using 192 tail records while keeping the first 64 byte
addresses unchanged.
