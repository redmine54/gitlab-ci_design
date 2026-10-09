# .gitlab-ci/scripts/startup/java/92_start_springboot.sh # SpringBoot起動
#!/bin/bash

set -eu

echo "===================================="
echo "SpringBoot Startup Started"
echo "===================================="

rm -f startup.log app.pid

JAR_FILE=$(find build-output target -name "*.jar" 2>/dev/null | head -1)

if [ -z "${JAR_FILE}" ]; then

    echo "JAR file not found"

    exit 1

fi

nohup java -jar "${JAR_FILE}" > startup.log 2>&1 &

PID=$!

echo "${PID}" > app.pid

sleep 10

if ! kill -0 "${PID}" 2>/dev/null; then

    echo "SpringBoot startup failed"

    exit 1

fi

echo "SpringBoot PID=${PID}"

echo "SpringBoot Startup Finished"

