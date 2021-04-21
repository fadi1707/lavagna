FROM nginx:stable-alpine

WORKDIR /etc/nginx/

#VOLUME [ "/reverse_proxy" ]

COPY ./webapp ./html
COPY nginx.conf .