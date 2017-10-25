FROM tomcat:7.0.70-jre7
RUN apt-get update && apt-get install -y software-properties-common
RUN apt-get install -y git
RUN apt-get install -y maven
RUN apt-get install -y default-jdk
#RUN git clone https://github.com/manikantagorapalli/newpetclinicapp
COPY . /src
RUN rm -f /src/target/petclinic.war
RUN cd /src && mvn install -Dmaven.test.skip=true

RUN mv /src/target/petclinic.war /usr/local/tomcat/webapps/petclinic.war

EXPOSE 8080
