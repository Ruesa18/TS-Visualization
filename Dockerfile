FROM whatwedo/nginx:v2.8 AS base

WORKDIR /var/www

COPY ./docker/base /

RUN apk add --no-cache nodejs npm yarn git openssh-client

EXPOSE 80

FROM base AS dev

# Install dde development depencencies
COPY .dde/configure-image.sh /tmp/dde-configure-image.sh
ARG DDE_UID
ARG DDE_GID
RUN chmod +x /tmp/dde-configure-image.sh
RUN /tmp/dde-configure-image.sh

FROM base AS prod

ADD . /var/www
