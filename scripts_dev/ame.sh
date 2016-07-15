#!/usr/local/bin/zsh

out="/cap/ame.jpg"
cd `dirname $0`

webkit2png --ignore-ssl-check "http://tokyo-ame.jwa.or.jp/" -F --delay=0 -o tmp >/dev/null 2>&1
cat tmp-full.png | convert - -crop 450x250+180+180 .$out >/dev/null 2>&1
rm tmp-full.png

echo -n `pwd`$out
