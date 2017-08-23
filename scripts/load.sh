#!/bin/bash
rm -rf /usr/share/tomcat7/webapps/petclinic*
service tomcat7 start > /var/log/starttomcat7.out 2>&1

