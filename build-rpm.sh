#!/usr/bin/env bash
set -euo pipefail

rpmdev-setuptree

: "${OPENTRACK_VERSION:?ERROR: set OPENTRACK_VERSION (e.g. 2016.1.0)}"

# Spec path (mounted by default)
SPEC_PATH="/spec/opentrack.spec"
if [[ ! -f "$SPEC_PATH" ]]; then
	echo "ERROR: spec file not found at $SPEC_PATH"
	exit 1
fi

if [[ ! -d /opentrack ]]; then
	echo "ERROR: expected /opentrack to exist (mounted submodule source)."
	exit 1
fi

if [[ ! -f /opentrack/CMakeLists.txt ]]; then
	echo "ERROR: /opentrack doesn't look like the opentrack source (missing CMakeLists.txt)."
	exit 1
fi

# Create a spec that is self-contained (survives COPR SRPM rebuild)
SPEC_TMP="/tmp/opentrack.spec"
{
	echo "%global opentrack_version ${OPENTRACK_VERSION}"
	cat "$SPEC_PATH"
} >"$SPEC_TMP"

# Create source tarball for rpmbuild (must match Source0 in spec)
cd /
TARBALL="opentrack-${OPENTRACK_VERSION}.tar.gz"
tar -czf "/root/rpmbuild/SOURCES/${TARBALL}" opentrack

rpmbuild \
	--define "_topdir /root/rpmbuild" \
	-ba "$SPEC_TMP"

mkdir -p /out
find /root/rpmbuild/RPMS -name "*.rpm" -exec cp -v {} /out/ \;
find /root/rpmbuild/SRPMS -name "*.src.rpm" -exec cp -v {} /out/ \;

echo "RPMs are in /out"
ls -la /out
