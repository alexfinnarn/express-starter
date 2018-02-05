#!/bin/sh

# Start Sauce Connect Proxy.
/app/sauce_labs/bin/sc -u ${SAUCE_USERNAME} -k ${SAUCE_ACCESS_KEY} > /dev/null 2>&1 &

# Need to wait until it starts somehow.
# Usually starts on port 4445.
nc -zvv 127.0.0.1 4445; out=$?; while [[ $out -ne 0 ]]; do echo "Retry hit port 8057..."; nc -zvv localhost 8057; out=$?; sleep 5; done

# Run tests.
/app/profiles/express/tests/behat/bin/behat -c behat.local.yml --verbose --tags '~@exclude_all_bundles&&~broken'
