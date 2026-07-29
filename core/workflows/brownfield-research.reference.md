# Brownfield Research � Reference

## Stage details

### Stage 1 � Orientation

Root tree, README, contribution guides, solution/workspace files, package manifests and locks, build config, architecture docs, ADRs.

Examples: `README.md`, `package.json`, `*.sln`, `*.csproj`, `pyproject.toml`, `go.mod`, `Cargo.toml`, `pom.xml`, `build.gradle`.

### Stage 2 � Application topology

Frontends, APIs, libraries, domain modules, workers, schedulers, data-access layers, integrations.

### Stage 3 � Contracts and data

OpenAPI/GraphQL, DTOs, events, entities, migrations, validation, serialization, error conventions, sources of truth.

### Stage 4 � Identity and authorization

SDKs, middleware, callbacks, token/session validation, roles/policies, tenancy, user sync, FE guards vs BE enforcement. No tenant secrets.

### Stage 5 � Payments

SDK usage, checkout/portal, webhooks, signature verification, raw body, idempotency, entitlement sync, dunning. No Stripe/other secrets.

### Stage 6 � AI

Model clients, prompts/versions, structured outputs, embeddings/RAG, untrusted-content boundaries, validation, retries, cost/latency controls.

### Stage 7 � Infrastructure and delivery

Docker, IaC, hosting manifests, CI/CD YAML, approvals, secret refs (names only), workload identity, rollback.

### Stage 8 � Configuration

Local/test/staging/prod; build vs deploy vs runtime; public vs secret; feature flags; validation. Templates like `.env.example` only.

### Stage 9 � Quality

Unit/integration/contract/E2E/security/performance/AI-eval tests; mocks; coverage; pipeline gates. Reading ? passing.

### Stage 10 � Observability

Logging, correlation, tracing, metrics, health, alerts, dashboards, runbooks, backup/recovery.

## Current-state reconstruction checklist

1. Repository structure  
2. Applications and services  
3. Frontend architecture  
4. Backend architecture  
5. Data architecture  
6. API and event boundaries  
7. Identity and authorization  
8. Billing  
9. AI  
10. Infrastructure  
11. CI/CD  
12. Configuration and secret flow  
13. Quality strategy  
14. Observability  
15. Deployment topology  
16. External dependencies  

Text diagram example (only evidence-supported nodes):

```text
User
  |
  v
Frontend
  |
  v
API
  |----> Database
  |----> ExternalProvider
```

## Hybrid classification

| Label | Meaning |
|---|---|
| `PRESERVE` | Keep as-is |
| `EXTEND` | Add without breaking contracts |
| `REFACTOR` | Restructure; preserve behavior |
| `REPLACE` | Needs explicit justification and approval |
| `REQUIRES_DECISION` | Blocker for design |

## Provider detection examples (illustrative only)

Do not assume these exist. Only record when evidence is found:

- Supabase: `@supabase/*`, `supabase/config.toml`, migrations, RLS
- Auth0: Auth0 SDKs, audience/domain config keys, JWT middleware
- Stripe: Stripe SDK, webhook routes, Checkout
- CI/CD: `azure-pipelines.yml`, `.github/workflows`, `.gitlab-ci.yml`

## Interview after research (Hybrid / missing context)

Reuse Greenfield interview rules from [project-discovery.md](project-discovery.md): one question at a time; capability before provider; do not re-ask what evidence already proved.
