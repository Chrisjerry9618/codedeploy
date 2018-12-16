#!/bin/bash
CODEDEPLOY_APPLICATION=chris-github-2
CODEDEPLOY_DEPLOYMENTGROUP=chris-github2-dep
BUCKET=testncode
HTTP_CODE=`curl --write-out '%{http_code}' -o /dev/null -m 10 -q -s http://localhost:80`
echo $HTTP_CODE
if [ "$HTTP_CODE" -eq "200" ];
then
	echo deployment succceded with successcode 200 >> /root/success.txt
else
	sh /opt/chris/redeploy.sh
fi
	
