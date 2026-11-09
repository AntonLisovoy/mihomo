#!/usr/bin/env bash
set -euo pipefail
version=${1:?Usage: build-corp-release.sh corp-vVERSION}
[[ "$version" =~ ^corp-v[0-9][A-Za-z0-9._-]*$ ]] || { echo 'Invalid corporate release tag' >&2; exit 2; }
export CGO_ENABLED=0
mkdir -p dist
build_time=$(git show -s --format=%cI HEAD)
GOOS=linux GOARCH=arm64 go build -mod=readonly -trimpath -tags with_gvisor \
  -ldflags "-s -w -X github.com/metacubex/mihomo/constant.Version=$version -X github.com/metacubex/mihomo/constant.BuildTime=$build_time" \
  -o dist/mihomo .
gzip -n -c dist/mihomo > "dist/mihomo-linux-arm64-$version.gz"
go version -m dist/mihomo > dist/build-info.txt
(cd dist && sha256sum "mihomo-linux-arm64-$version.gz" > SHA256SUMS)
rm dist/mihomo
