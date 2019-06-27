FROM tomcat:9.0.21-jdk11-openjdk
RUN apt-get update -y
RUN rm -f /src/target/petclinic.war

COPY target/petclinic.war /usr/local/tomcat/webapps/petclinic.war

EXPOSE 8080
