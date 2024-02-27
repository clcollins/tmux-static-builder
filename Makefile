REGISTRY_NAME := "quay.io"
ORG_NAME := "chcollin"
IMAGE_NAME := "tmux"
GIT_HASH := "$(shell git rev-parse HEAD | cut -c 1-8)"

TAG := ${REGISTRY_NAME}/${ORG_NAME}/${IMAGE_NAME}:${GIT_HASH}
TAG_LATEST := ${REGISTRY_NAME}/${ORG_NAME}/${IMAGE_NAME}:latest

AUTHFILE := "${HOME}/.config/quay.io/bot_auth.json"

TMPDIR := $(shell mktemp -d /tmp/ocm-container-custom.XXXXX)
CONTAINER_SUBSYS?="podman"
CACHE := "--no-cache"

ALLOW_DIRTY_CHECKOUT?=false

default: all

.PHONY: all
all: isclean check_env build

.PHONY: isclean
isclean:
	@(test "$(ALLOW_DIRTY_CHECKOUT)" != "false" || test 0 -eq $$(git status --porcelain | wc -l)) || (echo "Local git checkout is not clean, commit changes and try again." >&2 && git --no-pager diff && exit 1)

.PHONY: build
build: 
	@${CONTAINER_SUBSYS} build ${CACHE} -t ${TAG} .

.PHONY: tag
tag:
	@${CONTAINER_SUBSYS} tag ${TAG} ${TAG_LATEST}

.PHONY: push
push:
	@${CONTAINER_SUBSYS} push ${TAG} --authfile=${AUTHFILE}
	@${CONTAINER_SUBSYS} push ${TAG_LATEST} --authfile=${AUTHFILE}

.PHONY: check_env
check_env:
	@if test -z "${CONTAINER_SUBSYS}" ; then echo 'CONTAINER_SUBSYS must be set. Hint: `source ~/.config/ocm-container/env.source`' ; exit 1 ; fi
