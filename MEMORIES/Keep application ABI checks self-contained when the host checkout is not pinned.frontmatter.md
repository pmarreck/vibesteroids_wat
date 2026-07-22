---
description: "Keep application ABI checks self contained when the host checkout is not pinned."
datetime: 2026-07-18T01:32:40-04:00 # America/New_York (EDT)
tags: [application, abi, checks, self, contained, when, host, checkout, pinned]
---
An adjacent host checkout can be the authoritative review source for a newly
generated ABI document, but an application's committed test suite must not
read it: its revision and uncommitted changes are not part of the application's
lock file. Encode the application's required guest lifecycle in companion WAST
and its documented constants in a local classifier instead. This caught the
schema-4 prose claiming 8,192 bytes while the actual `AE_state_len` export and
WAST already established 16,384 bytes.
