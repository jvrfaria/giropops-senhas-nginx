FROM nginx:1.29.5-alpine3.23-slim
COPY nginx.conf /etc/nginx/conf.d/giropops-reverse-proxy.conf.template
COPY --chmod=0411 cmd.sh cmd.sh

EXPOSE 443
CMD ["/bin/sh", "/cmd.sh"]