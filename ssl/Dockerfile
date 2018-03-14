FROM openjdk:8u151-jdk

ARG IMAGE_PROXY
ARG IMAGE_NO_PROXY

LABEL mantainer "lab.cabrera@gmail.com"

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

RUN echo "root:changeit" | chpasswd && \
  chmod 700 /root/entrypoint.sh && \
  apt-get update && \
  apt-get install -y \
    vim \
    curl \
    apache2 && \
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
    ssl && \
    rm /etc/apache2/sites-enabled/*.conf
  
COPY resources/config/sample-ssl.conf /etc/apache2/sites-enabled/

# 9009 port should not be exposed in real env, its just for testing this image
EXPOSE 80 443 9009

CMD ["/root/entrypoint.sh"]
