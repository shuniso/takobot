#!/bin/zsh

out="/cap/tobus.jpg"
cd `dirname $0`

rm .$out
# 都バス
/usr/local/pyenv/versions/qtenv-py2.7.11/bin/webkit2png  -x 400 1200 "http://tobus.jp/sp/blsys/stop?routecode=175&poleno=2&stopid=2030&ln=ja" | convert - -crop 400x1000+1+200 .$out  >/dev/null 2>&1


echo -n `pwd`$out
