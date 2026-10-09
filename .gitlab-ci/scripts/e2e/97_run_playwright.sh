# .gitlab-ci/scripts/e2e/97_run_playwright.sh # Playwright実行
#!/bin/bash

set -eu

echo "===================================="
echo "Playwright E2E Started"
echo "===================================="

mkdir -p playwright-report
mkdir -p test-results
mkdir -p artifacts/e2e/screenshots
mkdir -p artifacts/e2e/videos
mkdir -p artifacts/e2e/traces

: "${HEALTHCHECK_URL:?HEALTHCHECK_URL not set}"

echo "Target URL: ${HEALTHCHECK_URL}"

# Playwright依存確認

if ! command -v npx >/dev/null 2>&1
then

    echo "npx not found"

    exit 1

fi

# Playwright Browser Install

npx playwright install --with-deps

# Playwright実行

PLAYWRIGHT_TEST_BASE_URL="${HEALTHCHECK_URL}" \
npx playwright test \
    --reporter=html \
    --output=test-results

# レポート退避

if [ -d playwright-report ]
then

    cp -r playwright-report/* \
        artifacts/e2e/ 2>/dev/null || true

fi

# スクリーンショット

find test-results \
    -type f \
    -name "*.png" \
    -exec cp {} artifacts/e2e/screenshots/ \; \
    2>/dev/null || true

# 動画

find test-results \
    -type f \
    -name "*.webm" \
    -exec cp {} artifacts/e2e/videos/ \; \
    2>/dev/null || true

# トレース

find test-results \
    -type f \
    -name "*.zip" \
    -exec cp {} artifacts/e2e/traces/ \; \
    2>/dev/null || true

echo "===================================="
echo "Playwright Report"
echo "===================================="

ls -R playwright-report || true

echo "===================================="
echo "Playwright E2E Finished"
echo "===================================="

