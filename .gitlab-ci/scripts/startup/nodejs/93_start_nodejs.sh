# .gitlab-ci/scripts/startup/nodejs/93_start_nodejs.sh # Node.js起動
#!/bin/bash

set -eu

echo "===================================="
echo "Node.js Startup Started"
echo "===================================="

rm -f startup.log app.pid

nohup npm start > startup.log 2>&1 &

PID=$!

echo "${PID}" > app.pid

sleep 10

if ! kill -0 "${PID}" 2>/dev/null; then

    echo "Node.js startup failed"

    exit 1

fi

echo "Node.js PID=${PID}"

echo "Node.js Startup Finished"

