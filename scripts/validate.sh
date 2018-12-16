#!/bin/bash
CODEDEPLOY_APPLICATION=chris-github-2
CODEDEPLOY_DEPLOYMENTGROUP=chris-github2-dep
BUCKET=testncode
HTTP_CODE=`curl --write-out '%{http_code}' -o /dev/null -m 10 -q -s http://localhost:80`
echo $HTTP_CODE
if [ "$repsonse" -eq "200" ];
then
	echo "deployment succceded with successcode 200" >> /root/success.txt
else
	app=$(aws deploy list-deployments --application-name $CODEDEPLOY_APPLICATION  --deployment-group-name  $CODEDEPLOY_DEPLOYMENTGROUP --include-only-status Succeeded --region us-east-1 --output text | head -1 | awk '{print $2}')
	KEY=$(aws deploy get-deployment --deployment-id $app --query deploymentInfo.revision.s3Location.key --region us-east-1)
	ROLLBACK_DEPLOYMENT=$(aws deploy create-deployment --application-name ${CODEDEPLOY_APPLICATION} --deployment-config-nam CodeDeployDefault.OneAtATime --deployment-group-name ${CODEDEPLOY_DEPLOYMENTGROUP} --s3-location bucket=${BUCKET},bundleType=zip,key=${KEY} --region us-east-1 --output text | head -1 | awk '{print $2}')
	echo "Redeploy happened" >> /root/redeploy.txt
fi
	
