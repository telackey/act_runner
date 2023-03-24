#!/usr/bin/env bash
#
# ADAPTED FROM:
#
# SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com)
# SPDX-FileContributor: Sebastian Thomschke
# SPDX-License-Identifier: Apache-2.0
# SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/docker-gitea-act-runner
#

if [[ ! -d /data ]]; then
  mkdir -p /data
fi

cd /data

if [[ ! -s .runner ]]; then
  if [[ ${GITEA_INSTANCE_INSECURE:-} == '1' ]]; then
    insecure_flag=--insecure
  fi
  if [[ -z ${GITEA_RUNNER_REGISTRATION_TOKEN:-} ]]; then
    read -r GITEA_RUNNER_REGISTRATION_TOKEN < "$GITEA_RUNNER_REGISTRATION_TOKEN_FILE"
  fi
  act_runner register \
    --instance "${GITEA_INSTANCE_URL}" \
    --token    "${GITEA_RUNNER_REGISTRATION_TOKEN}" \
    --name     "${GITEA_RUNNER_NAME}" \
    --labels   "${GITEA_RUNNER_LABELS}" \
    $( [[ ${GITEA_INSTANCE_INSECURE:-} == '1' ]] && echo "--insecure" || true) \
    --no-interactive
fi

act_runner daemon
