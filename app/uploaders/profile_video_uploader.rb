# encoding: utf-8
class ProfileVideoUploader < CarrierWave::Uploader::Base
  storage :aws
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
