#!/bin/sh

/usr/bin/genshdoc
EXITCODE="$?"
[ "$EXITCODE" = 0 ] && RESULT=OK || RESULT=ERROR
echo ::set-output name=result::$RESULT
exit "$EXITCODE"
