FROM alpine:3.12.4
LABEL maintainer="Janne K <0x022b@gmail.com>"

ENTRYPOINT ["/sbin/tini", "-g", "--", "/usr/local/bin/container-entrypoint"]
CMD ["container-daemon"]

RUN \
sed -i 's/http:/https:/' /etc/apk/repositories && \
apk upgrade --no-cache && \
apk add --no-cache \
    ca-certificates \
    iptables \
    ip6tables \
    su-exec \
    tini \
    tzdata && \
ln -s /usr/share/zoneinfo/Universal /etc/localtime

VOLUME ["/app"]

# TODO: Add instructions to specialise the image

COPY rootfs/ /
