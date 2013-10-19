CarrierWave.configure do |config|
  config.enable_processing = false
  config.storage = :fog
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['S3_ACCESS_KEY_ID'],
    :aws_secret_access_key  => ENV['S3_SECRET_KEY'],
    :host                   => 'datingscene.me'
  }
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
  config.fog_directory  = ENV['S3_BUCKET_NAME']
  config.asset_host     = "https://datingscene.s3.amazonaws.com"
end