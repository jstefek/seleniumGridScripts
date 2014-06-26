#!/bin/bash
FIREFOX_BIN="firefox/firefox"
HUB_IP=$1

stop(){
	if [ -z "$(ps -ef | grep selenium-server-standalone | grep -v grep)" ]
	then
	    echo "Application is already stopped"
	else
	    echo "Stopping server"
 	   kill `ps -ef | grep selenium-server-standalone | grep -v grep | awk '{ print $2 }'`
	fi
}

getSeleniumServer(){
    SHORT_VERSION=$1
    if [ ! -n "$1" ]; then
        echo "exiting, no version specified"
        exit -1;
    fi
    echo "selenium short version=${SHORT_VERSION}"
    echo $2
    if [ -z "$2" ]; then
        LONG_VERSION="${SHORT_VERSION}.0"
    else
 	LONG_VERSION=${SHORT_VERSION}.$2
    fi
    echo "selenium long version=${LONG_VERSION}"

    wget -c http://selenium-release.storage.googleapis.com/${SHORT_VERSION}/selenium-server-standalone-${LONG_VERSION}.jar
}

runHub(){
    echo "Starting hub..."
    java -jar selenium-server-standalone-${LONG_VERSION}.jar -role hub
}

stopAndQuit(){
	stop
	exit 0;
}

#trap stopAndQuit SIGINT

getSeleniumServer 2.42 2
runHub