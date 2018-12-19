#!/bin/bash
CODEDEPLOY_APPLICATION=chris-github-2
CODEDEPLOY_DEPLOYMENTGROUP=chris-github2-dep
BUCKET=testncode
app=`aws deploy list-deployments --application-name $CODEDEPLOY_APPLICATION  --deployment-group-name  $CODEDEPLOY_DEPLOYMENTGROUP --include-only-status Succeeded --region us-east-1 --output text | head -1 | awk '{print $2}'`
echo $app
KEY=`aws deploy get-deployment --deployment-id $app --region us-east-1 --query deploymentInfo.revision.s3Location.key`
#KEY="${KEY#\"}"
KEY1=$(echo $KEY | tr -d '"')
echo $KEY1
ROLLBACK_DEPLOYMENT=$(aws deploy create-deployment --application-name ${CODEDEPLOY_APPLICATION} --deployment-config-name CodeDeployDefault.OneAtATime --deployment-group-name ${CODEDEPLOY_DEPLOYMENTGROUP} --s3-location bucket=${BUCKET},bundleType=zip,key=${KEY1} --region us-east-1 --output text)
echo $ROLLBACK_DEPLOYMENT
echo "Redeploy happend" >> /root/rep.txt
