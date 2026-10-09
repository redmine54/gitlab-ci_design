# .gitlab-ci/scripts/test/python/84_lang_python_test.sh # Python Test
#!/bin/bash

set -eu

echo "===================================="
echo "Python Unit Test Started"
echo "===================================="

mkdir -p reports/test
mkdir -p coverage

pytest \
  --junitxml=reports/test/junit.xml \
  --cov=. \
  --cov-report=html:coverage

echo "Python Unit Test Finished"

