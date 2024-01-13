#!/bin/sh
set -e
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

check_packages curl ca-certificates unzip tar

cd /usr/local/bin
curl -OL https://github.com/simonmichael/hledger/releases/latest/download/hledger-linux-x64.zip
unzip hledger-linux-x64.zip
tar xf hledger-linux-x64.tar
rm -f hledger-linux-x64.zip

rm -rf /var/lib/apt/lists/*

chmod +x hledger hledger-ui hledger-web