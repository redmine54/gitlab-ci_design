# .gitlab-ci/scripts/notify/122_notify_failure.sh # 失敗通知
#!/bin/bash

set -eu

echo "===================================="
echo "Failure Notification"
echo "===================================="

mkdir -p reports/notify

STATUS="FAILURE"

cat > reports/notify/failure-notify.txt << EOF
RESULT=${STATUS}
APP_NAME=${APP_NAME:-UNKNOWN}
APP_TYPE=${APP_TYPE:-UNKNOWN}
DEPLOY_ENV=${DEPLOY_ENV:-UNKNOWN}
RELEASE_VERSION=${RELEASE_VERSION:-UNKNOWN}
CI_PIPELINE_ID=${CI_PIPELINE_ID:-UNKNOWN}
CI_COMMIT_SHA=${CI_COMMIT_SHA:-UNKNOWN}
CI_COMMIT_TAG=${CI_COMMIT_TAG:-N/A}
DATE=$(date)
EOF

echo "Failure Notification Generated"

