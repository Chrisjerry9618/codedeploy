#!/bin/bash
HTTP_CODE=`curl --write-out '%{http_code}' -o /dev/null -m 10 -q -s http://localhost:80/`
echo $HTTP_CODE
if [ "$HTTP_CODE" -eq "201" ];
then
	echo deployment succceded with successcode 200 >> /root/success.txt
else

	exit 1 
fi
	
