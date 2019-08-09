#!/bin/bash

#  An associative array
#+ with key-value pairs
declare -A VARS
VARS[HOME]="$HOME"
VARS[USER]="$USER"
VARS[SHELL]="$SHELL"
# etc etc

# Loop over each key:
for var in "${!VARS[@]}"
do
    echo "$var: ${VARS[$var]}"
done

echo "==========="
#  Alternative way:
#  You can declare the map and its key-value pairs
#+ directly:

declare -A map=(
    [HOME]="$HOME"
    [USER]="$USER"
    [SHELL]="$SHELL"
)
for var in "${!map[@]}"
do
    echo "$var: ${map[$var]}"
done
