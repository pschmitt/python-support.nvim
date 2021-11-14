#!/usr/bin/env bash

usage() {
  echo "Usage: $(basename "$0") [--python PYTHON_EXE] [--venv] [--venv-name NAME]"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
  set -ex

  cd "$(cd "$(dirname "$0")" >/dev/null 2>&1; pwd -P)" || exit 9

  echo "Initializing python3 virtualenv for neovim" >&2

  while [[ -n "$*" ]]
  do
      case "$1" in
        help|h|-h|--help)
          usage
          exit 0
          ;;
        -p|--python)
          python_exec="$2"
          shift 2
          ;;
        --venv-sys|--sys|--system-site-packages)
          venv_sys=1
          shift
          ;;
        --venv-name|--virtualenv-name)
          venv_name="$2"
          shift 2
          ;;
        *)
          break
          ;;
      esac
  done

  python_exec="${python_exec:-python3}"
  venv_name="${venv_name:-venv}"

  rm -rf "$venv_name"
  args=()
  if [[ -n "$venv_sys" ]]
  then
    args+=(--system-site-packages)
  fi
  "$python_exec" -m venv "${args[@]}" "$venv_name"
  # shellcheck: disable 1091
  source "${venv_name}/bin/activate"

  pip install -U pip
  pip install wheel
  pip install "$@"

  echo "python_support: venv installation completed" >&2
fi

# vim: set ft=sh et ts=2 sw=2 :
