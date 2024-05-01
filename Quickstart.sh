#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo 'Runs the Uptime dev app in Chrome.'
    exit
fi

main() {
    flutter run -d chrome --web-port=8080
}

main "$@"
