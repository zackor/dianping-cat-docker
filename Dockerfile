FROM tomcat:8.0-jre8
#RUN apk add mysql-client
RUN apt-get update \
    && apt-get install -y mysql-client \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone

RUN mkdir /data && chmod 777 /data/ -R && mkdir -p /data/appdatas/cat/ && mkdir /app

COPY script/client.xml /data/appdatas/cat/
COPY script/server.xml /data/appdatas/cat/
COPY script/datasources.xml /data/appdatas/cat/

COPY script/Cat.sql /app
COPY script/settings.xml /app
COPY script/entrypoint.sh /app
COPY script/wait-for-it.sh /app
COPY script/run.sh /app

RUN chmod +x /app/*.sh

RUN rm -rf /usr/local/tomcat/webapps/*

ADD http://unidal.org/nexus/service/local/repositories/releases/content/com/dianping/cat/cat-home/3.0.0/cat-home-3.0.0.war /usr/local/tomcat/webapps/cat.war

#COPY script/cat-home-3.0.0.war /usr/local/tomcat/webapps/cat.war

ENTRYPOINT /app/run.sh