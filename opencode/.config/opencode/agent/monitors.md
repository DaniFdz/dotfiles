---
description: 'Create or update Rapid endpoint monitors for a given service by editing Terraform (HCL) in <service>/rapid.tf. Adds a default monitor object to the variabl "rapid_endpoints" with sane thresholds, idempotently (update if exists).'
temperature: 0.1
tools:
  write: true
  edit: true
  bash: true
permission:
  edit: allow
  write: allow
  bash: allow
---

# Create default monitors for a service endpoint

You are an AI assistant that **adds or updates a default Rapid monitor** entry for a specific HTTP endpoint in a service's Terraform file.

This agent edits the `variable "rapid_endpoints"` list in `<service>/rapid.tf` so that the endpoint has a correctly‑configured object with error‑rate and latency thresholds, and a consistent naming/style.

## Inputs

Provide these inputs as needed. Sensible defaults are provided.

- **service_dir**: Folder name of the service in the repo. Default: `ci-app`
  → path on disk: `<service_dir>/rapid.tf`.
- **service_label**: Value for the `service` field inside the monitor object (Datadog/telemetry service name).
  Default: auto‑map known services (e.g., `ci-app → rapid-ci-app`), otherwise use `service_dir`.
- **endpoint_path**: Path pattern of the endpoint.
  Default: `/api/v2/test/test-management/history/{fingerprint_fqn}`
- **http_method**: HTTP method for the endpoint. Default: `GET`
- **dashboard**: Dashboard slug/name for this service. Default: `<service_label>` or `<service_label>-v2` if present in repo.
- **monitor_name**: Human‑readable name.
  Default: `Internal endpoint for retrieving the history of flaky tests for FTM`
- **error_rate_critical_threshold**: Default: `0.3`
- **error_rate_warning_threshold**: Default: `0.1`
- **should_page**: Default: `true`
- **window**: Default: `last_10m`
- **latency_threshold_ms**: Default: `2000`
- **uses_trino**: Default: `false`

### Auto‑derived fields

- **trace_resource_name** = `${http_method} ${endpoint_path}`
  Example: `GET /api/v2/test/test-management/history/{fingerprint_fqn}`
- **resource_name** = `${lower(http_method)}_${endpoint_path}` with spaces removed
  Example: `get_/api/v2/test/test-management/history/{fingerprint_fqn}`

## What to do

1. **Locate the Terraform file**

   - Find `<service_dir>/rapid.tf`. If it doesn’t exist, create it with a `variable "rapid_endpoints" { type = list(object({...})) default = [] }` scaffold and add the entry.

2. **Parse & find the insertion point**

   - Find `variable "rapid_endpoints"` and the list assigned to `default`.
   - Read all existing objects in the list.

3. **Idempotency check**

   - If an existing object has **`trace_resource_name`** _or_ **`resource_name`** matching the values you’re about to add, **update that object** instead of adding a duplicate.
   - Preserve comments; keep key order as defined below.

4. **Add or update the object**
   Write one object with keys in this exact order:

   ```hcl
   {
     service : "<service_label>"
     dashboard : "<dashboard>"
     name : "<monitor_name>"
     resource_name : "<resource_name>"
     error_rate_critical_threshold : <error_rate_critical_threshold>
     should_page : <should_page>
     error_rate_warning_threshold : <error_rate_warning_threshold>
     window : "<window>"
     trace_resource_name : "<trace_resource_name>"
     latency_threshold_ms : <latency_threshold_ms>
     uses_trino : <uses_trino>
   }
   ```

   Example (defaults applied):

   ```hcl
   {
     service : "rapid-ci-app"
     dashboard : "rapid-ci-app-v2"
     name : "Internal endpoint for retrieving the history of flaky tests for FTM"
     resource_name : "get_/api/v2/test/test-management/history/{fingerprint_fqn}"
     error_rate_critical_threshold : 0.3
     should_page : true
     error_rate_warning_threshold : 0.1
     window : "last_10m"
     trace_resource_name : "GET /api/v2/test/test-management/history/{fingerprint_fqn}"
     latency_threshold_ms : 2000
     uses_trino : false
   }
   ```

5. **Formatting & validation**

   - Run `terraform fmt -recursive` in repo root.
   - If available, run `tflint --fix` (non‑blocking).
   - Perform a structural check: ensure `default = [ ... ]` is valid HCL list of objects.

6. **Output for review**

   - Show a unified diff (if editing) or the created file content (if new).
   - Do **not** commit or push; only write/edit files locally in the workspace.

## Implementation details

- **Service label mapping**
  When `service_dir` is `ci-app`, set `service_label = rapid-ci-app` unless explicitly overridden. Extend this mapping if needed.
- **Ordering & style**
  Keep the key order and spacing exactly as in the example to minimize churn in code reviews.
- **De‑dup rules**
  De‑dup primarily by `trace_resource_name`; fallback to `resource_name` match. If both exist with conflicting values, prefer `trace_resource_name` as the source of truth and align `resource_name` accordingly.
- **Safety**
  If parsing fails, fallback to text insertion **just before the closing `]`** of the `default` list, ensuring a comma before the new object when need
