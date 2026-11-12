# Tailscale 1.104.5 and XKeenUI releases

Goal: retain embedded corporate networking while updating actual Tailscale code to 1.104.5; no router changes.

Architecture: maintain a companion fork of MetaCubeX/tailscale, pin its commit in Mihomo, and publish ARM64 gzip artifacts through a dedicated workflow. Keep upstream branches intact.

- [x] Merge official 1.104.5 changes into the Tailscale fork, retaining MetaCubeX network/DNS hooks; compile and test affected packages.
- [x] Pin published dependency commit in Mihomo; build with with_gvisor for Linux ARM64 and run relevant native tests.
- [x] Add a dedicated release workflow with checksums and XKeenUI-compatible asset names; prevent inherited broad release jobs from handling corporate tags.
- [ ] Document upstream maintenance, verify remote branches and CI, publish an explicitly marked prerelease if CI passes.

Validation boundaries: compilation and unit tests do not prove connectivity to corporate Headscale. Never run two clients using the router state; do not copy credentials into repositories. Preserve an honest embedded version, not just a version-string bump.
