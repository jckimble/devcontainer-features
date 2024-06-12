#!/bin/sh
set -e
NGROK_VERSION="${VERSION:-"latest"}"
scriptUrl=https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-${NGROK_VERSION}-linux-amd64
outFile=/usr/bin/ngrok

# Checks if packages are installed and installs them if not
check_packages() {
    if ! dpkg -s "$@" > /dev/null 2>&1; then
        if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
            echo "Running apt-get update..."
            apt-get update -y
        fi
        apt-get -y install --no-install-recommends "$@"
    fi
}

export DEBIAN_FRONTEND=noninteractive

check_packages curl ca-certificates

curl "${scriptUrl}" -o $outFile

rm -rf /var/lib/apt/lists/*

chmod +x ${outFile}