require 'aws-sdk'

S3_BUCKET_NAME = 'belugacdn-logs-danstutzman'
S3_REGION = 'us-east-1'

config = JSON.parse(File.read('belugacdn-logs-appender.accesskey.json'))

s3 = Aws::S3::Client.new({
  credentials: Aws::Credentials.new(
    config.fetch('AccessKey').fetch('AccessKeyId'),
    config.fetch('AccessKey').fetch('SecretAccessKey')),
  region: S3_REGION,
})

s3.put_object({
  bucket:       S3_BUCKET_NAME,
  key:          'test-upload.txt',
  body:         "test\n",
})
