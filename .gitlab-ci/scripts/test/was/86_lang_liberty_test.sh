# .gitlab-ci/scripts/test/was/86_lang_liberty_test.sh # Liberty Test
#!/bin/bash

set -eu

echo "===================================="
echo "Liberty Unit Test Started"
echo "===================================="

mkdir -p reports/test
mkdir -p coverage

mvn -B test

if [ -d target/surefire-reports ]; then
    cp -r target/surefire-reports reports/test/
fi

echo "Liberty Unit Test Finished"
