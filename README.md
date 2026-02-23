# opentrack-linux

This repository packages [opentrack](https://github.com/opentrack/opentrack) for Fedora/COPR and includes:

- RPM spec files
- A containerized RPM build workflow
- Scripts used to produce binary RPMs and SRPMs

The upstream application, opentrack, is head-tracking software used with flight simulators and games.

## Install from COPR (Fedora)

Enable the COPR repository:

```bash
sudo dnf copr enable lothyriel/opentrack
```

Then install:

```bash
sudo dnf install opentrack
```

## Build RPMs locally (container)

This project includes a Fedora-based container build path via `Dockerfile` and `build-rpm.sh`.
Set `OPENTRACK_VERSION`, mount the upstream `opentrack` source, and run the build script in the container to generate RPMs/SRPMs.

## Repository layout

- `packaging/rpm/opentrack.spec`: RPM package definition
- `build-rpm.sh`: build entrypoint used in container
- `Dockerfile`: reproducible Fedora build environment
- `opentrack/`: upstream source tree (submodule/content)
