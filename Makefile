REGISTRY_NAME := "quay.io"
ORG_NAME := "chcollin"
IMAGE_NAME := "tmux-static-builder"
IMAGE_TAG := "latest"
TMPDIR := $(shell mktemp -d /tmp/ocm-container-custom.XXXXX)
CONTAINER_SUBSYS?="podman"

default: all

.PHONY: all
all: check_env build

.PHONY: build
build: 
	@podman build -t ${REGISTRY_NAME}/${ORG_NAME}/${IMAGE_NAME} .

.PHONY: check_env
check_env:
	@if test -z "${CONTAINER_SUBSYS}" ; then echo 'CONTAINER_SUBSYS must be set. Hint: `source ~/.config/ocm-container/env.source`' ; exit 1 ; fi
