CarrierWave.configure do |config|
  config.enable_processing = false
  config.storage      = :aws
  config.aws_bucket   = ENV['S3_BUCKET_NAME']
  config.aws_acl      = :public_read
  config.asset_host   = "https://s3-us-west-2.amazonaws.com/datingscene"
  config.aws_authenticated_url_expiration = 60 * 60 * 24 * 365
  
  config.aws_credentials = {
    access_key_id:       ENV['S3_ACCESS_KEY_ID'],
    secret_access_key:   ENV['S3_SECRET_KEY']
  }
end