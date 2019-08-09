#!/bin/bash

YEAR=$(date "+%Y")
DEFAULT_DATE="$YEAR-12-24"
TODAY_NR=$(date "+%j")
days_to_date ()
{
    DATE=$(date -d "$1" +%j);
    DAYS_TO_DATE=$((DATE - TODAY_NR));
    if (( $DAYS_TO_DATE > 0 ))
    then
        echo "$1 is in $DAYS_TO_DATE days";
    elif (( $DAYS_TO_DATE < 0 ))
    then
        echo "$1 has already been";
    else
        echo "$1 is today!";
    fi
}

usage()
{
    echo "Usage: $0 [mm-dd]" >&2
    echo " No arguments shows day to Christmas" >&2
    echo " An argument of e.g. 12-31 shows" >&2
    echo "the number of days to that date this year" >&2
    exit 1
}

# Action begins here...

# Sanity check - invalid date, show usage
date -d "$YEAR-$1" &> /dev/null || usage

if (( $# == 1 )) # One argument?
then
    days_to_date "$YEAR-$1"
elif (( $# == 0 )) # no arguments, use Christmas
then
    days_to_date "$DEFAULT_DATE"
else # too many arguments, show usage
    usage
fi
