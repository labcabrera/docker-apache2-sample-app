#!/bin/bash

service apache2 restart 

ruby -run -e httpd /opt/sample-app -p 8080