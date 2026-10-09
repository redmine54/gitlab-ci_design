# .gitlab-ci/scripts/notify/125_notify_release.sh # リリース通知
#!/bin/bash

set -eu

echo "===================================="
echo "Release Notification"
echo "===================================="

if [ -z "${CI_COMMIT_TAG:-}" ]; then

    echo "Release notification skipped"

    exit 0

fi

mkdir -p reports/notify

cat > reports/notify/release-notify.txt << EOF
RELEASE_VERSION=${RELEASE_VERSION:-UNKNOWN}

CI_COMMIT_TAG=${CI_COMMIT_TAG}

APP_NAME=${APP_NAME:-UNKNOWN}

APP_TYPE=${APP_TYPE:-UNKNOWN}

DEPLOY_ENV=${DEPLOY_ENV:-UNKNOWN}

CI_PIPELINE_ID=${CI_PIPELINE_ID:-UNKNOWN}

CI_COMMIT_SHA=${CI_COMMIT_SHA:-UNKNOWN}

DATE=$(date)
EOF

echo "Release Notification Generated"

