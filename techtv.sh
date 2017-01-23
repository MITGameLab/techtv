#!/bin/bash

DLORIGINALS=true
DLBASIC=true
TESTMODE=false

while getopts ":tob" opt; do
  case $opt in
    t)
      echo "Test mode. No video files will be downloaded."
      TESTMODE=true
      ;;
    o)
      echo "Only original files will be processed."
      DLBASIC=false
      ;;
    b)
      echo "Only basic MP4 files will be processed."
      DLORIGINALS=false
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

shift $(($OPTIND - 1))
RSSFILE=$1

if [ -z "$RSSFILE" ] ; then
  echo "TechTV downloader requires an RSS video listing for your collection."
  echo "For example: ./techtv.sh videos.rss"
  exit 1
fi

URLS=`grep -o '<link>.*</link>' $RSSFILE | sed 's/<[^>]*>//g' | sed '/http:\/\/techtv.mit.edu\/collections/d'`

ORIGINALS=0
BASICS=0

while read -r SOURCEURL; do
  SOURCE=`curl -s $SOURCEURL`

  EXTENSION=${SOURCE#*download.source\" class=\"i-download\">}
  EXTENSION=${EXTENSION%%</a>*}
  
  if [ ${#EXTENSION} -ne 3 ]; then
    if [ "$DLBASIC" = false ] ; then
      continue
    fi
    VIDPATH=${SOURCE%/download.mp4*}
    VIDPATH=${VIDPATH##*<a href=\"}
    VIDPATH=http://techtv.mit.edu$VIDPATH/download.mp4
    EXTENSION=mp4
    (( BASICS += 1 ))
  else
    if [ "$DLORIGINALS" = false ] ; then
      continue
    fi
    VIDPATH=${SOURCE%/download.source*}
    VIDPATH=${VIDPATH##*<a href=\"}
    VIDPATH=http://techtv.mit.edu$VIDPATH/download.source
    (( ORIGINALS += 1 ))
  fi
  
  TITLE=`echo $SOURCE | sed -n 's:.*<title>MIT TechTV &ndash; \(.*\)</title>.*:\1:p'`
  TITLE=`echo $TITLE | sed -e 's/[[:space:]]*$//'`
  FILENAME=${TITLE//['<>:\|']/_}.$EXTENSION
  
  echo "Processing $VIDPATH to $FILENAME"
  
  if [ "$TESTMODE" = false ] ; then
    curl -L -s -o "$FILENAME" "$VIDPATH"
  fi

done <<< "$URLS"


echo "All done!"
echo "$ORIGINALS original files processed"
echo "$BASICS basic MP4 files processed"