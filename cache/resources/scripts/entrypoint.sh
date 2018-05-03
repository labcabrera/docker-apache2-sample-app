#!/bin/bash

service apache2 restart
#service apache-htcacheclean start

ruby -run -e httpd /opt/sample-app -p 8080