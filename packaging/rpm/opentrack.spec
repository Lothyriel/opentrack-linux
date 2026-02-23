Name:           opentrack
Version:        %{?opentrack_version: %{opentrack_version}}%{!?opentrack_version: 0.0}
Release:        1%{?dist}
Summary:        Head tracking software

License:        GPL-3.0-or-later
URL:            https://github.com/opentrack/opentrack
Source0:        %{name}-%{version}.tar.gz

BuildRequires:  cmake
BuildRequires:  gcc-c++
BuildRequires:  make
BuildRequires:  opencv-devel
BuildRequires:  procps-ng-devel
BuildRequires:  qt6-qtbase-devel
BuildRequires:  qt6-qttools-devel
BuildRequires:  qt6-qtbase-private-devel

Requires:       opencv
Requires:       procps-ng
Requires:       qt6-qtbase
Requires:       qt6-qttools

%description
opentrack is a head tracking application that relays head movement to games/sims.

%prep
%autosetup -n opentrack

%build
%cmake -DCMAKE_BUILD_TYPE=Release
%cmake_build

%install
%cmake_install

%files
%license OPENTRACK-LICENSING.txt
%doc README*
%{_bindir}/opentrack
%{_libdir}/opentrack/*.so

%changelog
* Mon Feb 23 2026 Container Builder <builder@local> - %{version}-1
- Container-built RPM
