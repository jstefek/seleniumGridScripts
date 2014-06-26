#!/bin/bash
if [ -z "$(ps -ef | grep selenium-server-standalone | grep -v grep)" ]
then
    echo "Application is already stopped"
else
    echo "Stopping server"
    kill `ps -ef | grep selenium-server-standalone | grep -v grep | awk '{ print $2 }'`
fi
