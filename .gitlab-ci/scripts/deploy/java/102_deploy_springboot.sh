# .gitlab-ci/scripts/deploy/java/102_deploy_springboot.sh # SpringBootデプロイ
#!/bin/bash

set -eu

: "${DEPLOY_DIR:?DEPLOY_DIR not set}"
: "${DEPLOY_HEALTHCHECK_URL:?DEPLOY_HEALTHCHECK_URL not set}"

JAR_FILE=$(find build-output -name "*.jar" | head -1)

test -n "${JAR_FILE}"

mkdir -p backup

cp -f "${DEPLOY_DIR}/application.jar" backup/ 2>/dev/null || true

PID_FILE="${DEPLOY_DIR}/application.pid"

if [ -f "${PID_FILE}" ]; then
    kill "$(cat ${PID_FILE})" || true
fi

cp "${JAR_FILE}" "${DEPLOY_DIR}/application.jar"

nohup java -jar "${DEPLOY_DIR}/application.jar" \
    > "${DEPLOY_DIR}/startup.log" 2>&1 &

echo $! > "${PID_FILE}"

for i in $(seq 1 30)
do
    if curl -fs "${DEPLOY_HEALTHCHECK_URL}" >/dev/null 2>&1
    then
        echo "HealthCheck Passed"
        exit 0
    fi
    sleep 10
done

exit 1

