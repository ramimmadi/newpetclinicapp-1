#!/bin/bash
yum install java-1.8.0-openjdk-headless.x86_64 -y
yum install -y java-1.8.0-openjdk-devel.x86_64 -y
update-alternatives --set java  /usr/lib/jvm/jre-1.8.0-openjdk.x86_64/bin/java
update-alternatives --set javac  /usr/lib/jvm/jre-1.8.0-openjdk.x86_64/bin/javac

yum -y install tomcat7 > /var/log/installtomcat.out 2>&1
