#!/usr/local/bin/zsh

out="/cap/kisho.jpg"
cd `dirname $0`

webkit2png --ignore-ssl-check "http://www.jma.go.jp/jp/yoho/319.html" -F --delay=0 -o tmp >/dev/null 2>&1
cat tmp-full.png | convert - -crop 600x430+10+330  .$out >/dev/null 2>&1
rm tmp-full.png

echo -n `pwd`$out
