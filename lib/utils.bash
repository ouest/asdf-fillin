#!/usr/bin/env bash

set -euo pipefail

readonly github_repository_url="https://github.com/itchyny/fillin"
readonly tool_name="fillin"

fail() {
  echo -e "asdf-${tool_name}: $*"
  exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token ${GITHUB_API_TOKEN}")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "${github_repository_url}" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//'
}

list_all_versions() {
  list_github_tags
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3/bin"

  if [ "${install_type}" != "version" ]; then
    fail "asdf-${tool_name} supports release installs only"
  fi

  local platform
  local ext
  case "$OSTYPE" in
  darwin*)
    platform="darwin"
    ext="zip"
    ;;
  linux*)
    platform="linux"
    ext="tar.gz"
    ;;
  *)
    fail "Unsupported platform"
    ;;
  esac

  local architecture
  case "$(uname -m)" in
  x86_64)
    architecture="amd64"
    ;;
  arm64)
    architecture="arm64"
    ;;
  *)
    fail "Unsupported architecture"
    ;;
  esac

  local download_filename="${install_path}/${tool_name}-${version}.${ext}"
  (
    mkdir -p "${install_path}"

    local url="${github_repository_url}/releases/download/v${version}/${tool_name}_v${version}_${platform}_${architecture}.${ext}"
    curl "${curl_opts[@]}" -o "${download_filename}" -C - "${url}" || fail "Could not download ${url}"
    if [ "${ext}" == "tar.gz" ]; then
      tar -xzf "${download_filename}" -C "${install_path}" --strip-components=1 || fail "Could not extract ${download_filename}"
    elif [ "${ext}" == "zip" ]; then
      unzip -j "${download_filename}" -d "${install_path}" || fail "Could not extract ${download_filename}"
    fi
    rm "${download_filename}"

    chmod +x "${install_path}/${tool_name}"
    test -x "${install_path}/${tool_name}" || fail "Expected ${install_path}/${tool_name} to be executable."

    echo "${tool_name} ${version} installation was successful!"
  ) || (
    rm -rf "${install_path}"
    fail "An error ocurred while installing ${tool_name} ${version}."
  )
}
