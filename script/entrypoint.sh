#!/usr/bin/env bash



RESULT=`mysqlshow -u ${MYSQL_USERNAME} --password=${MYSQL_PASSWD} --port ${MYSQL_PORT} --host ${MYSQL_URL} ${MYSQL_SCHEMA} | grep -v Wildcard | grep -o dailygraph`
if [ "$RESULT" != "dailygraph" ]; then
    mysql -u ${MYSQL_USERNAME} --password=${MYSQL_PASSWD} --port ${MYSQL_PORT} --host ${MYSQL_URL} ${MYSQL_SCHEMA} < /app/Cat.sql
    echo 'Init database from Cat.sql'
fi


sed -i "s/MYSQL_URL/${MYSQL_URL}/g" /data/appdatas/cat/datasources.xml;
sed -i "s/MYSQL_PORT/${MYSQL_PORT}/g" /data/appdatas/cat/datasources.xml;
sed -i "s/MYSQL_USERNAME/${MYSQL_USERNAME}/g" /data/appdatas/cat/datasources.xml;
sed -i "s/MYSQL_PASSWD/${MYSQL_PASSWD}/g" /data/appdatas/cat/datasources.xml;
sed -i "s/MYSQL_SCHEMA/${MYSQL_SCHEMA}/g" /data/appdatas/cat/datasources.xml;


catalina.sh run