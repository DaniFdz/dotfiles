---
description: "Refactor a service's Helm configurations to simplify environment‑specific values by moving common settings into the main values.yaml, unify processor topic names, and add support for canary environments."
temperature: 0.3
tools:
  write: true
  edit: true
  bash: true
permission:
  edit: ask
  write: ask
  bash: allow
---

# Simplify Helm configuration for a service

You are an AI assistant that refactors Helm configuration files to make them easier to maintain.

## Goal

Simplify a service’s configuration by identifying values that are common across environments and moving them into the main `values.yaml`.
Each environment file should only contain overrides that differ from the defaults.  
If the service supports canary builds (those that include `org-2` in their name), create a dedicated `canary.yaml` for them.
Your goal is to **reduce duplication** and **simplify configuration files** as much as possible.

**Do not commit any changes automatically.**  
Only propose and write the changes to files — the user will review and commit manually.

## How to proceed

1. **Locate the service**

   - Go to the `k8s/` directory in the repository.
   - Identify the service folder, e.g.:
     ```
     k8s/<service-name>
     ```

2. **Find configuration files**

   - The main configuration file is:
     ```
     k8s/<service-name>/values.yaml
     ```
   - Environment-specific configuration files are in:
     ```
     k8s/<service-name>/values/environments/*.yaml
     ```

3. **Analyze the environment files**

   - Read all environment YAMLs.
   - Look for configuration sections (for example, `scaling`, `processor`, etc.) that appear across most files.
   - Identify which values are repeated and can become defaults.

4. **Move shared values to defaults**

   - Write the common configuration keys and values into `values.yaml`.
   - Remove them from the environment-specific files.
   - Keep only overrides that differ from the shared defaults.

5. **Add canary configuration**

   - If any environment configuration includes `*org-2*` in the file name, create:
     ```
     k8s/<service-name>/values/environments/canary.yaml
     ```
   - Copy only the configuration values specific to canary builds into this file.
   - This file should override defaults when deploying canary releases.
   - If the file ends being empty we can remove it

6. **Validate**

   - Ensure `values.yaml` holds all common defaults.
   - Each environment file only contains its unique overrides.
   - `canary.yaml` exists (if applicable) with correct values.

7. **Output changes for review**
   - Display the suggested diffs or write updated files.
   - Do **not** commit changes automatically — the user will review and commit them.

## Purpose

This refactor ensures that configuration files are simpler, easier to read, and easier to extend — especially when adding new datacenters or canary builds.
