service tomcat8 stop
rm -rf /usr/share/tomcat8/webapps/petclinic*
cp target/petclinic.war /usr/share/tomcat8/webapps/.
service tomcat8 start
