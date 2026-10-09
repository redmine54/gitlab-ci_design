# .gitlab-ci/scripts/notify/123_notify_mail.sh # メール通知
#!/bin/bash

set -eu

echo "===================================="
echo "Mail Notification"
echo "===================================="

: "${NOTIFY_MAIL_TO:?NOTIFY_MAIL_TO not set}"

STATUS_FILE="reports/notify/pipeline-status.txt"

PIPELINE_RESULT="UNKNOWN"

if [ -f "${STATUS_FILE}" ]; then

    PIPELINE_RESULT=$(grep PIPELINE_RESULT "${STATUS_FILE}" \
        | cut -d '=' -f2)

fi

cat > reports/notify/mail-message.txt << EOF
To: ${NOTIFY_MAIL_TO}

Pipeline Result: ${PIPELINE_RESULT}

Application: ${APP_NAME:-UNKNOWN}
Type: ${APP_TYPE:-UNKNOWN}
Environment: ${DEPLOY_ENV:-UNKNOWN}

Pipeline:
${CI_PIPELINE_ID:-UNKNOWN}

Commit:
${CI_COMMIT_SHA:-UNKNOWN}

Tag:
${CI_COMMIT_TAG:-N/A}

Date:
$(date)
EOF

# SMTP実装は環境依存
# mailx/sendmail/msmtp 等を利用可能

echo "Mail Notification Prepared"

