FROM debian:8.10

LABEL mantainer "lab.cabrera@gmail.com"

ARG IMAGE_PROXY
ARG IMAGE_NO_PROXY

USER root

COPY resources/scripts/entrypoint.sh /root/
COPY resources/sample-app /opt/sample-app

ENV http_proxy=${IMAGE_PROXY}
ENV https_proxy=${IMAGE_PROXY}
ENV no_proxy=${IMAGE_NO_PROXY}
ENV HTTP_PROXY=${IMAGE_PROXY}
ENV HTTPS_PROXY=${IMAGE_PROXY}
ENV NO_PROXY=${IMAGE_NO_PROXY}

RUN echo "root:changeit" | chpasswd && \
  chmod 700 /root/entrypoint.sh && \
  apt-get update && \
  apt-get install -y \
    vim \
    curl \
    ruby \
    apache2 \ 
    apache2-utils \
    libapache2-mod-proxy-html \
    libxml2-dev \
    tree && \
  a2enmod \
    proxy \
    proxy_ajp \
    proxy_http \
    rewrite \
    deflate \
    headers \
    proxy_balancer \
    proxy_connect \
    proxy_html \
    cache_disk \
    expires && \
  rm /etc/apache2/sites-enabled/*.conf && \
  echo "alias ll='ls -Alh'" >> /root/.bashrc && \
  mkdir -p /tmp/cache/mod_cache && \
  mkdir -p /tmp/cache/mod_cache_lock && \
  chmod -R /tmp/cache/mod_cache && \
  chmod -R /tmp/cache/mod_cache_lock

#cache \

COPY resources/config/*.conf /etc/apache2/sites-enabled/

# 8080 port should not be exposed, its just for testing this image
EXPOSE 80 8080

CMD ["/root/entrypoint.sh"]
