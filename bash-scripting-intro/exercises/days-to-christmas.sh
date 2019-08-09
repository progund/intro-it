#!/bin/bash

YEAR=$(date "+%Y")
CHRISTMAS="$YEAR-12-24"
TODAY_NR=$(date "+%j")
CHRISTMAS_NR=$(date -d "$CHRISTMAS" +%j)

DAYS_TO_CHRISTMAS=$((CHRISTMAS_NR - TODAY_NR));

if (( $DAYS_TO_CHRISTMAS > 0 ))
then
    echo "Christmas is in $DAYS_TO_CHRISTMAS days";
elif (( $DAYS_TO_CHRISTMAS < 0 ))
then
    echo "Christmas has already been";
else
    echo "Merry Christmas!";     
fi

