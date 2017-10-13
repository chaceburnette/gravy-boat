CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     'AKIAIKI4IKEN4DJDXBWA', #ENV['S3_ACCESS_KEY_ID'],
    aws_secret_access_key: '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', #ENV['S3_ACCESS_KEY_SECRET'],
    region: 			   'us-east-2' #ENV['S3_REGION']
  }
  config.fog_directory  = 'gravy-train-staging' #ENV['S3_BUCKET']
  config.cache_dir = "#{Rails.root}/tmp/uploads"
end