# .gitlab-ci/scripts/deploy/nodejs/103_deploy_nodejs.sh # Node.jsデプロイ
#!/bin/bash

set -eu

: "${DEPLOY_DIR:?DEPLOY_DIR not set}"
: "${DEPLOY_HEALTHCHECK_URL:?DEPLOY_HEALTHCHECK_URL not set}"

test -d build-output/dist

mkdir -p backup

cp -r "${DEPLOY_DIR}/dist" backup/ 2>/dev/null || true

PID_FILE="${DEPLOY_DIR}/node.pid"

if [ -f "${PID_FILE}" ]; then
    kill "$(cat ${PID_FILE})" || true
fi

rm -rf "${DEPLOY_DIR}/dist"

cp -r build-output/dist "${DEPLOY_DIR}/"

cd "${DEPLOY_DIR}"

nohup npm start > startup.log 2>&1 &

echo $! > "${PID_FILE}"

for i in $(seq 1 30)
do
    if curl -fs "${DEPLOY_HEALTHCHECK_URL}" >/dev/null 2>&1
    then
        exit 0
    fi
    sleep 10
done

exit 1

