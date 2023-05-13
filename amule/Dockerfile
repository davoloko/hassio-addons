FROM alpine:edge as builder
WORKDIR /tmp

# Add rootfs
COPY rootfs/ /

# Corrects permissions for s6 v3
RUN if [ -d /etc/cont-init.d ]; then chmod -R 755 /etc/cont-init.d; fi && \
    if [ -d /etc/services.d ]; then chmod -R 755 /etc/services.d; fi && \
    if [ -f /entrypoint.sh ]; then chmod 755 /entrypoint.sh; fi

# Install aMule
RUN apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing amule amule-doc

# Install a modern Web UI
RUN AMULEWEBUI_RELOADED_COMMIT=1a85ead05e26202de8d98af4248189a869a24795 && \
    cd /usr/share/amule/webserver && \
    wget -O AmuleWebUI-Reloaded.zip https://github.com/MatteoRagni/AmuleWebUI-Reloaded/archive/${AMULEWEBUI_RELOADED_COMMIT}.zip && \
    unzip AmuleWebUI-Reloaded.zip && \
    mv AmuleWebUI-Reloaded-* AmuleWebUI-Reloaded && \
    rm -rf AmuleWebUI-Reloaded.zip AmuleWebUI-Reloaded/doc-images AmuleWebUI-Reloaded/README.md

FROM alpine:edge

LABEL maintainer="ngosang@hotmail.es"

# Install packages
RUN apk add --no-cache libedit libgcc libintl libpng libstdc++ libupnp musl wxwidgets zlib tzdata pwgen mandoc curl && \
    apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing crypto++

# Copy binaries and Man doc
COPY --from=builder /usr/bin/alcc /usr/bin/amulecmd /usr/bin/amuled /usr/bin/amuleweb /usr/bin/ed2k /usr/bin/
COPY --from=builder /usr/share/amule /usr/share/amule
COPY --from=builder /usr/share/man/man1/alcc.1.gz /usr/share/man/man1/amulecmd.1.gz /usr/share/man/man1/amuled.1.gz /usr/share/man/man1/amuleweb.1.gz /usr/share/man/man1/ed2k.1.gz /usr/share/man/man1/

# Check binaries are OK
RUN ldd /usr/bin/alcc && \
    ldd /usr/bin/amulecmd && \
    ldd /usr/bin/amuled && \
    ldd /usr/bin/amuleweb && \
    ldd /usr/bin/ed2k

# Add entrypoint
RUN chmod 777 /entrypoint.sh
COPY /entrypoint.sh /home/amule/entrypoint.sh
ENTRYPOINT [ "/usr/bin/env" ]
CMD [ "/home/amule/entrypoint.sh" ]

WORKDIR /home/amule

EXPOSE 4711/tcp 4712/tcp 4662/tcp 4665/udp 4672/udp

# HELP
#
# => Build Docker image
# docker build -t ngosang/amule:test .
#
# => Reference Alpine packages
# https://git.alpinelinux.org/aports/tree/testing/amule

