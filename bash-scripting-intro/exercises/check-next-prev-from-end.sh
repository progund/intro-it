#!/bin/bash

BASE_URL="http://wiki.juneday.se/mediawiki/index.php/"

START_PAGE="ITIC:Privacy_on_the_web_-_Exercise"

page=$START_PAGE
next=$(GET "${BASE_URL}${START_PAGE}" | tr '•' '\n'|grep '">Next'| grep -Po '\K"/mediawiki.*" ')
prev=$(GET "${BASE_URL}${START_PAGE}" | grep Previous| tr '•' '\n'|grep Previous | grep -Po '\K"/mediawiki.*"'  | cut -d ' ' -f1)
while [[ "$prev" =~ .*/mediawiki.* ]]
do
    echo $BASE_URL$page
    echo "$page has:"
    echo " next: $next"
    echo " prev: $prev"
    page=$(echo "$prev" | cut -d '/' -f4 | tr -d '"')
    next=$(GET "${BASE_URL}${page}" | tr '•' '\n'|grep '">Next'| grep -Po '\K"/mediawiki.*" '  | cut -d ' ' -f1)
    prev=$(GET "${BASE_URL}${page}" | grep Previous| tr '•' '\n'|grep Previous | grep -Po '\K"/mediawiki.*"' | cut -d ' ' -f1)
    echo " *** "
done

