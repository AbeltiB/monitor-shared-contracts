# @monitor/shared-contracts

OpenAPI spec + generated TypeScript client/types for [Monitor](../Monitor%20—%20TV%20Ad%20Verification%20Platform%20PRD.md)'s
Core API. Published as a private package so `monitor-internal`, `monitor-advertiser`,
`monitor-agency` and `monitor-station` never hand-drift from `monitor-api` (PRD §2) — a field
renamed in the API becomes a type error here, not a silent bug in four unrelated frontends.

**Status:** Phase 0 — empty spec (`monitor-api` has no domain endpoints yet, just `/health`),
pipeline proven end to end. Real types land as Phase 1 adds `ad_creatives`/`contracts`/
`detected_events` endpoints.

## How the spec gets here

`openapi/v1.json` is committed, not generated in this repo — it's a synced copy of
`monitor-api/openapi/v1.json`.

```bash
# in monitor-api/
bash scripts/export-openapi.sh

# in monitor-shared-contracts/
bash scripts/sync-openapi.sh
npm run build
```

CI does the same via a second `actions/checkout` of `monitor-api` (see `.github/workflows/ci.yml`).

## Usage from a frontend

```ts
import { createMonitorClient } from "@monitor/shared-contracts";

const api = createMonitorClient(process.env.NEXT_PUBLIC_API_BASE_URL!);
const { data, error } = await api.GET("/health");
```

## Open item

Cross-repo automation (monitor-api triggering this repo's codegen automatically on merge, via
`repository_dispatch`) is a nice-to-have, not required for Phase 0 — the manual sync above is
fine for a solo operator until it becomes a real friction point.
