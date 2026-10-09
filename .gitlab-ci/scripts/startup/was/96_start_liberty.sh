# .gitlab-ci/scripts/startup/was/96_start_liberty.sh # Liberty起動
#!/bin/bash

set -eu

echo "===================================="
echo "Liberty Startup Started"
echo "===================================="

: "${WLP_HOME:?WLP_HOME not set}"

SERVER_NAME="${LIBERTY_SERVER_NAME:-defaultServer}"

rm -f startup.log app.pid

"${WLP_HOME}/bin/server" start "${SERVER_NAME}" \
  > startup.log 2>&1

sleep 10

echo "${SERVER_NAME}" > app.pid

echo "Liberty Server=${SERVER_NAME}"

echo "Liberty Startup Finished"

