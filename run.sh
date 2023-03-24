#!/usr/bin/env bash

if [[ ! -d /data ]]; then
  mkdir -p /data
fi

cd /data

# Use the same ENV variable names as https://github.com/vegardit/docker-gitea-act-runner
# See env.example for example values.

if [[ ! -s .runner ]]; then
  insecure=""
  if [[ ${GITEA_INSTANCE_INSECURE} == '1' ]] || [[ ${GITEA_INSTANCE_INSECURE} == 'true' ]]; then
    insecure="--insecure"
  fi

  try=$((try + 1))
  success=0

  while [[ $success -eq 0 ]] && [[ $try -lt ${GITEA_MAX_REG_ATTEMPTS:-10} ]]; do
  act_runner register \
    --instance "${GITEA_INSTANCE_URL}" \
    --token    "${GITEA_RUNNER_REGISTRATION_TOKEN}" \
    --name     "${GITEA_RUNNER_NAME:-`hostname`}" \
    --labels   "${GITEA_RUNNER_LABELS}" \
    ${insecure} --no-interactive > /tmp/reg.log 2>&1

    cat /tmp/reg.log

    cat /tmp/reg.log | grep 'Runner registered successfully' > /dev/null
    if [[ $? -eq 0 ]]; then
      echo "SUCCESS"
      success=1
    else
      echo "Waiting to retry ..."
      sleep 5
    fi
  done
fi

act_runner daemon
