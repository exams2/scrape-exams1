#!/bin/bash -ex

echo "deleting empty files..."
find ./raw_pages/atasamente -type f -print0 | xargs -0 -n1 du -b | grep '^0[^0-9]' | cut -d0 -f2- | xargs -n1 -P1 -I{} echo {}
find ./raw_pages/atasamente -type f -print0 | xargs -0 -n1 du -b | grep '^0[^0-9]' | cut -d0 -f2- | xargs -n1 -P1 -I{} echo {} | xargs -n1 -I{} -P1 rm "{}"

echo "deleting files that redirect to 404"
grep -r "file_error.php" ./raw_pages/atasamente | cut -d: -f1
grep -r "file_error.php" ./raw_pages/atasamente | cut -d: -f1 | xargs -d'\n' -n1 -P1 -I{} rm "{}"
