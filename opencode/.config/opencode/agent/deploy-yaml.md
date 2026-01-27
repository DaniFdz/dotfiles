---
description: "Update a service to use deploy.yaml"
temperature: 0.3
tools:
  write: true
  edit: true
  bash: true
permission:
  edit: allow
  write: allow
  bash: allow
---

# Guide: Migrating a CI-App Service to deploy.yaml

## Prerequisites

1. Verify releases in [Remote Placement UI](https://remote-placement-ui.static-app.us1.ddbuild.io/) match the service's BUILD.bazel
2. Ensure `ddr` CLI is up to date: `brew upgrade ddr`

---

## EVP Workload Services (with evp-workload-common dependency)

### Step 1: Create deploy.yaml

Create `k8s/<SERVICE_NAME>/deploy.yaml`:

```yaml
config:
  gates:
    - businessHoursGate: &business_hours_gate_config
        preset: EU
        scopeType:
          - ENV
        matchScopeInstances:
          - prod
    - sleepGate: &default_sleep_gate_config
        durationSeconds: 0
        scopes:
          - DATACENTER
    - sleepGate: &canary_sleep_gate_config
        durationSeconds: 0
        scopes:
          - CUSTOM_GROUP
        matchScopeInstances:
          - canary
    - monitorGate: &scoped_monitor_gate_config
        isHealthyTimeSeconds: "600"
        runOrder: PRE_DEPLOY
        query: (tag:(service:<SERVICE_NAME> AND team:ci-app AND NOT monitor_gate:false))
        scopes:
          - ENV
    - monitorGate: &canary_monitor_gate_config
        isHealthyTimeSeconds: "1200"
        query: (tag:(service:<SERVICE_NAME> AND team:ci-app AND NOT monitor_gate:false))
        scopes: ["CUSTOM_GROUP"]
        matchScopeInstances:
          - canary
    - manualJudgementGate: &manual_judgement_gate_config
        title: "Post Deploy Manual Judgement for <SERVICE_NAME>"
        content: ":judge: *App*: \`<SERVICE_NAME>\`\n *<https://app.datadoghq.com/dashboard/<DASHBOARD_ID>>*\n\n Please check the dashboards for this service and manually verify that it is working correctly for the deployed datacenter.\n\n  Is it safe to continue with the deployment?"
        slack_channel: ci-app-deploys
        timeoutSeconds: 300
        scopes: ["DATACENTER"]
        matchScopeInstances:
          - us1.prod.dog
    - monitorGate: &default_monitor_gate_config
        isHealthyTimeSeconds: "1200"
        query: (tag:(service:<SERVICE_NAME> AND team:ci-app AND NOT monitor_gate:false))
        scopes: ["CUSTOM_GROUP"]
        matchScopeInstances:
          - default
  hooks:
    - kind: common-resources
  k8s:
    name: <SERVICE_NAME>
    namespace: ci-app
  placementProvider:
    name: generic-placements-api-provider
  service: <SERVICE_NAME>
  extensions:
    valuesFilesJs: |
      (req) => {
        let files = glob([\`values/environments/\${req.datacenter.name}.yaml\`]);
        if (req.datacenter.environment !== "staging" && (req.release.includes("org2") || req.release.includes("datadog"))) {
          files = files.concat(glob(["values/environments/canary.yaml"]));
        }
        files = files.concat(glob([\`values/environments/\${req.release}.ci-app.\${req.cluster.name}.\${req.datacenter.name}.yaml\`]));
        return files;
      }

  targets:
    - name: staging
      placement:
        environment: staging
        datacenter_constraints:
          - datacenter_selector:
              names:
                - us1.staging.dog
            resiliency_contract:
              regional:
                cluster_count: 1
      extra:
        slack_channel: ci-app-staging
      gates:
        - monitorGate:
            <<: *scoped_monitor_gate_config

    - name: prod
      placement:
        environment: prod
        datacenter_constraints:
          - datacenter_selector:
              names:
                - prod-site
            cluster_selector:
              reserved: "*"
            resiliency_contract:
              regional:
                cluster_count: 1
      extra:
        slack_channel: ci-app-deploys
      gates:
        - businessHoursGate:
            <<: *business_hours_gate_config
        - sleepGate:
            <<: *default_sleep_gate_config
        - sleepGate:
            <<: *canary_sleep_gate_config
        - monitorGate:
            <<: *scoped_monitor_gate_config
        - monitorGate:
            <<: *canary_monitor_gate_config
        - manualJudgementGate:
            <<: *manual_judgement_gate_config
        - monitorGate:
            <<: *default_monitor_gate_config

    - name: prod/automatic
      placement:
        environment: prod
        datacenter_constraints:
          - datacenter_selector:
              names:
                - prod-site
            cluster_selector:
              reserved: "*"
            resiliency_contract:
              regional:
                cluster_count: 1
      extra:
        slack_channel: ci-app-deploys
      gates:
        - businessHoursGate:
            <<: *business_hours_gate_config
        - sleepGate:
            <<: *default_sleep_gate_config
        - sleepGate:
            <<: *canary_sleep_gate_config
        - monitorGate:
            <<: *scoped_monitor_gate_config
        - monitorGate:
            <<: *canary_monitor_gate_config
        - monitorGate:
            <<: *default_monitor_gate_config

    - name: prod/nowait
      placement:
        environment: prod
        datacenter_constraints:
          - datacenter_selector:
              names:
                - prod-site
            cluster_selector:
              reserved: "*"
            resiliency_contract:
              regional:
                cluster_count: 1
      extra:
        slack_channel: ci-app-deploys
      gates:
        - sleepGate:
            <<: *default_sleep_gate_config
        - sleepGate:
            <<: *canary_sleep_gate_config
        - monitorGate:
            <<: *scoped_monitor_gate_config
        - manualJudgementGate:
            <<: *manual_judgement_gate_config
            scopes: ["CUSTOM_GROUP"]
            matchScopeInstances:
              - default
        - monitorGate:
            <<: *default_monitor_gate_config
            isHealthyTimeSeconds: "0"
```

### Step 2: Update BUILD.bazel

```python
load("//:bazel/ci-app/helpers.bzl", "register_app")

register_app(
    app = "<SERVICE_NAME>",
    additional_deps = [
        "//k8s/ci-app-common-templates:chart",
        "//k8s/evp-workload-common:chart",
    ],
    conductor_dynamic_workflows_enabled = True,
)
```

---

## Non-EVP Workload Services

### Step 1: Create deploy.yaml

Create `k8s/<SERVICE_NAME>/deploy.yaml`:

```yaml
config:
  k8s:
    name: <SERVICE_NAME>
    namespace: ci-app
  service: <SERVICE_NAME>
  hooks:
    - kind: canary
      canaryConfig:
        nameOverride: <SERVICE_NAME>-org2
        strategy: ALLCANARIESFIRST
        filter: cluster.environment != "staging"
  extensions:
    valuesFilesJs: |
      (req) => {
        let files = glob([\`values/environments/\${req.datacenter.name}.yaml\`]);
        if (req.datacenter.environment !== "staging" && (req.release.includes("org2") || req.release.includes("datadog"))) {
          files = files.concat(glob(["values/environments/canary.yaml"]));
        }
        files = files.concat(glob([\`values/environments/\${req.release}.ci-app.\${req.cluster.name}.\${req.datacenter.name}.yaml\`]));
        return files;
      }
  gates:
    - businessHoursGate: &business_hours_gate_config
        preset: EU
        scopeType:
          - ENV
    - monitorGate: &pre_deploy_monitor_gate_config
        isHealthyTimeSeconds: 300
        runOrder: PRE_DEPLOY
        query: tag:(service:<SERVICE_NAME> AND team:ci-app AND NOT monitor_gate:false)
        scopes:
          - ENV
    - manualJudgementGate: &manual_judgement_gate_config
        title: "Post Deploy Manual Judgement for <SERVICE_NAME>"
        content: ":judge: *App*: \`<SERVICE_NAME>\`\n *<https://app.datadoghq.com/dashboard/<DASHBOARD_ID>>*\n\n Please check the dashboards for this service and manually verify that it is working correctly for the deployed datacenter.\n\n  Is it safe to continue with the deployment?"
        slack_channel: ci-app-deploys
        timeoutSeconds: 300
        scopes: ["DATACENTER"]
        runOrder: PRE_DEPLOY
    - sleepGate: &post_deploy_sleep_gate_config
        durationSeconds: 0
        scopes:
          - DATACENTER
        skipScopeInstances:
          - us1.prod.dog
    - monitorGate: &post_deploy_monitor_gate_config
        isHealthyTimeSeconds: 1200
        query: tag:(service:<SERVICE_NAME> AND team:ci-app AND NOT monitor_gate:false)
        scopes:
          - DATACENTER
        skipScopeInstances:
          - us1.prod.dog

  targets:
    - name: staging
      placement:
        datacenter_constraints:
          - datacenter_selector:
              names:
                - us1.staging.dog
            resiliency_contract:
              regional:
                cluster_count: 1
        environment: staging
      extra:
        slackChannel: ci-app-staging
      gates:
        - monitorGate:
            <<: *pre_deploy_monitor_gate_config

    - name: prod
      placement:
        datacenter_constraints:
          - cluster_selector:
              reserved: "*"
            datacenter_selector:
              names:
                - prod-site
            resiliency_contract:
              regional:
                cluster_count: 1
        environment: prod
      extra:
        slackChannel: ci-app-deploys
      gates:
        - businessHoursGate:
            <<: *business_hours_gate_config
        - monitorGate:
            <<: *pre_deploy_monitor_gate_config
        - manualJudgementGate:
            <<: *manual_judgement_gate_config
            matchScopeInstances:
              - ap1.prod.dog
        - sleepGate:
            <<: *post_deploy_sleep_gate_config
        - monitorGate:
            <<: *post_deploy_monitor_gate_config

    - name: prod/automatic
      placement:
        datacenter_constraints:
          - cluster_selector:
              reserved: "*"
            datacenter_selector:
              names:
                - prod-site
            resiliency_contract:
              regional:
                cluster_count: 1
        environment: prod
      extra:
        slackChannel: ci-app-deploys
      gates:
        - businessHoursGate:
            <<: *business_hours_gate_config
        - monitorGate:
            <<: *pre_deploy_monitor_gate_config
        - sleepGate:
            <<: *post_deploy_sleep_gate_config
        - monitorGate:
            <<: *post_deploy_monitor_gate_config

    - name: prod/nowait
      placement:
        datacenter_constraints:
          - cluster_selector:
              reserved: "*"
            datacenter_selector:
              names:
                - prod-site
            resiliency_contract:
              regional:
                cluster_count: 1
        environment: prod
      extra:
        slackChannel: ci-app-deploys
      gates:
        - businessHoursGate:
            <<: *business_hours_gate_config
        - monitorGate:
            <<: *pre_deploy_monitor_gate_config
        - manualJudgementGate:
            <<: *manual_judgement_gate_config
        - sleepGate:
            <<: *post_deploy_sleep_gate_config
        - monitorGate:
            <<: *post_deploy_monitor_gate_config
            isHealthyTimeSeconds: 0
```

### Step 2: Update BUILD.bazel

```python
load("//:bazel/ci-app/helpers.bzl", "register_app")

register_app(
    app = "<SERVICE_NAME>",
    conductor_dynamic_workflows_enabled = True,
)
```

---

## Common Steps (Both EVP and Non-EVP)

### Step 3: Update service.datadog.yaml

Replace `workflows` with `deploy_config`:

```yaml
extensions:
  datadoghq.com/sdp:
    workday_team: <TEAM_NAME>
    conductor:
      targets:
        - name: staging
          slack: "ci-app-staging"
          ci_pipeline: "release:app"
          branch: "ci-app-staging/<SERVICE_NAME>"
          schedule: "* 7-17 * * 1-5"
          options:
            disable_failure_notifications: true
          deploy_config:
            source_path: ./deploy.yaml
            ordered_deploy_targets:
              - staging
        - name: prod
          slack: "ci-app-deploys"
          ci_pipeline: "release:app"
          schedule: "0 8 * * 2"
          deploy_config:
            source_path: ./deploy.yaml
            ordered_deploy_targets:
              - prod/automatic
```

### Step 4: Update .apps.yml (only if service entry exists)

If the service has an entry in `.apps.yml`, add `dynamic_workflows: true`:

```yaml
<SERVICE_NAME>:
  folder: ci-app/apps/<SERVICE_NAME>
  cmd_folder: cmd/<SERVICE_NAME>
  librdkafka_version: 2.5.0
  dynamic_workflows: true # Add this line
```

> **Note:** Only modify `.apps.yml` if your service already has an entry there. If not, skip this step.

### Step 5: Update .dynamic-build.yml (only if service entry exists)

If the service has an entry in `.dynamic-build.yml`, add `USE_DDR` and `DEPLOY_YAML_TARGET` variables:

```yaml
cnab-manifest-diff-<SERVICE_NAME>:
  template: ci/dynamic-build/templates/cnab-manifest-diff.tpl.yml
  variables:
    K8S_CHART_NAME: "<SERVICE_NAME>"
    USE_DDR: "true" # Add this line
    DEPLOY_YAML_TARGET: deploy.yaml # Add this line
  changed:
    - k8s/<SERVICE_NAME>/**
    - bazel/ci-app/**
```

> **Note:** Only modify `.dynamic-build.yml` if your service already has an entry there. If not, skip this step.

---

## Validation

```bash
# Validate deploy.yaml
ddr deploy validate configs ./k8s/<SERVICE_NAME>/deploy.yaml

# Build the chart
bzl build //k8s/<SERVICE_NAME>:ci-chart

# Validate with valuesFilesJs
ddr deploy validate configs ./k8s/<SERVICE_NAME>/deploy.yaml \
  --with-values-files-js \
  --chart bazel-bin/k8s/<SERVICE_NAME>/ci-chart.tgz

# Generate workflows to compare with existing
ddr deploy generate workflow \
  --deploy-config k8s/<SERVICE_NAME>/deploy.yaml \
  --service <SERVICE_NAME> \
  --target prod
```

---

## Key Differences: EVP vs Non-EVP

| Feature               | EVP Workload                                   | Non-EVP Workload                                 |
| --------------------- | ---------------------------------------------- | ------------------------------------------------ |
| **hooks**             | `kind: common-resources`                       | `kind: canary` with canaryConfig                 |
| **placementProvider** | `generic-placements-api-provider`              | Not specified                                    |
| **additional_deps**   | Includes `evp-workload-common:chart`           | None                                             |
| **Gate structure**    | Uses `CUSTOM_GROUP` scopes with canary/default | Uses `DATACENTER` scopes with skipScopeInstances |
| **extra field**       | `slack_channel`                                | `slackChannel`                                   |

---

## Files to Modify Summary

| File                                      | Action                                   | Condition                    |
| ----------------------------------------- | ---------------------------------------- | ---------------------------- |
| `k8s/<SERVICE_NAME>/deploy.yaml`          | Create new                               | Always                       |
| `k8s/<SERVICE_NAME>/BUILD.bazel`          | Update to use `register_app`             | Always                       |
| `k8s/<SERVICE_NAME>/service.datadog.yaml` | Replace `workflows` with `deploy_config` | Always                       |
| `.apps.yml`                               | Add `dynamic_workflows: true`            | Only if service entry exists |
| `.dynamic-build.yml`                      | Add `USE_DDR` and `DEPLOY_YAML_TARGET`   | Only if service entry exists |
