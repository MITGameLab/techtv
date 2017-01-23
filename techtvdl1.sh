#!/bin/bash

SAVEPATH="/Users/philip/Desktop"

SOURCE=`curl $1`

EXTENSION=${SOURCE#*download.source\" class=\"i-download\">}
EXTENSION=${EXTENSION%%</a>*}

TITLE=`echo $SOURCE | sed -n 's:.*<title>MIT TechTV &ndash; \(.*\)</title>.*:\1:p'`
FILENAME=$SAVEPATH/${TITLE//['<>:\|']/_}.$EXTENSION
echo $FILENAME


VIDPATH=${SOURCE%/download.source*}
VIDPATH=${VIDPATH##*<a href=\"}
VIDPATH=http://techtv.mit.edu$VIDPATH/download.source
echo $VIDPATH

curl -L -o "$FILENAME" "$VIDPATH"

