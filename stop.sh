#!/bin/bash
echo ""

if [ "$1" == "node" ]; then
	TMP=`ps -ef | grep selenium-server-standalone | grep node | grep -v grep`
	TMP2=`ps -ef | grep 'tail' | grep node.out | grep -v grep`
elif [ "$1" == "hub" ]; then
	TMP=`ps -ef | grep selenium-server-standalone | grep hub | grep -v grep`
	TMP2=`ps -ef | grep 'tail' | grep hub.out | grep -v grep`
else
	echo "exiting, dont know what to shut down..."
    	exit 1;
fi
if [ -z "$TMP" ]; then
	echo "$1 is already stopped"
else
    	echo "Stopping $1"
    	kill `echo "${TMP}" | awk '{ print $2 }'`
	sleep 2
	if [ ! -z "${TMP2}" ] ;then
		echo "Stopping 'tail' command of $1"
    		kill `echo "${TMP2}" | awk '{ print $2 }'`
	fi  	

fi
