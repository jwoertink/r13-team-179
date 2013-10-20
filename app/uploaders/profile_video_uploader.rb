# encoding: utf-8
class ProfileVideoUploader < CarrierWave::Uploader::Base
  storage :aws
  aws_bucket ENV['S3_BUCKET_NAME']
  aws_acl :public_read
  asset_host "https://s3-us-west-2.amazonaws.com/datingscene"
  aws_authenticated_url_expiration 60 * 60 * 24 * 365
  aws_credentials {access_key_id: ENV['S3_ACCESS_KEY_ID'], secret_access_key: ENV['S3_SECRET_KEY']}
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
