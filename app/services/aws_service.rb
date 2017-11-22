class AWSService

  def self.credentials
    Aws::Credentials.new(ENV['S3_ACCESS_KEY_ID'], ENV['S3_ACCESS_KEY_SECRET'])
  end

  def self.bucket_name
    ENV['S3_BUCKET']
  end

  def self.region
    ENV['S3_REGION']
  end

  def self.create_sts_client
    Aws::STS::Client.new(
      region: region,
      credentials: credentials
    )
  end

  def self.create_s3_client
    Aws::S3::Client.new(
      region: region,
      credentials: credentials
    )
  end

  def self.create_s3_resource
    Aws::S3::Resource.new(
      region: region,
      credentials: credentials
    )
  end

  def self.get_temporary_credentials
    create_sts_client.get_federation_token({
      name: 'tempUser',
      duration_seconds: 1800,
      policy: bucket_policy
    })
  end

  def self.bucket_policy
    '{
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": [
            "s3:PutObject",
            "s3:PutObjectAcl"
          ],
          "Effect": "Allow",
          "Resource": "arn:aws:s3:::' + bucket_name + '/*"
        }
      ]
    }'
  end
end