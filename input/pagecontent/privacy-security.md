#### Security and Access Control for Bundle Operations [work in progress]

To ensure the integrity, privacy, and appropriate use of health data, all operations on the `NgBundle` resource must comply with Nigeria’s national health data governance principles and security standards.

### Authentication & Authorization

- **Authentication:** All clients MUST be authenticated using OAuth2.0 with client credentials or SMART-on-FHIR tokens.
- **Authorization:** Role-based access control (RBAC) MUST be enforced by the FHIR server based on user claims or scopes:
  - `bundle.submit`
  - `bundle.read`
  - `bundle.write`
  - `bundle.sync`
  - `bundle.admin`

### Data Privacy & Filtering

- Bundles are scoped to **organization units** (facility, LGA, state) using associated `Organization.identifier`.
- Systems MUST not return bundles beyond the requestor’s scope (e.g., a facility user must not see state-wide data).
- Sensitive elements such as `deceasedDateTime`, `HIV status`, or sibling records must follow data minimization principles when returned to mobile apps or public dashboards.

### Operation-Specific Safeguards

- `$submit-ng-bundle`: MUST validate using `$validate-ng-bundle` before committing to the server.
- `$remove-obsolete-bundles`: REQUIRES elevated privileges (admin role) to execute.
- `$resolve-conflicts`: SHOULD trigger a manual review workflow or return a conflict report before automated resolution.
- `$export-ng-bundle`: SHOULD support export logging, throttling, and encryption of large payloads.

---

_These access rules aim to balance data utility with privacy and compliance, in line with the Nigeria Data Protection Act (NDPA) and WHO SMART Guidelines._

