# Corporate Mihomo releases for XKeenUI

## Repositories and branches

- Mihomo source/update repository: `AntonLisovoy/mihomo`. The release branch is `main`; changes are integrated through pull requests from `corp/tailscale-1.104.5`.
- Embedded library: `AntonLisovoy/tailscale`, branch `corp/tailscale-1.104.5`, based on official Tailscale `v1.104.5` with ported MetaCubeX network/DNS hooks.
- The `tailscale.com` replacement in `go.mod` pins the exact library commit. No router configuration, state or credentials belong in these repositories.

## Build and release

Go 1.27.3 is required. The dedicated `.github/workflows/corp-release.yml` tests the integration, builds on native Linux ARM64, runs version/config smoke checks and uploads artifacts on pushes and pull requests to `main` and the corporate branch. A `vX.Y.Z` tag publishes a normal GitHub release marked as latest. Legacy `corp-v*` tags still publish prereleases. Both include:

- `mihomo-linux-arm64-<exact-tag>.gz` (XKeenUI naming contract);
- `SHA256SUMS`;
- `build-info.txt` (embedded Go module versions).

Use the same version tag as the selected upstream release, such as `v1.19.34`, but tag the verified merge commit on our `main`, including the corporate Tailscale changes. Do not push the upstream tag object: its commit omits our customizations. Existing tags and prereleases remain unchanged.

The inherited Build, Test and Trigger CMFA Update workflows are guarded to run only in `MetaCubeX/mihomo`. They do not run their upstream-specific build matrix, force pushes, Docker publication or external dispatches in this fork. The corporate workflow owns releases here.

To build locally on Linux: `scripts/build-corp-release.sh v1.19.34`.
To publish: merge the corporate branch into `main` through a PR, wait for CI on the merge commit, create the version tag at that commit and push that single tag. GitHub Actions must be enabled for the fork. Stable release classification does not establish router or corporate Headscale connectivity.

After validation, set XKeenUI's Mihomo source to `https://github.com/AntonLisovoy/mihomo` and select the desired release. The console `xkeen -um` has its own source settings; changing the UI source does not change those. This repository performs no router deployment.

## Updating upstream

1. Add the upstream remote once: `git remote add upstream https://github.com/MetaCubeX/mihomo.git`.
2. Fetch upstream and tags: `git fetch upstream --tags`.
3. On the corporate branch, merge the selected upstream release/commit. Do not force-sync the customized branch.
4. Preserve the pinned Tailscale replacement, dedicated workflow and corporate tests. Resolve conflicts explicitly.
5. For a Tailscale upgrade, merge the official tag into the companion fork, test and push it, then update Mihomo's replacement to the new immutable commit. Update the version assertion and release title/notes together.
6. Open a PR into `main`; merge after CI passes. Publish the selected upstream version tag at our tested merge commit.

## Validation limits

Unit tests and Linux ARM64 smoke tests do not verify the company's Headscale ACLs, enrollment, subnet routes, actual corporate DNS or resource usage on Keenetic. The new library uses official upstream dependencies rather than the former Go 1.20 compatibility forks; binary size and runtime memory can change. Keep the old binary and state backup when a router deployment is separately authorized. Never run two clients concurrently with the same copied state.
