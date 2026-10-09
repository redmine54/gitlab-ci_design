# .gitlab-ci/scripts/release/111_release_publish.sh # リリース公開処理
#!/bin/bash

set -eu

echo "===================================="
echo "Release Publish Started"
echo "===================================="

: "${APP_NAME:?APP_NAME not set}"
: "${APP_TYPE:?APP_TYPE not set}"
: "${RELEASE_VERSION:?RELEASE_VERSION not set}"
: "${CI_COMMIT_SHA:?CI_COMMIT_SHA not set}"
: "${CI_PIPELINE_ID:?CI_PIPELINE_ID not set}"

if [ -z "${CI_COMMIT_TAG:-}" ]; then

    echo "CI_COMMIT_TAG is required"

    exit 1

fi

mkdir -p reports/release

RELEASE_DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "===================================="
echo "Release Information"
echo "===================================="

echo "APP_NAME=${APP_NAME}"
echo "APP_TYPE=${APP_TYPE}"
echo "RELEASE_VERSION=${RELEASE_VERSION}"
echo "CI_COMMIT_TAG=${CI_COMMIT_TAG}"
echo "CI_COMMIT_SHA=${CI_COMMIT_SHA}"

# --------------------------------------
# Release Notes Check
# --------------------------------------

if [ ! -f reports/release/release-notes.md ]; then

    echo "release-notes.md not found"

    exit 1

fi

# --------------------------------------
# Release Metadata
# --------------------------------------

cat > reports/release/release-publish.txt << EOF
APP_NAME=${APP_NAME}
APP_TYPE=${APP_TYPE}
RELEASE_VERSION=${RELEASE_VERSION}
CI_COMMIT_TAG=${CI_COMMIT_TAG}
CI_COMMIT_SHA=${CI_COMMIT_SHA}
CI_PIPELINE_ID=${CI_PIPELINE_ID}
RELEASE_DATE=${RELEASE_DATE}
EOF

# --------------------------------------
# Git Tag Verification
# --------------------------------------

git rev-parse "${CI_COMMIT_TAG}" >/dev/null 2>&1

echo "Tag Verification Passed"

# --------------------------------------
# Optional External Publish
# --------------------------------------

if [ -n "${RELEASE_PUBLISH_COMMAND:-}" ]; then

    echo "Executing Release Publish Command"

    sh -c "${RELEASE_PUBLISH_COMMAND}"

fi

# --------------------------------------
# Release Report
# --------------------------------------

cat > reports/release/release-summary.txt << EOF
STATUS=SUCCESS
APP_NAME=${APP_NAME}
APP_TYPE=${APP_TYPE}
RELEASE_VERSION=${RELEASE_VERSION}
CI_COMMIT_TAG=${CI_COMMIT_TAG}
CI_COMMIT_SHA=${CI_COMMIT_SHA}
CI_PIPELINE_ID=${CI_PIPELINE_ID}
RELEASE_DATE=${RELEASE_DATE}
EOF

echo "===================================="
echo "Release Publish Finished"
echo "===================================="

