#!/bin/bash
# Downloads selenium server standalone jar and starts selenium grid hub with default parameters

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
    nohup java -jar selenium-server-standalone-${LONG_VERSION}.jar -role hub > hub.out &
    tail -F hub.out
}

trap "sh stop.sh hub" INT
getSeleniumServer 2.42 2
runHub
