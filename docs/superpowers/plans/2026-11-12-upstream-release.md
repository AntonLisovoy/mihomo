# Upstream v1.19.34 corporate release

Goal: merge MetaCubeX/mihomo v1.19.34 into corp/tailscale-1.104.5 and publish corp-v1.19.34-ts1.104.5.1 through the existing corporate ARM64 prerelease workflow.

Architecture: merge the upstream tag, retaining the corporate Tailscale implementation, tests, workflow, and immutable dependency replacement. No router deployment.

- [x] Inspect upstream and corporate history; identify changes and dependency conflicts.
- [x] Merge v1.19.34; take updated upstream dependencies while retaining tailscale.com v1.104.5 replaced by github.com/AntonLisovoy/tailscale v0.0.0-20261109121409-dae89864edf3.
- [ ] Run corporate version/route tests, Tailscale integration tests, tests for upstream changes, and native/config plus ARM64 build checks.
- [ ] Review the merged diff against upstream and corporate commits; commit and push corporate branch.
- [ ] Confirm branch CI passes, push the single corporate release tag, and verify the published prerelease and its assets.

Validation limits: do not infer actual Headscale/router connectivity from unit tests. Do not dispatch inherited upstream release workflows. Preserve corporate Tailscale without downgrading or substituting a version string.
