#!/bin/bash

echo "Content-type: text/plain"
echo "Access-Control-Allow-Origin: *"
echo
if [ "$REQUEST_METHOD" = "POST" ]; then
    if [ "$CONTENT_LENGTH" -gt 0 ]; then
        read -r -d '' -n $CONTENT_LENGTH POST_DATA <& 0
    fi
else
    echo "No input received.";
    exit 0
fi

tmpfile=$(mktemp)
trap "rm ${tmpfile}" EXIT
printf '%s' "${POST_DATA}" > "${tmpfile}"

expect /usr/lib/cgi-bin/sml-expect.exp "${tmpfile}" | tail +3 | head -n -2 
exit 0
