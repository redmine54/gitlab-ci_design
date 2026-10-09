# .gitlab-ci/scripts/deploy/java/101_deploy_tomcat.sh # Tomcatデプロイ
#!/bin/bash

set -eu

echo "===================================="
echo "Tomcat Deploy Started"
echo "===================================="

: "${TOMCAT_HOME:?TOMCAT_HOME not set}"
: "${DEPLOY_HEALTHCHECK_URL:?DEPLOY_HEALTHCHECK_URL not set}"

WAR_FILE=$(find build-output -name "*.war" | head -1)

if [ -z "${WAR_FILE}" ]; then
    echo "WAR file not found"
    exit 1
fi

mkdir -p backup

cp -f "${TOMCAT_HOME}/webapps/"*.war backup/ 2>/dev/null || true

"${TOMCAT_HOME}/bin/shutdown.sh" || true

sleep 10

cp "${WAR_FILE}" "${TOMCAT_HOME}/webapps/ROOT.war"

"${TOMCAT_HOME}/bin/startup.sh"

for i in $(seq 1 30)
do
    if curl -fs "${DEPLOY_HEALTHCHECK_URL}" >/dev/null 2>&1
    then
        echo "HealthCheck Passed"
        exit 0
    fi
    sleep 10
done

echo "Deploy Failed"
exit 1

