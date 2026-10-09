# .gitlab-ci/scripts/deploy/was/105_deploy_was.sh # WASデプロイ
#!/bin/bash

set -eu

: "${WAS_PROFILE:?WAS_PROFILE not set}"
: "${DEPLOY_HEALTHCHECK_URL:?DEPLOY_HEALTHCHECK_URL not set}"

EAR_FILE=$(find build-output -name "*.ear" | head -1)

test -n "${EAR_FILE}"

"${WAS_PROFILE}/bin/wsadmin.sh" \
  -lang jython \
  -c "print('Deploy ${EAR_FILE}')"

for i in $(seq 1 30)
do
    if curl -fs "${DEPLOY_HEALTHCHECK_URL}" >/dev/null 2>&1
    then
        exit 0
    fi
    sleep 10
done

exit 1

