ARG GRAFANA_VER

FROM grafana/grafana:${GRAFANA_VER}

ARG TARGETPLATFORM

USER root

RUN set -xe; \
    apk add --update --no-cache \
        bash \
        make \
        curl \
        su-exec \
        util-linux; \
    \
    dockerplatform=${TARGETPLATFORM:-linux/amd64};\
    gotpl_url="https://github.com/wodby/gotpl/releases/download/0.3.3/gotpl-${TARGETPLATFORM/\//-}.tar.gz"; \
    wget -O- "${gotpl_url}" | tar xz --no-same-owner -C /usr/local/bin; \
    \
    rm -rf /tmp/*; \
    rm -rf /var/cache/apk/*

COPY templates /etc/gotpl/
COPY bin /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
