#fswebcam -r 1280x720 --jpeg 100 $2/tmp_$1.jpg > /dev/null 2>&1
fswebcam --set brightness=10% -r 640x480 $2/tmp_$1.jpg > /dev/null 2>&1
