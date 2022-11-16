#!/bin/bash -ex

cat <<EOF
<!DOCTYPE html>
<html>
<head>
<title>exams scrape archive 2022</title>
</head>
<body>
<h1>exams scrape archive 2022</h1>
EOF

find raw_pages -type f -print0 | xargs -0 -I{} -n1 -P1 echo "<a href='{}'>{}</a>"

cat <<EOF
</body>
</html>
EOF
