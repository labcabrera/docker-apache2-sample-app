FROM openjdk:8u151-jdk

LABEL mantainer "lab.cabrera@gmail.com"

ARG IMAGE_PROXY
ARG IMAGE_NO_PROXY

COPY resources/sample-app /opt/sample-app
COPY resources/scripts/entrypoint.sh /root/
COPY resources/config/key.pem /root/
COPY resources/config/certificate.pem /root/

USER root

ENV http_proxy=${IMAGE_PROXY}
ENV https_proxy=${IMAGE_PROXY}
ENV no_proxy=${IMAGE_NO_PROXY}
ENV HTTP_PROXY=${IMAGE_PROXY}
ENV HTTPS_PROXY=${IMAGE_PROXY}
ENV NO_PROXY=${IMAGE_NO_PROXY}

#    apache2-utils \
#    libapache2-mod-proxy-html \
#    libxml2-dev \

RUN echo "root:changeit" | chpasswd && \
  chmod 700 /root/entrypoint.sh && \
  apt-get update && \
  apt-get install -y \
    vim \
    curl \
    apache2 \ 
    apache2-utils \
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
    ssl \
    expires && \
  rm /etc/apache2/sites-enabled/*.conf && \
  echo "alias ll='ls -Alh'" >> /root/.bashrc && \
  mkdir -p /tmp/cache/mod_cache && \
  mkdir -p /tmp/cache/mod_cache_lock && \
  chmod 777 /tmp/cache/mod_cache && \
  chmod 777 /tmp/cache/mod_cache_lock
  
COPY resources/config/*.conf /etc/apache2/sites-enabled/

# 9009 port should not be exposed in real env, its just for testing this image
EXPOSE 80 9009

CMD ["/root/entrypoint.sh"]
