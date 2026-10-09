# .gitlab-ci/scripts/test/was/85_lang_was_test.sh # WAS Test
#!/bin/bash

set -eu

echo "===================================="
echo "WAS Unit Test Started"
echo "===================================="

mkdir -p reports/test
mkdir -p coverage

mvn -B test

if [ -d target/surefire-reports ]; then
    cp -r target/surefire-reports reports/test/
fi

echo "WAS Unit Test Finished"

