// Copyright 2022 The Gitea Authors. All rights reserved.
// SPDX-License-Identifier: MIT

package core

const (
	UUIDHeader    = "x-runner-uuid"
	TokenHeader   = "x-runner-token"
	VersionHeader = "x-runner-version"
)

// Runner struct
type Runner struct {
	ID                     int64    `json:"id"`
	UUID                   string   `json:"uuid"`
	Name                   string   `json:"name"`
	Token                  string   `json:"token"`
	Address                string   `json:"address"`
	Insecure               string   `json:"insecure"`
	Labels                 []string `json:"labels"`
	DockerContainerOptions string   `json:"dockerContainerOptions"`
	DockerNetworkMode      string   `json:"dockerNetworkMode"`
	DockerPrivileged       string   `json:"dockerPrivileged"`
}
