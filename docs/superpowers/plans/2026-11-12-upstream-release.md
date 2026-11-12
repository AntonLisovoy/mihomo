# Upstream v1.19.34 corporate release

Goal: merge MetaCubeX/mihomo v1.19.34 into corp/tailscale-1.104.5 and publish corp-v1.19.34-ts1.104.5.1 through the existing corporate ARM64 prerelease workflow.

Architecture: merge the upstream tag, retaining the corporate Tailscale implementation, tests, workflow, and immutable dependency replacement. No router deployment.

- [x] Inspect upstream and corporate history; identify changes and dependency conflicts.
- [x] Merge v1.19.34; take updated upstream dependencies while retaining tailscale.com v1.104.5 replaced by github.com/AntonLisovoy/tailscale v0.0.0-20261109121409-dae89864edf3.
- [x] Run corporate version/route tests, Tailscale integration tests, tests for upstream changes, and native/config plus ARM64 build checks.
- [x] Review the merged diff against upstream and corporate commits; commit and push corporate branch.
- [x] Confirm branch CI passes, push the single corporate release tag, and verify the published prerelease and its assets.

Validation limits: do not infer actual Headscale/router connectivity from unit tests. Do not dispatch inherited upstream release workflows. Preserve corporate Tailscale without downgrading or substituting a version string.

## Follow-up: main and ordinary upstream version tags

The user requested integration through a PR into our main and a normal release tagged v1.19.34. Preserve Tailscale 1.104.5 and the immutable fork replacement.

- [x] Reconcile unrelated histories by merging the previous main as an ancestor while retaining the corporate tree; do not force-update main.
- [x] Enable corporate CI for main pushes and PRs; support stable vX.Y.Z releases and retain legacy corp prereleases. Test ordinary version tags on branch builds with v0.0.0.
- [x] Guard every inherited upstream build/test/CMFA job to MetaCubeX/mihomo so our v tag cannot run upstream publishing or dispatch operations.
- [x] Update release documentation; validate shell/YAML and run local Snell/inbound tests. Full local builds still require storage.googleapis.com network access.
- [ ] Review and push the branch, create a PR to main, and merge after its required checks pass.
- [ ] Tag our tested main merge commit as v1.19.34 (not the upstream commit), publish through CI, and verify the release classification, checksums, and embedded Tailscale dependency.
