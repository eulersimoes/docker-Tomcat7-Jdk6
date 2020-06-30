FROM ubuntu:18.04
#jdk1.6
RUN mkdir /java6
WORKDIR /java6
COPY jdk-6u45-linux-x64.bin /java6
RUN ./jdk-6u45-linux-x64.bin && mkdir /usr/lib/jvm && mv jdk1.6.0_45 /usr/lib/jvm
RUN  update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.6.0_45/bin/java 100
RUN update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.6.0_45/bin/javac 100
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/jvm/jdk1.6.0_45/bin:/usr/lib/jvm/jdk1.6.0_45/db/bin:/usr/lib/jvm/jdk1.6.0_45/jre/bin
ENV J2SDKDIR=/usr/lib/jvm/jdk1.6.0_45
ENV J2REDIR=/usr/lib/jvm/jdk1.6.0_45/jre
ENV JAVA_HOME=/usr/lib/jvm/jdk1.6.0_45
ENV DERBY_HOME=/usr/lib/jvm/jdk1.6.0_45/db
COPY apache-tomcat-7.0.104.tar.gz /tmp
RUN mkdir /opt/tomcat
RUN tar xzvf /tmp/apache-tomcat-7.0.*tar.gz -C /opt/tomcat --strip-components=1
WORKDIR /opt/tomcat/bin
RUN chmod +x catalina.sh
COPY setenv.sh /opt/tomcat/bin/setenv.sh
COPY ojdbc6.jar /opt/tomcat/lib/ojdbc6.jar
ENTRYPOINT  ["bash","catalina.sh","run"]
