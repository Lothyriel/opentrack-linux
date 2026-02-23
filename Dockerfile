FROM fedora:43

LABEL org.opencontainers.image.source https://github.com/Lothyriel/opentrack-linux

RUN dnf -y update && dnf -y install \
  --setopt=install_weak_deps=0 \
  --setopt=tsflags=nodocs \
  git ca-certificates \
  cmake make gcc-c++ \
  rpm-build rpmdevtools \
  qt6-qtbase-devel qt6-qttools-devel qt6-qtbase-private-devel \
  opencv-devel onnxruntime-devel \
  wine wine-devel \
  procps-ng-devel \
  tar gzip findutils \
  && dnf clean all

WORKDIR /work
COPY build-rpm.sh /work/build-rpm.sh
RUN chmod +x /work/build-rpm.sh

CMD ["/work/build-rpm.sh"]
