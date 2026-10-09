# .gitlab-ci/scripts/startup/java/91_start_tomcat.sh # Tomcat起動
#!/bin/bash

set -eu

echo "===================================="
echo "Tomcat Startup Started"
echo "===================================="

: "${CATALINA_HOME:?CATALINA_HOME not set}"

rm -f startup.log app.pid

"${CATALINA_HOME}/bin/startup.sh"

sleep 10

PID=$(pgrep -f "org.apache.catalina.startup.Bootstrap" | head -1)

if [ -z "${PID}" ]; then

    echo "Tomcat startup failed"

    exit 1

fi

echo "${PID}" > app.pid

echo "Tomcat PID=${PID}" | tee startup.log

