# Ownership Matrix — Sample Catalog API

| Concern | Primary Owner | Supporting Agents | Reviewer | Approval Authority |
|---|---|---|---|---|
| Request orchestration | principal-software-architect | — | user | user |
| Catalog HTTP API | backend-engineer | principal-software-architect | principal-software-architect | principal-software-architect |
| Catalog data model | backend-engineer | principal-software-architect | principal-software-architect | user (breaking) |
| Provider selection | user | principal-software-architect | principal-software-architect | user |
| Integration review | principal-software-architect | backend-engineer | user | principal-software-architect |

Rules: one primary owner per concern; no duplicate ownership.
