#!/bin/bash
CODEDEPLOY_APPLICATION=chris-github-2
CODEDEPLOY_DEPLOYMENTGROUP=chris-github2-dep
BUCKET=testncode
app=`aws deploy list-deployments --application-name $CODEDEPLOY_APPLICATION  --deployment-group-name  $CODEDEPLOY_DEPLOYMENTGROUP --include-only-status Succeeded --region us-east-1 --output text | head -1 | awk '{print $2}'`
echo $app
KEY=`aws deploy get-deployment --deployment-id $app --query deploymentInfo.revision.s3Location.key --region us-east-1 --output text | head -1 | awk '{print $2}'`
echo $KEY
#ROLLBACK_DEPLOYMENT=$(aws deploy create-deployment --application-name ${CODEDEPLOY_APPLICATION} --deployment-config-name CodeDeployDefault.OneAtATime --deployment-group-name ${CODEDEPLOY_DEPLOYMENTGROUP} --s3-location bucket=${BUCKET},bundleType=zip,key=${KEY} --region us-east-1 --output text)
echo $ROLLBACK_DEPLOYMENT
echo "Redeploy happend" >> /root/rep.txt
