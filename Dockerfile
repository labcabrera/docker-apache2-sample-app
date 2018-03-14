FROM debian:8.10

LABEL mantainer "lab.cabrera@gmail.com"

ARG IMAGE_PROXY
ARG IMAGE_NO_PROXY

COPY resources/sample-app /opt/sample-app
COPY resources/scripts/entrypoint.sh /root/

USER root

ENV http_proxy=${IMAGE_PROXY}
ENV https_proxy=${IMAGE_PROXY}
ENV no_proxy=${IMAGE_NO_PROXY}
ENV HTTP_PROXY=${IMAGE_PROXY}
ENV HTTPS_PROXY=${IMAGE_PROXY}
ENV NO_PROXY=${IMAGE_NO_PROXY}

RUN echo "root:changeit" | chpasswd && \
  chmod +x /root/*.sh && \
  apt-get update && \
  apt-get install -y \
    vim \
    curl \
    ruby \
    apache2 \
		libapache2-mod-proxy-html \
		libxml2-dev && \
  a2enmod \
	  proxy \
		proxy_ajp \
		proxy_http \
		rewrite \
		deflate \
		headers \
		proxy_balancer \
		proxy_connect \
		proxy_html && \
  rm /etc/apache2/sites-enabled/000-default.conf && \
  echo "<VirtualHost *:*>" > /etc/apache2/sites-enabled/000-default.conf && \
  echo "  ProxyPreserveHost On" >> /etc/apache2/sites-enabled/000-default.conf && \
  echo "  ProxyPass / http://0.0.0.0:8080/" >> /etc/apache2/sites-enabled/000-default.conf && \
  echo "  ProxyPassReverse / http://0.0.0.0:8080/" >> /etc/apache2/sites-enabled/000-default.conf && \
  echo "  ServerName localhost" >> /etc/apache2/sites-enabled/000-default.conf && \
  echo "</VirtualHost>" >> /etc/apache2/sites-enabled/000-default.conf

EXPOSE 80

CMD ["/root/entrypoint.sh"]
