FROM docker.io/node:18.19.1-slim as builder
RUN corepack enable \
    && yarn set version berry
WORKDIR /app
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
ENV NODE_OPTIONS=--openssl-legacy-provider
RUN yarn build

FROM scratch as dist
COPY imageroot imageroot
COPY --from=builder /app/dist ui
LABEL org.nethserver.images="ghcr.io/nethserver/dnsmasq:latest"
LABEL org.nethserver.rootfull=1
LABEL org.nethserver.authorizations="node:fwadm"
ENTRYPOINT [ "/" ]
