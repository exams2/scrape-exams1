#!/bin/bash
set -e
set +x
grep -r "adaugat de" . | cut -d: -f2- | sed 's/<[^>]*>//g'  | sort | uniq -c | sort -n
