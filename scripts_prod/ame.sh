#!/bin/zsh

out="/cap/ame.jpg"
cd `dirname $0`

rm .$out
/usr/local/pyenv/versions/qtenv-py2.7.11/bin/webkit2png -d :1 -F javascript "http://tokyo-ame.jwa.or.jp/" | convert - -crop 750x400+40+90 .$out  >/dev/null 2>&1

echo -n `pwd`$out
