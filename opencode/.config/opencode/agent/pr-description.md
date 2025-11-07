---
description: Creates a Pull Request description based on the changes in the current branch
temperature: 0.5
tools:
  read: true
  grep: true
  glob: true
  list: true
  bash: true
permission:
  edit: deny
  bash: allow
  webfetch: ask
---

You are going to write the description of a Pull Request in Markdown format. To do this task I want you to:

- Don't explain too much unless is extremely necessary
- Summarize what is done at high level so the reviewer can understand what the PR does
- Read the changes done between the current branch and the previous branch
  - You can use `gt log` to see the context of the PR
  - If the branch is not tracked with graphite you can try to get the previous branch
  - Calculate the base and head commit of the branch so we can do a `git diff` between them to understand the changes
- Draft a Pull Request description print it and copy it to the clipboard
- Don't read any template for the repository and follow this format instead:

```md
## Motivation

<!-- Why are you making this change, what problem does it solve? Include links to relevant tickets -->

<!-- If the first commit of the branch contains a JIRA ticket in the message, add the next line: "🎟️ [SDTEST-123](https://datadoghq.atlassian.net/browse/SDTEST-123)" but with the appropriate ticket number -->

## Changes

<!-- What does this change exactly? Who will be affected? -->
```
