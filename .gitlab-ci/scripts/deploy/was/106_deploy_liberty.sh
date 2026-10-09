# .gitlab-ci/scripts/deploy/was/106_deploy_liberty.sh # Libertyデプロイ
#!/bin/bash

set -eu

: "${WLP_HOME:?WLP_HOME not set}"
: "${DEPLOY_HEALTHCHECK_URL:?DEPLOY_HEALTHCHECK_URL not set}"

SERVER_NAME="${LIBERTY_SERVER_NAME:-defaultServer}"

WAR_FILE=$(find build-output -name "*.war" | head -1)

test -n "${WAR_FILE}"

DROPINS="${WLP_HOME}/usr/servers/${SERVER_NAME}/dropins"

mkdir -p "${DROPINS}"

cp "${WAR_FILE}" "${DROPINS}/ROOT.war"

"${WLP_HOME}/bin/server" stop "${SERVER_NAME}" || true

"${WLP_HOME}/bin/server" start "${SERVER_NAME}"

for i in $(seq 1 30)
do
    if curl -fs "${DEPLOY_HEALTHCHECK_URL}" >/dev/null 2>&1
    then
        exit 0
    fi
    sleep 10
done

exit 1

