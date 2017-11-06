#!/bin/bash -ex

# Run first: brew install awscli

IAM_USERNAME=belugacdn-logs-appender
BUCKET_NAME=belugacdn-logs-danstutzman

if [ ! -e $IAM_USERNAME.iam.json ]; then
  aws iam create-user --user-name $IAM_USERNAME \
    | tee $IAM_USERNAME.iam.json
fi

if [ ! -e $IAM_USERNAME.accesskey.json ]; then
  aws iam create-access-key --user-name $IAM_USERNAME \
    | tee $IAM_USERNAME.accesskey.json
fi

aws s3 mb s3://$BUCKET_NAME

tee policy.json <<EOF
{
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:PutObject"],
      "Resource": "arn:aws:s3:::$BUCKET_NAME/*"
    }
  ]
}
EOF
aws iam put-user-policy --user-name $IAM_USERNAME \
 --policy-name can-upload-to-s3 \
 --policy-document file://policy.json
rm policy.json


# aws iam delete-user-policy --user-name belugacdn-logs-appender --policy-name can-upload-to-s3
# aws iam list-access-keys --user-name belugacdn-logs-appender
# aws iam delete-access-key --user-name belugacdn-logs-appender --access-key-id OUTPUT-FROM-PREVIOUS-COMMAND
# aws iam delete-user --user-name belugacdn-logs-appender
# rm -f belugacdn-logs-appender.accesskey.json belugacdn-logs-appender.iam.json
