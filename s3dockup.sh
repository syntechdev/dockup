#
# Based on Dockup (= Docker + Backup): https://github.com/tutumcloud/dockup

# running this Docker container will backup this OpenVPN server to S3 based on the settings in s3dockup.env

AWS_ACC_ID="`grep AWS_ACC s3dockup.env`" # ; echo AWS_ACC_ID: $AWS_ACC_ID
AWS_SEC_KEY="`grep AWS_SEC s3dockup.env`" # ; echo AWS_SEC_KEY: $AWS_SEC_KEY
S3_BUCKET=`grep S3_BUC s3dockup.env | sed "s/^S.*=//"` # ; echo S3_BUCKET: $S3_BUCKET

docker run --rm --env-file s3dockup.env --volumes-from data-volume -v /home/core:/home/core --name dockup tutum/dockup:latest

echo "*** Show contents of S3 Backup Bucket ***"
echo
docker run --rm -t -i -e $AWS_ACC_ID -e $AWS_SEC_KEY --name dockup tutum/dockup:latest aws s3 ls ${S3_BUCKET}/
