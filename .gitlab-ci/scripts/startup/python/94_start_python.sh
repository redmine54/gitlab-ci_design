# .gitlab-ci/scripts/startup/python/94_start_python.sh # Python起動
#!/bin/bash

set -eu

echo "===================================="
echo "Python Startup Started"
echo "===================================="

rm -f startup.log app.pid

APP_FILE="${APP_FILE:-app.py}"

if [ ! -f "${APP_FILE}" ]; then

    echo "Python entrypoint not found: ${APP_FILE}"

    exit 1

fi

nohup python "${APP_FILE}" > startup.log 2>&1 &

PID=$!

echo "${PID}" > app.pid

sleep 10

if ! kill -0 "${PID}" 2>/dev/null; then

    echo "Python startup failed"

    exit 1

fi

echo "Python PID=${PID}"

echo "Python Startup Finished"

