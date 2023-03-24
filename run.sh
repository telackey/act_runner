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

  act_runner register \
    --instance "${GITEA_INSTANCE_URL}" \
    --token    "${GITEA_RUNNER_REGISTRATION_TOKEN}" \
    --name     "${GITEA_RUNNER_NAME:-`hostname`}" \
    --labels   "${GITEA_RUNNER_LABELS}" \
    ${insecure} --no-interactive
fi

act_runner daemon
