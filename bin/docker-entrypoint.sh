#!/usr/bin/env sh
set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

mkdir -p /etc/grafana
gotpl "/etc/gotpl/grafana.ini.tmpl" > /etc/grafana/grafana.ini

if [[ "${1}" == 'make' ]]; then
    exec "${@}" -f /usr/local/bin/actions.mk
else
    su-exec grafana /run.sh "${@}"
fi
