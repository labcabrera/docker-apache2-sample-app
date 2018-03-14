#!/bin/bash

service apache2 restart 

java -jar /opt/sample-app/http-network-diagnostic-1.0.3.jar
