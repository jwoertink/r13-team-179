# encoding: utf-8
class QuestionVideoUploader < CarrierWave::Uploader::Base

  def store_dir
    "#{Rails.root}/../../shared/#{model.class.to_s.underscore}/#{model.category}/"
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
