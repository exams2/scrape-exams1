#!/bin/bash -ex

ARG=$1
ID_SUBIECT="$(echo $ARG | cut -f1 -d'/')"
FILENAME="$(echo $ARG | cut -f2 -d'/')"
mkdir -p raw_pages/atasamente/$ID_SUBIECT
FILENAME_OUT="raw_pages/atasamente/$ID_SUBIECT/$FILENAME"
./scurl.sh --get \
	--data-urlencode "file=$ARG" \
	-o "$FILENAME_OUT" \
	http://exams.ro/scripts/downloads.php
