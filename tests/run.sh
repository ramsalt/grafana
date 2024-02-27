#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

cid="$(docker run -d --name "${NAME}" "${IMAGE}")"
trap "docker rm -vf $cid > /dev/null" EXIT

grafana() {
	docker run --rm -i --link "${NAME}":"grafana" "${IMAGE}" "${@}" host="grafana"
}

grafana make check-ready wait_seconds=5 max_try=12 delay_seconds=20
