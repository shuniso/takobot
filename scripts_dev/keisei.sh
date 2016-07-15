#!/usr/local/bin/zsh

out="/cap/keisei.jpg"
cd `dirname $0`

# webkit2png --ignore-ssl-check "http://keiseibus.bus-navigation.jp/wgsys/wgs/bus.htm?tabName=searchTab&selectedLandmarkCatCd=&from=%E7%B7%8F%E5%90%88%E3%83%AC%E3%82%AF%E3%83%AA%E3%82%A8%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E5%85%AC%E5%9C%92&fromType=1&to=%E8%91%9B%E8%A5%BF%E8%87%A8%E6%B5%B7%E5%85%AC%E5%9C%92%E9%A7%85&toType=1&locale=ja&fromlat=35.635123067179094&fromlng=139.7876663546055&tolat=&tolng=&fromSignpoleKey=&routeLayoutCd=&bsid=&fromBusStopCd=&toBusStopCd=&mapFlag=false&existYn=N" -F --delay=0 -o tmp >/dev/null 2>&1
webkit2png --ignore-ssl-check "http://localhost:40001/wgsys/wgs/bus.htm?tabName=searchTab&selectedLandmarkCatCd=&from=%E7%B7%8F%E5%90%88%E3%83%AC%E3%82%AF%E3%83%AA%E3%82%A8%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E5%85%AC%E5%9C%92&fromType=1&to=%E8%91%9B%E8%A5%BF%E8%87%A8%E6%B5%B7%E5%85%AC%E5%9C%92%E9%A7%85&toType=1&locale=ja&fromlat=35.635123067179094&fromlng=139.7876663546055&tolat=&tolng=&fromSignpoleKey=&routeLayoutCd=&bsid=&fromBusStopCd=&toBusStopCd=&mapFlag=false&existYn=N" -F --delay=0 -o tmp >/dev/null 2>&1
cat tmp-full.png | convert - -crop 800x700+0+100 .$out >/dev/null 2>&1
rm tmp-full.png

echo -n `pwd`$out
