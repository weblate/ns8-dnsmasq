FROM docker.io/node:24.16.0 AS base
RUN corepack enable \
    && yarn set version berry
WORKDIR /app
ENV NODE_OPTIONS=--openssl-legacy-provider

FROM base AS dev
CMD exec /bin/bash -c "yarn install && yarn watch"

FROM base AS builder
COPY ui/.yarnrc.yml .
COPY ui/package.json .
COPY ui/yarn.lock .
RUN yarn install --immutable
COPY ui/public public
COPY ui/src src
COPY ui/.browserslistrc .
COPY ui/.eslintrc.js .
COPY ui/babel.config.js .
COPY ui/vue.config.js .
RUN yarn build

FROM scratch AS dist
COPY imageroot imageroot
COPY --from=builder /app/dist ui
LABEL org.nethserver.rootfull=1
LABEL org.nethserver.max-per-node=1
LABEL org.nethserver.authorizations="node:fwadm"
LABEL org.nethserver.min-core="3.20.1"
ENTRYPOINT [ "/" ]
