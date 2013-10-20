class Question < ActiveRecord::Base
  mount_uploader :video, VideoUploader
end
