# .gitlab-ci/scripts/test/nodejs/83_lang_nodejs_test.sh # Node.js Test
#!/bin/bash

set -eu

echo "===================================="
echo "Node.js Unit Test Started"
echo "===================================="

mkdir -p reports/test
mkdir -p coverage

npm ci

npm test -- --coverage

if [ -d coverage ]; then
    cp -r coverage reports/test/
fi

echo "Node.js Unit Test Finished"

