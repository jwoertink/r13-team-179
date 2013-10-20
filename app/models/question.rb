class Question < ActiveRecord::Base
  mount_uploader :video, VideoUploader
  
  def self.random_by_category
    group('id, category').order("RANDOM()").limit(4)
  end
end
