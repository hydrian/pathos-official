#!/usr/bin/env -S bash
FLATPAK_BUILDER=$(which flatpak-builder)
if [ $? -ne 0 ] ; then
  echo "flatpak-builder is not installed." 1>&2 
  exit 2
fi

SCRIPT_FILE=$(realpath "${0}")
GIT_ROOT_DIR=$(realpath "$(dirname "${SCRIPT_FILE}")/..") 
echo "Building Flatpak image..."
pushd "$GIT_ROOT_DIR" 1>/dev/null
test ! -d .flatpak && mkdir -p .flatpak
"${FLATPAK_BUILDER}" .flatpak/build \
  --ccache \
  --force-clean \
  --state-dir=.flatpak/state \
  --repo=.flatpak/repo  \
  flatpak/net.azurewebsites.pathos.yml \
  --install \
  --user
if [ $? -ne 0 ] ; then
  echo "Failed to build image" 1>&2
  exit 2
fi
popd 1>/dev/null
echo "Flatpak image built successfully"
exit 0
