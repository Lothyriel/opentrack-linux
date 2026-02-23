Name:           opentrack
Version:        %{opentrack_version}
Release:        1%{?dist}
Summary:        Head tracking software

License:        GPL-3.0-or-later
URL:            https://github.com/opentrack/opentrack
Source0:        %{name}-%{version}.tar.gz

BuildRequires:  git
BuildRequires:  cmake
BuildRequires:  gcc-c++
BuildRequires:  make
BuildRequires:  opencv-devel
BuildRequires:  onnxruntime-devel
BuildRequires:  procps-ng-devel
BuildRequires:  qt6-qtbase-devel
BuildRequires:  qt6-qttools-devel
BuildRequires:  qt6-qtbase-private-devel
BuildRequires:  wine-devel

Requires:       opencv
Requires:       onnxruntime
Requires:       procps-ng
Requires:       qt6-qtbase
Requires:       qt6-qttools

%description
opentrack is a head tracking application that relays head movement to games/sims.

%prep
%autosetup -n opentrack

%build
%cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=%{_prefix} \
  -DCMAKE_INSTALL_LIBDIR=%{_lib} \
  -DSDK_WINE=ON \
  -DOPENTRACK_WINE_ARCH=-m64
%cmake_build

%install
%cmake_install

%files
%license OPENTRACK-LICENSING.txt
%doc %{_docdir}/opentrack/

# main binary (keep this if it exists; see note below)
%{_bindir}/opentrack
%{_datadir}/opentrack/
%{_libexecdir}/opentrack/

%changelog
* Mon Feb 23 2026 Container Builder <builder@local> - %{version}-1
- Container-built RPM
