#!/usr/bin/env bash
set -euo pipefail

rpmdev-setuptree

if [[ ! -d /opentrack ]]; then
	echo "ERROR: expected /opentrack to exist (mounted submodule source)."
	exit 1
fi

if [[ ! -f /opentrack/CMakeLists.txt ]]; then
	echo "ERROR: /opentrack doesn't look like the opentrack source (missing CMakeLists.txt)."
	exit 1
fi

: "${OPENTRACK_VERSION:?ERROR: set OPENTRACK_VERSION (e.g. 1.3.13)}"

# Spec path (mounted by default)
SPEC_PATH="/spec/opentrack.spec"
if [[ ! -f "$SPEC_PATH" ]]; then
	echo "ERROR: spec file not found at $SPEC_PATH"
	exit 1
fi

# Create source tarball for rpmbuild (must match Source0 in spec)
cd /
TARBALL="opentrack-${OPENTRACK_VERSION}.tar.gz"
tar -czf "/root/rpmbuild/SOURCES/${TARBALL}" opentrack

rpmbuild \
	--define "_topdir /root/rpmbuild" \
	--define "opentrack_version ${OPENTRACK_VERSION}" \
	-ba "$SPEC_PATH"

mkdir -p /out
find /root/rpmbuild/RPMS -name "*.rpm" -exec cp -v {} /out/ \;
find /root/rpmbuild/SRPMS -name "*.src.rpm" -exec cp -v {} /out/ \;

echo "RPMs are in /out"
ls -la /out
