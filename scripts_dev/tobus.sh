#!/usr/local/bin/zsh

out="/cap/tobus.jpg"
cd `dirname $0`

webkit2png --ignore-ssl-check "http://tobus.jp/sp/blsys/stop?routecode=175&poleno=2&stopid=2030&ln=ja" -F --delay=0 -o tmp >/dev/null 2>&1
cat tmp-full.png | convert - -crop 680x1000+1+170 .$out >/dev/null 2>&1
rm tmp-full.png

echo -n `pwd`$out
