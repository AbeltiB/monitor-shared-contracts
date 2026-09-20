# @abeltib/monitor-shared-contracts

OpenAPI spec + generated TypeScript client/types for [Monitor](../Monitor%20—%20TV%20Ad%20Verification%20Platform%20PRD.md)'s
Core API. Published as a private package so `monitor-internal`, `monitor-advertiser`,
`monitor-agency` and `monitor-station` never hand-drift from `monitor-api` (PRD §2) — a field
renamed in the API becomes a type error here, not a silent bug in four unrelated frontends.

**Status:** Phase 1 — real types for `monitor-api`'s full Phase 1 surface (stations, agencies,
advertisers, ad_creatives, contracts, detected_events, reconciliation_results), synced and
codegen'd from a live, migrated API. Version `0.2.0`.

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

CI builds against whatever `openapi/v1.json` is currently committed here — it does **not** check
out `monitor-api` itself (see the "Open item" below). Run the sync command above and commit the
result before pushing, or CI will build/publish against a stale spec.

## Usage from a frontend

```ts
import { createMonitorClient } from "@abeltib/monitor-shared-contracts";

const api = createMonitorClient(process.env.NEXT_PUBLIC_API_BASE_URL!);
const { data, error } = await api.GET("/health");
```

## Naming — a GitHub Packages constraint, not a preference

The npm scope is `@abeltib`, matching the GitHub account that owns these repos, not `@monitor`.
GitHub Packages' default `GITHUB_TOKEN`-based publish only has permission when the scope matches
the owning user/org — `@monitor/...` published with a 403 ("no such installation") until this was
renamed. Consuming repos (`monitor-internal` and later advertiser/agency/station) must depend on
`@abeltib/monitor-shared-contracts`, not `@monitor/shared-contracts`.

## Open item

Cross-repo automation (monitor-api triggering this repo's codegen automatically on merge, via
`repository_dispatch`) is a nice-to-have, not required for Phase 0 — the manual sync above is
fine for a solo operator until it becomes a real friction point.
