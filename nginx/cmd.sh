#!/bin/sh

envsubst < /etc/nginx/conf.d/giropops-reverse-proxy.conf.template > /etc/nginx/conf.d/giropops-reverse-proxy.conf && nginx -g 'daemon off;'