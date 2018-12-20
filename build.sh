#!/bin/sh
docker build -t rrtxdockerhub.com:5000/cat .
echo "==== starting push config-service ===="
docker push rrtxdockerhub.com:5000/cat
echo "==== building config-service finished ===="
