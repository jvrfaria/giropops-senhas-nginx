FROM debian:13.3-slim AS env_substitute
RUN apt-get update && apt-get install gettext-base -y && rm -rf /var/cache/apt/lists/*
ENV GIROPOPS_SENHAS_DNS=giropops-senhas
ENV GIROPOPS_SENHAS_PORT=5000
COPY giropops-senhas-reverse-proxy.template .
RUN envsubst < giropops-senhas-reverse-proxy.template > giropops-senhas-reverse-proxy.conf

FROM dhi.io/nginx:1.29.5-debian13-dev
COPY --from=env_substitute giropops-senhas-reverse-proxy.conf /etc/nginx/conf.d/giropops-senhas-reverse-proxy.conf

EXPOSE 443