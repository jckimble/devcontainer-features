#!/bin/bash

set -e

source dev-container-features-test-lib

check "version" hledger --version

check "version" hledger-ui --version

check "version" hledger-web --version

reportResults