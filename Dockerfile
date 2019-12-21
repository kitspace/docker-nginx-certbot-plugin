FROM nginx:1.17.6-alpine 
RUN apk add inotify-tools certbot openssl bash certbot-nginx
WORKDIR /opt
COPY command ./
CMD ["./command"]
