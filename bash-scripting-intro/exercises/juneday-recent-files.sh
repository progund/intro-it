#!/bin/bash

PREFIX="http://wiki.juneday.se"
FILES_URL="http://wiki.juneday.se/mediawiki/index.php/Special:ListFiles"

for file_url in $(GET "$FILES_URL" |
                         grep TablePager_col_img_name |
                         cut -d '"' -f8)
do
    echo "$PREFIX$file_url"
done
