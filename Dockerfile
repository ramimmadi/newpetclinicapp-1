FROM tomcat:8
RUN apt-get update -y

COPY target/petclinic.war /usr/local/tomcat/webapps/petclinic.war

EXPOSE 8080
