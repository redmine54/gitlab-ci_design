# .gitlab-ci/scripts/notify/124_notify_teams.sh # Teams通知
#!/bin/bash

set -eu

echo "===================================="
echo "Teams Notification"
echo "===================================="

: "${NOTIFY_TEAMS_WEBHOOK:?NOTIFY_TEAMS_WEBHOOK not set}"

STATUS_FILE="reports/notify/pipeline-status.txt"

PIPELINE_RESULT="UNKNOWN"

if [ -f "${STATUS_FILE}" ]; then

    PIPELINE_RESULT=$(grep PIPELINE_RESULT "${STATUS_FILE}" \
        | cut -d '=' -f2)

fi

cat > reports/notify/teams-message.json << EOF
{
  "text": "Pipeline Result: ${PIPELINE_RESULT}\nApplication: ${APP_NAME:-UNKNOWN}\nEnvironment: ${DEPLOY_ENV:-UNKNOWN}\nPipeline: ${CI_PIPELINE_ID:-UNKNOWN}"
}
EOF

curl \
  -H "Content-Type: application/json" \
  -d @reports/notify/teams-message.json \
  "${NOTIFY_TEAMS_WEBHOOK}"

echo "Teams Notification Sent"

