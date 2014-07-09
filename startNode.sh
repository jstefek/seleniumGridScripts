#!/bin/bash
# Downloads selenium server standalone jar and starts selenium grid node with parameters specified in nodeConfig.json
# can be used with params for the node, like: "sh startNode.sh -Dwebdriver.ie.driver='path-x' ..." 
# sh startNode.sh -Dwebdriver.ie.driver=IEDriverServer.exe -Dwebdriver.chrome.driver=chromedriver.exe

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

runNode(){
    	echo "Starting node..."
	PARAMS=""
	echo "starting node with additional params: " $@

	while [ "$#" != "0" ]; do
		PARAMS+=$1
		PARAMS+=" "
		shift
	done
	echo $PARAMS
	nohup java -jar selenium-server-standalone-${LONG_VERSION}.jar -role node -nodeConfig nodeConfig.json "$PARAMS" > node.out &
    	tail -F node.out
}

trap "sh stop.sh node" INT
getSeleniumServer 2.42 2
runNode "$@"
