# Corporate Mihomo releases for XKeenUI

## Repositories and branches

- Mihomo source/update repository: `AntonLisovoy/mihomo`, branch `corp/tailscale-1.104.5`.
- Embedded library: `AntonLisovoy/tailscale`, branch `corp/tailscale-1.104.5`, based on official Tailscale `v1.104.5` with ported MetaCubeX network/DNS hooks.
- The `tailscale.com` replacement in `go.mod` pins the exact library commit. No router configuration, state or credentials belong in these repositories.

## Build and release

Go 1.27.3 is required. The dedicated `.github/workflows/corp-release.yml` tests the integration, builds on native Linux ARM64, runs version/config smoke checks and uploads artifacts on branch pushes. On a `corp-v*` tag it also publishes a GitHub prerelease with:

- `mihomo-linux-arm64-<exact-tag>.gz` (XKeenUI naming contract);
- `SHA256SUMS`;
- `build-info.txt` (embedded Go module versions).

Use tags such as `corp-v1.19.33-ts1.104.5.1`. The `corp-` prefix avoids inherited upstream workflows triggered by `v*`. Never dispatch the inherited upstream Build workflow: it includes upstream-specific force pushes and Docker publication.

To build locally on Linux: `scripts/build-corp-release.sh corp-v1.19.33-ts1.104.5.1`.
To publish after branch CI passes: tag the verified commit and push that single tag. GitHub Actions must be enabled for the fork. Prereleases are intentional until corporate connectivity has been validated; promotion is a separate decision.

After validation, set XKeenUI's Mihomo source to `https://github.com/AntonLisovoy/mihomo` and select the desired release. The console `xkeen -um` has its own source settings; changing the UI source does not change those. This repository performs no router deployment.

## Updating upstream

1. Add the upstream remote once: `git remote add upstream https://github.com/MetaCubeX/mihomo.git`.
2. Fetch upstream and tags: `git fetch upstream --tags`.
3. On the corporate branch, merge the selected upstream release/commit. Do not force-sync the customized branch.
4. Preserve the pinned Tailscale replacement, dedicated workflow and corporate tests. Resolve conflicts explicitly.
5. For a Tailscale upgrade, merge the official tag into the companion fork, test and push it, then update Mihomo's replacement to the new immutable commit. Update the version assertion and release title/notes together.
6. Run CI and publish a new corporate tag after checks pass.

## Validation limits

Unit tests and Linux ARM64 smoke tests do not verify the company's Headscale ACLs, enrollment, subnet routes, actual corporate DNS or resource usage on Keenetic. The new library uses official upstream dependencies rather than the former Go 1.20 compatibility forks; binary size and runtime memory can change. Keep the old binary and state backup when a router deployment is separately authorized. Never run two clients concurrently with the same copied state.
