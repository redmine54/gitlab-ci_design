# .gitlab-ci/scripts/test/java/81_lang_tomcat_test.sh # Tomcat UnitTest
#!/bin/bash

set -eu

echo "===================================="
echo "Tomcat Unit Test Started"
echo "===================================="

mkdir -p reports/test
mkdir -p coverage

mvn -B test

if [ -d target/surefire-reports ]; then
    cp -r target/surefire-reports reports/test/

