#!/usr/bin/env -S bash -x
FLATPAK_BIN=$(which flatpak)
if [ $? -ne 0 ] ; then
  echo "flatpak is not installed." 1>&2 
  exit 2
fi
FLATPAK_BUILDER=$(which flatpak-builder)
if [ $? -ne 0 ] ; then
  echo "flatpak-builder is not installed." 1>&2 
  exit 2
fi

SCRIPT_FILE=$(realpath "${0}")
GIT_ROOT_DIR=$(realpath "$(dirname "${SCRIPT_FILE}")/..") 
echo "Building Flatpak image..."
pushd "$GIT_ROOT_DIR" 1>/dev/null
flatpak-builder .flatpak-build --ccache --force-clean --repo=./flatpak-repo  flatpak/net.azurewebsites.pathos.yml --install --user
popd 1>/dev/null
echo "Flatpak image built successfully"
exit 0
