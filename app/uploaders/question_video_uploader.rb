# encoding: utf-8
class QuestionVideoUploader < CarrierWave::Uploader::Base
  storage :file
  
  def store_dir
    "#{Rails.root}/../../shared/#{model.class.to_s.underscore}/#{model.category}/"
  end

end
