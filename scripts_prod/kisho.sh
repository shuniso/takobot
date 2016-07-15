#!/bin/zsh

out="/cap/kisho.jpg"
cd `dirname $0`

rm .$out
# 気象庁
/usr/local/pyenv/versions/qtenv-py2.7.11/bin/webkit2png -d :1 "http://www.jma.go.jp/jp/yoho/319.html" | convert - -crop 598x307+12+235 .$out  >/dev/null 2>&1

echo -n `pwd`$out
