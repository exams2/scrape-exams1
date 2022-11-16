#!/bin/bash -ex

ARG=$1
ID_FACULTATE="$(echo $ARG | cut -f1 -d',')"
TAG_MATERIE="$(echo $ARG | cut -f2 -d',')"
FILENAME_OUT="raw_pages/materii/$ID_FACULTATE,$TAG_MATERIE.html"
./scurl.sh --get \
	--data-urlencode "tags=$TAG_MATERIE" \
	--data-urlencode "id=$ID_FACULTATE"  \
	-o "$FILENAME_OUT" \
	http://exams.ro/scripts/menu_result.php
