# .gitlab-ci/scripts/startup/was/95_start_was.sh # WAS起動
#!/bin/bash

set -eu

echo "===================================="
echo "WAS Startup Started"
echo "===================================="

: "${WAS_PROFILE:?WAS_PROFILE not set}"

rm -f startup.log app.pid

"${WAS_PROFILE}/bin/startServer.sh" server1 \
  > startup.log 2>&1

sleep 20

echo "WAS Startup Finished"

echo "WAS_SERVER=server1" > app.pid

