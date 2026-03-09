FROM debian:13.3-slim AS env_substitute

RUN apt-get update && apt-get install gettext-base -y && rm -rf /var/cache/apt/lists/*

COPY giropops-senhas-reverse-proxy.template .

ARG GIROPOPS_SENHAS_DNS
ARG GIROPOPS_SENHAS_PORT

ENV GIROPOPS_SENHAS_DNS=$GIROPOPS_SENHAS_DNS
ENV GIROPOPS_SENHAS_PORT=$GIROPOPS_SENHAS_PORT

RUN envsubst < giropops-senhas-reverse-proxy.template > giropops-senhas-reverse-proxy.conf
RUN --mount=type=secret,id=tls-certificate,required=true cp /run/secrets/tls-certificate /tls-certificate
RUN --mount=type=secret,id=tls-key,required=true cp /run/secrets/tls-key /tls-key

FROM dhi.io/nginx:1.29.5-debian13 AS runner

COPY --from=env_substitute giropops-senhas-reverse-proxy.conf /etc/nginx/conf.d/giropops-senhas-reverse-proxy.conf
COPY --from=env_substitute --chown=nginx /tls-certificate /tls-certificate
COPY --from=env_substitute --chown=nginx /tls-key /tls-key

EXPOSE 443