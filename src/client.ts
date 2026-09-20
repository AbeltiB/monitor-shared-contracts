import createClient from "openapi-fetch";
import type { paths } from "./schema.js";

/**
 * The one typed client every Monitor frontend (internal/advertiser/agency/station) imports
 * instead of hand-rolling fetch calls — the whole point of this package: a field renamed in
 * monitor-api becomes a type error here, not a silent runtime bug in 4 unrelated repos.
 */
export function createMonitorClient(baseUrl: string, options?: { fetch?: typeof fetch }) {
  return createClient<paths>({ baseUrl, ...options });
}

export type { paths, components } from "./schema.js";
